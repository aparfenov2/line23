-------------------------------------------------------------------------------
--
-- Title       : ReplyDelayRev1
-- Design      : contrdme
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : ReplyDelayRev1.vhd
-- Generated   : Thu Mar 17 13:34:33 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ReplyDelayRev1} architecture {ReplyDelayRev1_arch}}
library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;


entity ReplyDelayRev1 is
	 port(
		 CLK : in STD_LOGIC;	 
		 CLK_CPU : in STD_LOGIC;
		 
		 RST : in STD_LOGIC;		 
		 
		 RD : in STD_LOGIC;
		 Address : in STD_LOGIC_VECTOR(1 downto 0);
		 Data : out STD_LOGIC_VECTOR(15 downto 0);   		 
		 
		 BlankKs : in STD_LOGIC;
		 Kick : in STD_LOGIC;  
	 
		 
		 Start : in STD_LOGIC;	  
		 Stop  : in std_logic;

		 
		 AdcMaxEdge : in STD_LOGIC;
		 
		 AdcMax : in STD_LOGIC_VECTOR(11 downto 0);
		 
		 Done : out STD_LOGIC
		 
	     );
end ReplyDelayRev1;

--}} End of automatically maintained section

architecture ReplyDelayRev1_arch of ReplyDelayRev1 is		
	-------------------Counter-----------------------
	signal DelayCounter : natural;	
	signal DelayRegister : std_logic_vector(15 downto 0);	
	signal AdcMaxRegister : std_logic_vector(11 downto 0);	   
	-------------------------------------------------	  
	
	type TState is (stIdle, stWaitStart, stWaitStop, stError, stSaveResult, stDone);	
	
	signal state : TState; 
	signal next_state : TState;	  								  
	
	signal intKick, intStart, intStop : std_logic;		
	
	signal Wdt : std_logic;	
	
	------------------Done---------------------------
	signal DoneStrobe : std_logic;	   				 	  
	-------------------------------------------------		
	
begin

	------------------Read By NIOS-------------------
	process(CLK_CPU, RST)
	begin		 
		if RST = '0' then  			
			null;		  		
		elsif rising_edge(CLK_CPU) then
			if RD = '0' then
				case Address is
					when "00" =>
						Data <= DelayRegister;
					when "01" =>
						Data(11 downto 0) <= AdcMaxRegister;  	   
					when others => null;
				end case;
			end if;
		end if;
	end process;	 
													 
	------------------------------------------------- 	
	
	process(CLK, RST)		
	begin  			 
		if RST = '0' then 		   
			state <= stIdle;		
		elsif rising_edge(CLK) then			
			state <= next_state;		
		end if;	
	end process;	 	
	
	process(CLK, RST)		
	begin  			 
		if RST = '0' then 		   
			intKick <= '0';
			intStart <= '0';
			intStop	<= '0';	
			Wdt <= '0';
		elsif rising_edge(CLK) then			
			intKick <= Kick;
			intStart <= Start;
			intStop	<= Stop;	
			if (state = stWaitStop and BlankKs = '0') then
				Wdt <= '1';
			else
				Wdt <= '0';	
			end if;				
		end if;	
	end process;		
	
	process(state, intKick, intStart, intStop, Wdt)		
	begin  		
		--if rising_edge(CLK) then
			case state is
				when stIdle =>
					if ( intKick = '1' ) then
						next_state <= stWaitStart;
					else
						next_state <= stIdle;
					end if;	
					
				when stDone =>
					if ( intKick = '1' ) then
						next_state <= stWaitStart;
					else
						next_state <= stDone;						
					end if;		
					
				when stWaitStart =>
					if ( intStart = '1' ) then
						next_state <= stWaitStop;
					else
						next_state <= stWaitStart;						
					end if;	
					
				when stWaitStop =>
					if ( intStop = '1' ) then
						next_state <= stSaveResult;	
					elsif Wdt = '1' then 
						next_state <= stError;	
					else
						next_state <= stWaitStop;						
					end if;		
					
				when stError =>
					--if ( '1' = '1' ) then
						next_state <= stDone;
					--end if;		
					
				when stSaveResult =>
					--if ( '1' = '1' ) then
						next_state <= stDone;
					--end if;				
				when OTHERS =>
					--next_state <= stError;
					null;
			end case;		
		--end if;
	end process;	   
	
	----------------Counter-------------------------			 
	process(CLK, RST)
	begin 
		if RST = '0' then 	
			DelayCounter <= 0;				
		elsif rising_edge(CLK) then   
			if state = stWaitStop then	 
				DelayCounter <= DelayCounter + 1;	
			elsif state = stDone then
				DelayCounter <= 0;	
			end	if;		 								
		end if;
	end process;								 
	-------------------------------------------------		
	
	------SaveResult----------------------------------
	
	process(CLK, RST)
	begin 
		if RST = '0' then    
			DelayRegister <= (others => '0'); 	
		elsif rising_edge(CLK) then   	   
			if state = stSaveResult then
				DelayRegister <= CONV_STD_LOGIC_VECTOR(DelayCounter, 16);  
			elsif state = stWaitStart then
				DelayRegister <= (others => '0');
			end if;	
		end if;
	end process;	
	--------------------------------------------------		
	
	------------AdcMax--------------------------
	process(CLK, RST, intKick)
	begin 
		if RST = '0' or intKick = '1' then    
			AdcMaxRegister <= (others => '0');	  	
		elsif rising_edge(CLK) then   	 
			if BlankKs = '1' and AdcMaxEdge = '1' then
				AdcMaxRegister <= AdcMax;				  			
			end if;	
		end if;
	end process;			 
	
	------------------------------------------		
	
	-----------DoneStrobe---------------------			
	process(CLK, RST)
	begin 
		if RST = '0' then 
			DoneStrobe <= '0';		
		elsif rising_edge(CLK) then  	
			if state = stDone then
				DoneStrobe <= '1';	   
			elsif state = stWaitStart then	
				DoneStrobe <= '0';						
			end if;	
		end if;
	end process;		
	
	Done <= DoneStrobe;
	--------------------------------------------------		

end ReplyDelayRev1_arch;
