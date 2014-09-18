library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity div is
	 port(
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 clk_out : out STD_LOGIC
	     );
end div;

architecture divider100_arch of div is

	signal clk_100kHz : std_logic;
	constant Clk100KhzFactor : integer := 400;	--40MHz / 400 = 100 KHz 
	
begin	

	---------Divide Frequency 40 MHz to 100 kHz

	process (clk, rst)	  
		variable Counter : natural;
		begin 
		if rst = '0' then		
		    Counter := 0; 
			clk_100kHz <= '0';
		elsif rising_edge(clk) then
			if Counter  <  Clk100KhzFactor - 1 then   
				Counter := Counter + 1;	
				clk_100kHz <= '0';
			else
				Counter := 0;  
				clk_100kHz <= '1';
			end if;	 
		end if;		
	end process;	
	
	clk_out <= clk_100kHz;


end divider100_arch;
	