-------------------------------------------------------------------------------
--
-- Title       : RecieverDelay
-- Design      : KDME
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : RecieverDelay.vhd
-- Generated   : Wed May 19 11:05:25 2010
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
--{entity {RecieverDelay} architecture {RecieverDelay_arch}}


library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity RecieverDelay is
	 port(
		 CLK : in STD_LOGIC;
		 CLK_CPU : in STD_LOGIC;
		 RST : in STD_LOGIC;
		 RD : in STD_LOGIC;
		 Stop : in STD_LOGIC;
		 Start : in STD_LOGIC;		
		 Kick : in std_logic;
		 Address : in STD_LOGIC_VECTOR(1 downto 0);
		 AdcMax : in STD_LOGIC_VECTOR(11 downto 0);
		 Done : out STD_LOGIC;
		 Data : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end RecieverDelay;



architecture RecieverDelay_arch of RecieverDelay is		 
	
	-------------------Counter-----------------------
	signal DelayCounter : natural;	
	signal DelayRegister : std_logic_vector(15 downto 0);	
	signal AdcMaxRegister : std_logic_vector(11 downto 0);
	signal JustAdcMAxRegister : std_logic_vector(11 downto 0); 
	-------------------------------------------------	   
	
	------------------Done---------------------------
	signal DoneStrobe : std_logic;	   
	  
	-------------------------------------------------	  
	
	-------------------------------------------------	 
	signal StartFlag : std_logic;  
	signal ClrStart : std_logic;
	
	signal KickFlag : std_logic;
	--signal ClrKick : std_logic;			
	
	signal StopFlag : std_logic;
	
	
	
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
					when "10" =>
						Data(11 downto 0) <= JustAdcMaxRegister;  
					when others => null;
				end case;
			end if;
		end if;
	end process	;
	
	------------------------------------------------- 	
	
	--Save AdcMax------------------------------------
	process(Stop, RST)
	begin 
		if RST = '0' then 
			JustAdcMAxRegister <= (others => '0');		
		elsif rising_edge(Stop) then  
			JustAdcMAxRegister <= AdcMax;	
		end if;
	end process;	
	
	-------------------------------------------------
	
	--Start--
	
	process(Start, RST, ClrStart)
	begin 
		if RST = '0' or ClrStart = '1' then 	 
			StartFlag <= '0';				
		elsif rising_edge(Start) then  
			if KickFlag = '1' then
				StartFlag <= '1';  	   							
			end	if;
		end if;
	end process;	   
	----		
	
	--Kick--	
	process(Kick, RST, ClrStart)
	begin 
		if RST = '0' or ClrStart = '1' then 
			KickFlag <= '0';		
		elsif rising_edge(Kick) then  
			KickFlag <= '1';		
		end if;
	end process;	
	----				   
	
	---Stop---
	process(Stop, RST, ClrStart)
	begin 
		if RST = '0' or ClrStart = '1' then 
			StopFlag <= '0';		
		elsif rising_edge(Stop) then 
			if KickFlag = '1' then
				StopFlag <= '1';	
			end if;	
		end if;
	end process;		
	
	------
	
	--Done--	
	process(ClrStart, RST, Kick)
	begin 
		if RST = '0' or Kick = '1' then    
			AdcMaxRegister <= (others => '0');
			Done <= '0';		
		elsif rising_edge(ClrStart) then   	
			AdcMaxRegister <= AdcMax;
			Done <= '1';				  			
		end if;
	end process;	
	----		 
	
	--set up the DelayRegister--
	process(StopFlag, RST, Kick)
	begin 
		if RST = '0' or Kick = '1' then    
			DelayRegister <= (others => '0'); 	
		elsif rising_edge(StopFlag) then   	
			DelayRegister <= CONV_STD_LOGIC_VECTOR(DelayCounter, 16);  			  			
		end if;
	end process;
	
	
	----------------------------
	
	

	
	
	-------------------------------------------------
	
	process(CLK, RST)
	begin 
		if RST = '0' then 	
			DelayCounter <= 0;			
			ClrStart <= '0';				
		elsif rising_edge(CLK) then   
			if StartFlag = '1' then	
				if StopFlag = '0' then 
					DelayCounter <= DelayCounter + 1;
					ClrStart <= '0';
				else	
					DelayCounter <= 0;  
					ClrStart <= '1';							
			    end	if;					
			else	
				ClrStart <= '0';			
			end	if;		 								
		end if;
	end process;	
						   	
	
	-------------------------------------------------
															 
end RecieverDelay_arch;
