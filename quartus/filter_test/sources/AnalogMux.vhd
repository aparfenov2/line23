-------------------------------------------------------------------------------
--
-- Title       : Decoder
-- Design      : KDME
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : SelectMuxChannel.vhd
-- Generated   : Wed Mar  3 09:11:20 2010
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
--{entity {SelectMuxChannel} architecture {SelectMuxChannel}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity AnalogMux is
	 port(
	 	 CLK : in STD_LOGIC; 
	 	 CLK_CPU : in std_logic;
		 WR : in STD_LOGIC;	
		 RST : in STD_LOGIC;	
		 Data : in STD_LOGIC_VECTOR(3 downto 0); 
		 StrobeKS : in std_logic;		 
		 TR : in std_logic;
		 A_MS : out STD_LOGIC_VECTOR(1 downto 0);
		 EN_MS1 : out STD_LOGIC;
		 EN_MS2 : out STD_LOGIC

		 
	     );
end AnalogMux;

--}} End of automatically maintained section

architecture AnalogMux_arch of AnalogMux is 


--EN_MS2	EN_MS1	MS2	MS1	Function
--0			1		0	0	DAC
--0			1		0	1	DetectorUM
--0			1		1	0	EchoWave
--0			1		1	1	IncidentWave
--1			0		0	0	LoadWave
--1			0		0	1	Video
--1			0		0	1	DetectorPUM
--1			0		1	1	Reserved

constant None : std_logic_vector(3 downto 0) := "0000";
constant DAC : std_logic_vector(3 downto 0) := "0100";		   
constant DetectorUM : std_logic_vector(3 downto 0) := "0101";	
constant EchoWave : std_logic_vector(3 downto 0) := "0110";
constant IncidentWave : std_logic_vector(3 downto 0) := "0111";
constant LoadWave : std_logic_vector(3 downto 0) := "1000";
constant Video : std_logic_vector(3 downto 0) := "1001"; 
constant DetectorPUM : std_logic_vector(3 downto 0) := "1010"; 	   
constant Reserved : std_logic_vector(3 downto 0) := "1011"; 


signal InputChannelRegister : std_logic_vector(3 downto 0);	 
signal OutputChannelRegister : std_logic_vector(3 downto 0);


begin 	  
	
	process (CLK_CPU, RST)
	begin
	if RST = '0' then
		InputChannelRegister <= (others => '0');
	elsif rising_edge(CLK_CPU) then	  
		if WR = '0' then
			InputChannelRegister <= Data; 			
		end if;	
	end if;	
	end process;	
	
	
	process (CLK, RST, StrobeKS, TR)
	begin
	if RST = '0' or StrobeKS = '1' or TR = '0'  then
		--OutputChannelRegister <= Video;
	elsif rising_edge(CLK) then	  		
		OutputChannelRegister <= InputChannelRegister;	
	end if;		
	end process;	
	
	A_MS <= OutputChannelRegister(1 downto 0);
	EN_MS1 <= OutputChannelRegister(2);  
	EN_MS2 <= OutputChannelRegister(3);   
	


end AnalogMux_arch;
