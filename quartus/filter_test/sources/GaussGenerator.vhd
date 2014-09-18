-------------------------------------------------------------------------------
--
-- Title       : GaussSignalGenerator
-- Design      : KDME
-- Author      : User
-- Company     : мон \"пря\
--
-------------------------------------------------------------------------------
--
-- File        : D:\Work\My_Designs\DME\KDME\compile\gausssignalgenerator.vhd
-- Generated   : Wed Feb 24 11:56:16 2010
-- From        : D:\Work\My_Designs\DME\KDME\src\gausssignalgenerator.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;



entity GaussGenerator is
  port(
  	   CLK : in STD_LOGIC;
  	   CLK_CPU : in STD_LOGIC; 
	   RST : in STD_LOGIC; 
	   WR : in STD_LOGIC;	
	   WRAddress : in STD_LOGIC_VECTOR(8 downto 0);	  
       Data : in STD_LOGIC_VECTOR(11 downto 0);	   
	   
       ExternalStart : in STD_LOGIC;
	   DAC : out std_logic_vector(11 downto 0)
  );
end GaussGenerator; 

library altera_mf;
use altera_mf.all;

architecture GaussGenerator_arch of GaussGenerator is 

COMPONENT altsyncram
	GENERIC (
		address_aclr_a		: STRING;
		address_aclr_b		: STRING;
		address_reg_b		: STRING;
		indata_aclr_a		: STRING;
		intended_device_family		: STRING;
		lpm_type		: STRING;
		maximum_depth		: NATURAL;
		numwords_a		: NATURAL;
		numwords_b		: NATURAL;
		operation_mode		: STRING;
		outdata_aclr_b		: STRING;
		outdata_reg_b		: STRING;
		power_up_uninitialized		: STRING;
		ram_block_type		: STRING;
		rdcontrol_aclr_b		: STRING;
		rdcontrol_reg_b		: STRING;
		widthad_a		: NATURAL;
		widthad_b		: NATURAL;
		width_a		: NATURAL;
		width_b		: NATURAL;
		width_byteena_a		: NATURAL;
		wrcontrol_aclr_a		: STRING
	);
	PORT (
			wren_a	: IN STD_LOGIC ;
			clock0	: IN STD_LOGIC ;
			clock1	: IN STD_LOGIC ;
			address_a	: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			address_b	: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			rden_b	: IN STD_LOGIC ;
			q_b	: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
			data_a	: IN STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
	END COMPONENT;
  

	signal RDAddress : std_logic_vector(8 downto 0); 
	
	signal DAC_lachted : std_logic_vector(11 downto 0);


begin
	
	altsyncram_component : altsyncram
	GENERIC MAP (
		address_aclr_a => "NONE",
		address_aclr_b => "NONE",
		address_reg_b => "CLOCK1",
		indata_aclr_a => "NONE",
		intended_device_family => "Cyclone",
		lpm_type => "altsyncram",
		maximum_depth => 512,
		numwords_a => 512,
		numwords_b => 512,
		operation_mode => "DUAL_PORT",
		outdata_aclr_b => "NONE",
		outdata_reg_b => "CLOCK1",
		power_up_uninitialized => "FALSE",
		ram_block_type => "M4K",
		rdcontrol_aclr_b => "NONE",
		rdcontrol_reg_b => "CLOCK1",
		widthad_a => 9,
		widthad_b => 9,
		width_a => 12,
		width_b => 12,
		width_byteena_a => 1,
		wrcontrol_aclr_a => "NONE"
	)
	PORT MAP (
		wren_a => WR,
		clock0 => CLK_CPU,
		clock1 => CLK,
		address_a => WRAddress,
		address_b => rdaddress,
		rden_b => ExternalStart,
		data_a => Data,
		q_b => DAC_lachted
	);
	
	
   	process(CLK, RST) 			
	begin
		if RST = '0' then
			DAC <= (others => '0');		
		elsif falling_edge(CLK) then
			DAC <= DAC_lachted;		
		end if;	
	end process;	
    
   		
   RD_AddressCounter : process(CLK, RST)
   begin 
   if RST = '0' then
		RDAddress <= (others => '0');	
   elsif rising_edge(CLK) then 
		if ExternalStart = '1' then
			RDAddress <= RDAddress + 1;
		else	
			RDAddress <= (others => '0');	
		end if;	
	end if;	
	end process;	
	
	
 
	
end GaussGenerator_arch;
