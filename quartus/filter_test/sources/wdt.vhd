-------------------------------------------------------------------------------
--
-- Title       : wdt
-- Design      : KDME
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : wdt.vhd
-- Generated   : Fri Jun  4 11:42:30 2010
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
--{entity {wdt} architecture {wdt_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;	   
use IEEE.std_logic_unsigned.all;

entity wdt is
	 port(
	 	 clk : in STD_LOGIC;
	 	 clk_1khz : in std_logic;
		 rst : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 wdt_out: out STD_LOGIC
	     );
end wdt;

--}} End of automatically maintained section

architecture wdt_arch of wdt is	
	subtype NATURAL8 is natural	range 0 to 127;	  
	constant WatchDogTime : NATURAL8 := 100;	
	signal ClrFlag : std_logic;	  
	signal RstFlag : std_logic;		
	signal reset : std_logic;	
		
begin		 
	
	process(CLR, RST, RstFlag)
	begin
		if RST = '0' or RstFlag = '1' then 
			ClrFlag <= '0';						
		elsif rising_edge(CLR) then		
			ClrFlag <= '1';		
		end	if;			
	end	process;
		
	process(CLK, RST, ClrFlag)  
		variable Counter : NATURAL8;
	begin 
		if RST = '0' or ClrFlag = '1' then  
			Counter := 0;			  
			reset <= '0';			
			RstFlag <= '1';
		elsif rising_edge(CLK) then
			if Counter < WatchDogTime then 
				Counter := Counter + 1;	 	
				RstFlag <= '0';
			else			
				reset <= '1';				
			end if;	
		end if;	   		
	end	process;
	
	process(CLK, RST)
	begin
		if RST = '0' then 
			wdt_out <= '0';						
		elsif rising_edge(CLK) then	
			if 	reset = '0' then			
				wdt_out <= clk_1khz;						
			end if;	
		end	if;			
	end	process;	

end wdt_arch;
