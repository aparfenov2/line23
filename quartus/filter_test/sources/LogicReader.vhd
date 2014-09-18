-------------------------------------------------------------------------------
--
-- Title       : LogicReader
-- Design      : contrdme
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : LogicReader.vhd
-- Generated   : Sat Dec 25 09:41:16 2010
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
--{entity {LogicReader} architecture {LogicReader_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LogicReader is
	 port(
		 CLK : in STD_LOGIC;

		 RST : in STD_LOGIC;					  


		Inp_PUM_Temperature   : in STD_LOGIC;
		Inp_UM_Temperature    : in STD_LOGIC;
		Inp_UM_Current4       : in STD_LOGIC;
		Inp_UM_Current3       : in STD_LOGIC;
		Inp_UM_Current2       : in STD_LOGIC;
		Inp_UM_Current1       : in STD_LOGIC;
		Inp_PUM_Current       : in STD_LOGIC;
		Inp_ErrorSynthesizer  : in STD_LOGIC;
		Inp_TX_Synthesizer    : in STD_LOGIC;
		Inp_NormalKG          : in STD_LOGIC;
		Inp_15V               : in STD_LOGIC;
		Inp_50V_PUM           : in STD_LOGIC;
		Inp_50V_UM            : in STD_LOGIC;
		 
		 Data : out STD_LOGIC_VECTOR(12 downto 0)
	     );
end LogicReader;

--}} End of automatically maintained section

architecture LogicReader_arch of LogicReader is		 

signal LogicRegister : std_logic_vector(12 downto 0);

begin
	process(CLK, RST)
	begin 		
		if RST = '0' then
			LogicRegister <= (others => '0');	
		elsif rising_edge(CLK) then 
			LogicRegister <= 		
				not Inp_PUM_Temperature & 
				not Inp_UM_Temperature  &
				not Inp_UM_Current4     & 
				not Inp_UM_Current3     & 
				not Inp_UM_Current2     & 
				not Inp_UM_Current1     & 
				not Inp_PUM_Current     & 
				Inp_ErrorSynthesizer	& 
				not Inp_TX_Synthesizer  & 
				Inp_NormalKG        & 
				not Inp_15V             & 
				not Inp_50V_PUM         & 
				not Inp_50V_UM          ; 						
		end if;			
	end process;	

	
	Data <= LogicRegister;

end LogicReader_arch;
