-------------------------------------------------------------------------------
--
-- Title       : ClockDivider
-- Design      : KDME
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : ClockDivider.vhd
-- Generated   : Wed Mar  3 09:49:55 2010
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
--{entity {ClockDivider} architecture {ClockDividerBy40000_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;	 
use IEEE.std_logic_unsigned.all;

entity ClockDivider is
	 port(
	 	 CLK : in STD_LOGIC; 
	 	 RST : in STD_LOGIC;
		 CLK_OUT : out STD_LOGIC
	     );
end ClockDivider;

--}} End of automatically maintained section	 

library IEEE;
use IEEE.std_logic_unsigned.all;

architecture ClockDividerBy40000_arch of ClockDivider is  

signal Counter : std_logic_vector(15 downto 0):=(others => '0');
signal TC : std_logic:='0';
signal TmpClockOut : std_logic;

begin

	process(CLK)
	begin	  
	--	if RST = '0' then
--			Counter <= (others => '0');	 
--			TC <= '0';		   
		if rising_edge(CLK) then
			if Counter = "100111000011111" then
			   Counter <= (others => '0');
			   TC <= '1'; 
			else
			   Counter <= Counter + 1;				
			   TC <= '0';
			end if;		  
			
		end if;	
	
	end process; 	
	
	
	process (TC) 
	begin 
	 	if rising_edge(TC) then
			 if TmpClockOut = '1' then
				TmpClockOut <= '0';
			 else	   
				TmpClockOut	<= '1';
			 end if; 
			 
		end if;
		
		
	end process;
	
	CLK_OUT	<= TmpClockOut;	 


end ClockDividerBy40000_arch;
