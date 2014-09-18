-------------------------------------------------------------------------------
--
-- Title       : sync_lib
-- Design      : contrdme
-- Author      : Aleksandr
-- Company     : Home
--
-------------------------------------------------------------------------------
--
-- File        : sync_lib.vhd
-- Generated   : Sat Feb 12 01:33:01 2011
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
--{entity {sync_lib} architecture {sync_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sync_lib is
	 port(
		 CLK : in STD_LOGIC;
		 RST : in STD_LOGIC;	 
		 Clear : in std_logic;
		 Input : in STD_LOGIC;
		 Output : out STD_LOGIC
	     );
end sync_lib;

--}} End of automatically maintained section

architecture sync_arch of sync_lib is

signal tmpStart : std_logic;
signal synckStart :std_logic;	
signal tmpDone : std_logic;		  
signal ttt : std_logic;

begin		  
	
process(CLK, RST)
begin 		
	if RST = '0' then 
		tmpStart <= '0';  
	elsif rising_edge(CLK) then	
		tmpStart <= Input;	 
	end if;			
end process;		  
ttt <= 	(not tmpStart)  and Input;

process(CLK, RST, Clear)
begin 		
	if RST = '0' or Clear = '1' then 
		tmpDone <= '0';
		synckStart <= '0';
	elsif rising_edge(CLK) then	
		if tmpDone = '0' then
			if ttt = '1' then
				synckStart <= '1';	
				tmpDone <= '1';	  			
			end if;	   
		else   
			synckStart <= '0';	
			tmpDone <= '0';				
		end if;
	end if;	
end process;

Output <= synckStart;

end sync_arch;
