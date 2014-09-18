-------------------------------------------------------------------------------
--
-- Title       : AdcSamples
-- Design      : contrdme
-- Author      : User
-- Company     : мон "пря"
--
-------------------------------------------------------------------------------
--
-- File        : AdcSamples.vhd
-- Generated   : Thu Oct  7 11:27:55 2010
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
--{entity {AdcSamples} architecture {AdcSamples_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

library altera_mf;
use altera_mf.all;



entity AdcSamples is
	 port(
 

		 CLK : in std_logic; 
		 CLK_CPU : in std_logic;  		 
		 RST : in std_logic; 	  
		 
		 RD : in std_logic; 	 		 		
		 RdAddress : in std_logic_vector(8 downto 0);
		 RData : out std_logic_vector(11 downto 0);	  

		 
		 Start : in std_logic;  
		 EnableStrobe : in std_logic;
		 Kick : in std_logic;	
		 ADC : in std_logic_vector(11 downto 0); 		
		 Done : out std_logic	
		 
	     );
end AdcSamples;

--}} End of automatically maintained section

architecture AdcSamples_arch of AdcSamples is  

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


signal WRAddress : std_logic_vector(8 downto 0); 
signal WrRam : std_logic;

signal KickFlag : std_logic;
signal Enable : std_logic;	  

	

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
		wren_a => WrRam,
		clock0 => CLK,
		clock1 => CLK_CPU,
		address_a => WRAddress,
		address_b => RdAddress,
		rden_b => RD,
		data_a => ADC,
		q_b => RData
	);		   
	

	
	--Start--
	
	process(Start, RST, EnableStrobe, KickFlag)
	begin 
		if RST = '0' then 	 
			Enable <= '0';				
		elsif Start = '1' then  
			if KickFlag = '1' then
				Enable <= '1';  	   							
			end	if;	 	  
		else
			if falling_edge(EnableStrobe) then 	
				Enable <= '0';			
			end if;	
		end if;
	end process;	   
	----		
	


	process(Kick, RST, EnableStrobe)
	begin 
		if RST = '0' then 
			KickFlag <= '0';		
		elsif Kick = '1' then  
			KickFlag <= '1';		
		else	
			if falling_edge(EnableStrobe) then 	
				if Enable = '1' then
					KickFlag <= '0';				
				end if;	
			end if;	
		end if;
	end process;	
	----	 
	
	process(CLK, RST, Start)	
	begin 
		if RST = '0' or Start = '1' then 	  
			WrAddress <= (others => '0');		
		elsif rising_edge(CLK) then	 
			if EnableStrobe = '1' and Enable = '1' then 
				WrAddress <= WrAddress + 1;		
			end	if;		
		end if;
	end process;	
	
	WrRam <= EnableStrobe and Enable;

	process(Enable, Kick, RST)	
	begin 
		if RST = '0' or Kick = '1' then 				 
			Done <= '0';		
		elsif falling_edge(Enable) then	
			Done <= '1';		
		end if;
	end process;
	
	
	

end AdcSamples_arch;
