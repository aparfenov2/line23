-------------------------------------------------------------------------------
--
-- Title       : divider
-- Design      : contrdme
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : divider.vhd
-- Generated   : Thu Feb 10 17:40:29 2011
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
--{entity {divider} architecture {divider_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;	 
use IEEE.STD_logic_unsigned.all;  
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity divider is	
	generic(
		Kdiv : integer := 29629
	);
	 port(
		 CLK : in STD_LOGIC;
		 RST : in STD_LOGIC;
		 DivClk : out STD_LOGIC
	     );
end divider;

--}} End of automatically maintained section

architecture divider_arch of divider is	 
	signal DividedClock :  std_logic;
begin

process (CLK, RST)	  
	variable Counter : natural;
begin 
	if RST = '0' then		
	    Counter := 0; 
		DividedClock <= '0';
	elsif rising_edge(CLK) then
		if Counter  <  Kdiv - 1 then 
			Counter := Counter + 1;	
			DividedClock <= '0';
		else
			Counter := 0;  
			DividedClock <= '1';
		end if;	 
	end if;		   
end process;			

DivClk <= CLK when Kdiv = 0 else DividedClock;

end divider_arch;
