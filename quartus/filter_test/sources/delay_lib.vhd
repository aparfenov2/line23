-------------------------------------------------------------------------------
--
-- Title       : delay_lib
-- Design      : contrdme
-- Author      : Aleksandr
-- Company     : Home
--
-------------------------------------------------------------------------------
--
-- File        : delay_lib.vhd
-- Generated   : Sat Feb 12 00:40:32 2011
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
--{entity {delay_lib} architecture {delay_arch}}

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity delay_lib is		
	generic(
		DelayValue : integer := 10
	);
	 port(
		 CLK : in STD_LOGIC;
		 RST : in STD_LOGIC;
		 Start : in STD_LOGIC;
		 DelayedStart : out STD_LOGIC
	     );
end delay_lib;



architecture delay_arch of delay_lib is	 

signal tmpStart : std_logic;
signal synckStart :std_logic;
signal Counter : integer := 0;	
signal tmpDone : std_logic;

begin		  
	
process(CLK, RST)
begin 		
	if RST = '0' then 
		tmpStart <= '0';  
	elsif rising_edge(CLK) then	
		tmpStart <= Start;	 
	end if;			
end process;

process(CLK, RST, tmpDone)
begin 		
	if RST = '0' or tmpDone = '1' then 
		synckStart <= '0';
	elsif rising_edge(CLK) then	
		if (not tmpStart) = '1' and Start = '1' then
			synckStart <= '1';									 
		end if;
	end if;	
end process;

process(CLK, RST)	   

begin 		
	if RST = '0' then 
		Counter <= 0;	
		tmpDone <= '0';
	elsif rising_edge(CLK) then	
		if synckStart = '1' then
			if Counter < DelayValue - 1 then				
				Counter <= Counter + 1;	
				tmpDone <= '0';
			else
				tmpDone <= '1';
			end	if;
		else
			Counter <= 0;	
			tmpDone <= '0';
		end if;
	end if;	
end process;

DelayedStart <= tmpDone;

end delay_arch;
