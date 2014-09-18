-------------------------------------------------------------------------------
--
-- Title       : rectest
-- Design      : contrdme
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : rectest.vhd
-- Generated   : Wed Oct 13 11:52:57 2010
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
--{entity {rectest} architecture {rectest_arch}}		 
	
library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity rectest is
	 port(
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 start : in STD_LOGIC;
		 edge : out STD_LOGIC
	     );
end rectest;

--}} End of automatically maintained section

architecture rectest_arch of rectest is	  
	-- Component declaration of the "singleimpulse(singleimpulse_arch)" unit defined in
	-- file: "./../src/SingleImpulse.vhd"
	component singleimpulse
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		polarity : in STD_LOGIC;
		length : in STD_LOGIC_VECTOR(15 downto 0);
		start : in STD_LOGIC;
		outstrobe : out STD_LOGIC;
		outedge : out STD_LOGIC);
	end component;
	for all: singleimpulse use entity work.singleimpulse(singleimpulse_arch);

	signal Start_1_5_us : std_logic;
		
begin 	  
	
	delay : singleimpulse
	port map(
		clk => clk,
		rst => rst,
		polarity => '1',
		length => CONV_STD_LOGIC_VECTOR(140, 16),  --1.5 us delay
		start => start,
		outedge => Start_1_5_us
	);
	
	impulse : singleimpulse
	port map(
		clk => clk,
		rst => rst,
		polarity => '0',
		length => CONV_STD_LOGIC_VECTOR(200, 16),  --5 us length
		start => Start_1_5_us,
		outstrobe => edge
	);
	
	


	
	

end rectest_arch;
