-------------------------------------------------------------------------------
--
-- Title       : Rip
-- Design      : contrdme
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : Rip.vhd
-- Generated   : Thu Jul  8 17:27:24 2010
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
--{entity {Rip} architecture {Rip_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Rip is
	 port(
		 CLK : in STD_LOGIC;
		 RST : in STD_LOGIC;
		 ADC : in STD_LOGIC_VECTOR(11 downto 0);
		 AdcOut : out STD_LOGIC_VECTOR(11 downto 0)
	     );
end Rip;

--}} End of automatically maintained section

architecture Rip_arch of Rip is
begin

	process(CLK, RST)
	begin 
		if RST = '0' then
			AdcOut <= (others => '0');
		elsif	 rising_edge(CLK) then
			AdcOut <= ADC;			
		end if;			
	end process;
	
end Rip_arch;
