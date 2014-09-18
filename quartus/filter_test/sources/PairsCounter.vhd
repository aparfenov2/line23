-------------------------------------------------------------------------------
--
-- Title       : PairsCounter
-- Design      : KDME
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : PairsCounter.vhd
-- Generated   : Fri Apr  9 17:23:22 2010
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
--{entity {PairsCounter} architecture {PairsCounter_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;	
use IEEE.std_logic_unsigned.all;

entity PairsCounter is
	port(			
		 CLK : in std_logic;
	 	 RST : in std_logic;
		 Input : in STD_LOGIC;
		 Data : out STD_LOGIC_vector(16 downto 0);	 
		 Kick : in std_logic;
		 Done : out std_logic
		 
	     );
end PairsCounter;

--}} End of automatically maintained section

architecture PairsCounter_arch of PairsCounter is  


	signal ImpulseCounter : std_logic_vector(16 downto 0); 
	signal DelayCounter : natural;					  
	signal ImpulseCounterDone : std_logic; 						
	signal Result : std_logic_vector(16 downto 0);
	constant MeasurePriod : natural := 7999999; 
	
	
	signal KickFlag : std_logic;
	signal ClrKick : std_logic;	  
	
	
	
begin	 				  
			
	--Kick--	
	process(Kick, RST, ClrKick)
	begin 
		if RST = '0' or ClrKick = '1' then 
			KickFlag <= '0';		
		elsif rising_edge(Kick) then  
			KickFlag <= '1';		
		end if;
	end process;	
	----					  
	
	
	CountPeriod: process(CLK, RST)
	begin
		if RST = '0' then  
			DelayCounter <= 0; 
			ClrKick <= '0';
		elsif rising_edge(CLK) then	  
			if KickFlag = '1' then
				if DelayCounter < MeasurePriod then			
					DelayCounter <= DelayCounter + 1;
					ClrKick <= '0';	   
				else
					DelayCounter <= 0;
					ClrKick <= '1'; 			
				end	if;	   
			else	
				DelayCounter <= 0; 	   
				ClrKick <= '0';				
			end if;	
		end if;
	end	process;		   
	
	CountImpulses: process(Input, ClrKick, RST)
	begin
		if RST = '0' or ClrKick = '1' then
			ImpulseCounter <= (others => '0'); 
		elsif rising_edge(Input) then	 
			if KickFlag = '1' then
				ImpulseCounter <= ImpulseCounter + 1;	 
			else   
				ImpulseCounter <= (others => '0'); 			
			end if;	
		end if;
	end	process;		 
	
	process(ClrKick, RST)
	begin
		if RST = '0' then
			Result <= (others => '0'); 
		elsif rising_edge(ClrKick) then	
			Result <= ImpulseCounter;	  
		end if;
	end	process;	
	
			
	Done <= not (KickFlag or ClrKick);
	Data <= Result;

end PairsCounter_arch;











