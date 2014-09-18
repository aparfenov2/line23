-------------------------------------------------------------------------------
--
-- Title       : SingleImpulse
-- Design      : contrdme
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : SingleImpulse.vhd
-- Generated   : Mon Oct  4 13:48:43 2010
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
--{entity {SingleImpulse} architecture {SingleImpulse_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;


entity SingleImpulse is			
	 port(
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 polarity : in STD_LOGIC;
		 length : in std_logic_vector(15 downto 0);
		 start : in std_logic;
		 outstrobe : out STD_LOGIC;
		 outedge : out std_logic
	     );
end SingleImpulse;

--}} End of automatically maintained section

architecture SingleImpulse_arch of SingleImpulse is	 
	signal DelayEnable: std_logic;
	signal ClrDelayEnable : std_logic;	

begin

	process(ClrDelayEnable, RST, start)
	begin		
		if RST = '0' or ClrDelayEnable = '1' then		
			DelayEnable <= '0';	
		elsif rising_edge(start) then 				
			DelayEnable <= '1';	
		end	if;									 
	end process;		
	
	
	
	
	
	process(CLK, RST)	
		variable cnt : natural;		
	begin		
		if RST = '0' then		
			cnt := 0;		
			ClrDelayEnable <= '0';
		elsif rising_edge(CLK) then 
			if DelayEnable = '1' then
				if cnt < CONV_INTEGER(length)  then 
					cnt := cnt + 1;	   
					ClrDelayEnable <= '0';
				else	   
					ClrDelayEnable <= '1';
				end if;	  
			else
				cnt := 0;		
				ClrDelayEnable <= '0';
			end if;	   
		end	if;									 
	end process;			
	
	
	process(CLK, RST, ClrDelayEnable, polarity)		  
	begin		
		if RST = '0' or ClrDelayEnable = '1' then
			outstrobe <= not polarity;
		elsif rising_edge(CLK)	then  
			if DelayEnable = '1' then
				outstrobe <= polarity;					
			end if;	
		end if;
	end process;
	
	outedge <= ClrDelayEnable;


end SingleImpulse_arch;
