-------------------------------------------------------------------------------
--
-- Title       : ReplyDelay
-- Design      : contrdme
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : replydelay.vhd
-- Generated   : Tue Oct 12 16:40:17 2010
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
--{entity {ReplyDelay} architecture {ReplyDelay_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity ReplyDelay is
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
end ReplyDelay;

--}} End of automatically maintained section

architecture ReplyDelay_arch of ReplyDelay is	  	

	-------------------Counter-----------------------
	signal DelayCounter : natural;	
	signal DelayRegister : std_logic_vector(15 downto 0);	
	signal AdcMaxRegister : std_logic_vector(11 downto 0);	   
	-------------------------------------------------	   
	
	------------------Done---------------------------
	signal DoneStrobe : std_logic;	   
	  
	-------------------------------------------------	  
	
	-------------------------------------------------	 
	signal StartFlag : std_logic;  
	signal EnableCounter : std_logic;

	
	signal KickFlag : std_logic;		
	signal KickCpu :  STD_LOGIC;  	
	signal WaitStrobe : std_logic;	  		
	
	signal StopFlag : std_logic;		 
	
	signal Wdt : std_logic := '0';			   
	
	
	----------------------------		   
	signal InternalStart : std_logic;  
	signal InternalStop : std_logic;
	signal StopEnable : std_logic;
	signal StartEnable : std_logic;		  
	
	signal StartCounter : std_logic;
	signal StopCounter : std_logic;		
	
	signal ClrWaitStrobe : std_logic;	  
	
	signal EnableWdt : std_logic;
	

	
	
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
	
	
	--Kick--	
	process(CLK_CPU)
	begin 	
		if rising_edge(CLK_CPU) then  		
			KickCpu <= Kick;
		end if;
	end process;	
	
	
	process(CLK, RST)
	begin 
		if RST = '0' then 
			KickFlag <= '0';		
		elsif rising_edge(CLK) then  	
				KickFlag <= KickCpu;	
		end if;
	end process;	
	

	
	process(CLK, RST, DoneStrobe)
	begin 
		if RST = '0' or DoneStrobe = '1' then 
			WaitStrobe <= '0';		
		elsif rising_edge(CLK) then   
			if KickFlag = '1' then				
				WaitStrobe <= '1';		
			end if;	
		end if;
	end process;						  
	

	------------------------------------------------- 		
	
	-----------------WDT-----------------------------	
	
	process(CLK, RST)
	begin 
		if RST = '0' then 
			EnableWdt <= '0';		
		elsif rising_edge(CLK) then  	
			if StopCounter = '1' then
				EnableWdt <= '0';
			elsif KickFlag = '1' then	
				EnableWdt <= '1';				
			end if;	
		end if;
	end process;		
	
	
	Wdt <= (not	BlankKs) and  StartEnable and EnableWdt;
	
	-------------------------------------------------
	
	--Start--			
	process(CLK, RST)
	begin 
		if RST = '0' then 
			StartFlag <= '0';		
		elsif rising_edge(CLK) then  	
				StartFlag <= Start;	
		end if;
	end process;		
		
	InternalStart <=  BlankKs and ((not StartFlag) and Start) and WaitStrobe;			
	StartCounter <= InternalStart and (not StopEnable);

	--------------------------------------------------		  
	
	--------StartEnable-------------------------------
	process(CLK, RST, KickFlag)
	begin 
		if RST = '0' or KickFlag = '1' then 
			StartEnable <= '0';		
		elsif rising_edge(CLK) then  	
			if StartCounter = '1' then
				StartEnable <= '1';	
			end if;	
		end if;
	end process;					 
	
	--------------------------------------------------	   
	
	--Stop--			
	process(CLK, RST)
	begin 
		if RST = '0' then 
			StopFlag <= '0';		
		elsif rising_edge(CLK) then  	
				StopFlag <= Stop;	
		end if;
	end process;		
		
	InternalStop <=  BlankKs and Stop and WaitStrobe;	 
	
	--------------------------------------------------		 	

	
	--StopEnable--------------------------------------			
	process(CLK, RST, KickFlag)
	begin 
		if RST = '0' or KickFlag = '1' then 
			StopEnable <= '0';		
		elsif rising_edge(CLK) then  	
			if StartEnable = '1' then
				StopEnable <= '1';	
			end if;	
		end if;
	end process;		
	
	StopCounter <= InternalStop and StopEnable;		

	--------------------------------------------------	
	
	--DoneStrobe--------------------------------------			
	process(CLK, RST, KickFlag)
	begin 
		if RST = '0' or KickFlag = '1' then 
			DoneStrobe <= '0';		
		elsif rising_edge(CLK) then  	
			if StopCounter = '1' or Wdt = '1' then
				DoneStrobe <= '1';	   
			end if;	
		end if;
	end process;		
	
	Done <= DoneStrobe;
	--------------------------------------------------		  
	
	------EnbleCounter--------------------------------
	
	process(CLK, RST)
	begin 
		if RST = '0' then 
			EnableCounter <= '0';		
		elsif rising_edge(CLK) then  	
			if StartCounter = '1' then
				EnableCounter <= '1';	   
			elsif StopCounter = '1' or Wdt = '1' then	
				EnableCounter <= '0';					
			end if;	
		end if;
	end process;		
	
	--------------------------------------------------		
	
	----------------Counter-------------------------			 
	process(CLK, RST)
	begin 
		if RST = '0' then 	
			DelayCounter <= 0;				
		elsif rising_edge(CLK) then   
			if EnableCounter = '1' then	 
				DelayCounter <= DelayCounter + 1;	
			else
				DelayCounter <= 0;	
			end	if;		 								
		end if;
	end process;								 
	-------------------------------------------------	
	
	
	------SaveResult----------------------------------
	
	process(CLK, RST, KickFlag)
	begin 
		if RST = '0' then    
			DelayRegister <= (others => '0'); 	
		elsif rising_edge(CLK) then   	   
			if StopCounter = '1' then
				DelayRegister <= CONV_STD_LOGIC_VECTOR(DelayCounter, 16);  
			elsif Wdt = '1' or KickFlag = '1' then	
				DelayRegister <= CONV_STD_LOGIC_VECTOR(0, 16);  
			end if;	
		end if;
	end process;	
	--------------------------------------------------			 	
	 
	----------AdcMax--------------------------
	process(CLK, RST, KickFlag)
	begin 
		if RST = '0' or KickFlag = '1' then    
			AdcMaxRegister <= (others => '0');	  	
		elsif rising_edge(CLK) then   	 
			if BlankKs = '1' and AdcMaxEdge = '1' then
				AdcMaxRegister <= AdcMax;				  			
			end if;	
		end if;
	end process;
	
	
	------------------------------------------		  

end ReplyDelay_arch;
