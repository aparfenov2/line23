-------------------------------------------------------------------------------
--
-- Title       : coder
-- Design      : contrdme
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : coder.vhd
-- Generated   : Fri Oct  1 13:37:13 2010
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
--{entity {coder} architecture {coder_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;
library	altera_mf;

use IEEE.STD_LOGIC_1164.all;		   

use altera_mf.all;

entity coder is
	 port(
		CLK : in STD_LOGIC;
		CLK_CPU : in STD_LOGIC;
		RST : in STD_LOGIC;
		
		WR : in STD_LOGIC;
		Address : in STD_LOGIC_VECTOR(1 downto 0);
		Data : in STD_LOGIC_VECTOR(15 downto 0);
		
		Start : in STD_LOGIC;
		KsStrobe : in STD_LOGIC;
		
		TR : out STD_LOGIC;
		Pum : out STD_LOGIC;
		
		StartDacOut : out STD_LOGIC;
		RdDac : out STD_LOGIC;		 
		
		StartAdc1Out : out STD_LOGIC;	
		WrAdc1 : out STD_LOGIC;
		
		StartAdc2Out : out STD_LOGIC;		
		WrAdc2 : out STD_LOGIC;			   		 
		
		Done : out STD_LOGIC 
		 
	     );
end coder;

--}} End of automatically maintained section	 



architecture coder_arch of coder is		  


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

	constant Delay_0_5_us 		: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(20, 16);
	constant Delay_1_0_us 		: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(40, 16);	
	constant Delay_2_0_us 		: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(80, 16);	   
	constant Delay_12_0_us 		: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(480, 16);	  
	constant Delay_36_0_us		: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(1440, 16);	
	
	constant DacStrobeLength 	: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(416, 16);			
	constant PumStrobeLength	: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(372, 16);	
	constant AdcStrobeLength	: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(475, 16);	
	constant DelayAfterPairs	: std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(400, 16);	--320
	
	
	
	signal	WorkDelayRegister	: std_logic_vector(15 downto 0) := Delay_12_0_us;	
	signal  CtrlDelayRegister	: std_logic_vector(15 downto 0) := Delay_12_0_us;			  
	signal  DelayRegister		: std_logic_vector(15 downto 0) := Delay_12_0_us;	
	signal  ConfigRegister 		: std_logic_vector(7 downto 0)  := (others => '0');
	
	
	signal SingleStrobe : std_logic := '0';

	signal RdDacStrobe : std_logic;		

	
	signal start_0_5_us : std_logic;
	signal start_1_5_us : std_logic;	   
	
	signal start_0_5_us_second : std_logic;
	signal start_1_5_us_second : std_logic;	
	
	
	signal StartAdc1 : std_logic;
	signal StartAdc2 : std_logic;
	signal StartDac : std_logic;	  
	
	
	signal AdcFirstStrobe : std_logic;
	signal AdcSecondStrobe : std_logic;			
	
	signal StartPum : std_logic;	  	   
	signal PumStrobe : std_logic;		 
	
	
	
	signal StartClrTR : std_logic;
	signal TR_Strobe : std_logic;	  
	signal ClrTR : std_logic;
	
	

begin		
	
		------------Set Params--------------------------	
		process(CLK_CPU, RST)
		begin
			if RST = '0' then 
				WorkDelayRegister <= Delay_36_0_us;
				CtrlDelayRegister <= Delay_36_0_us;	
				ConfigRegister <= (others => '0');
			elsif rising_edge(CLK_CPU) then
				if WR = '0' then		   
					case Address is
						when "00" =>
							WorkDelayRegister <= Data;
						when "01" =>
							CtrlDelayRegister <= Data;
						when "10" =>
							ConfigRegister	<= Data(7 downto 0);					
						when others	=> null;						
					end	case;	
				end if;	
			end if;
		end process;   
		
		--SingleStrobe <= ConfigRegister(0);		
		
				
		process(CLK, RST)
		begin 		
			if RST = '0' then
				SingleStrobe <= '0'; 			
			elsif rising_edge(CLK)	 then
				if Start = '1' then	  
					SingleStrobe <= ConfigRegister(0);					
				end if;				
			end if;	
		end process;	

		------------------------------------------------
	
	   MDelay_0_5_us: singleimpulse	   
		port map (
			 CLK => CLK,
			 RST => RST,	
			 polarity => '1',
			 length => Delay_0_5_us, --CONV_STD_LOGIC_VECTOR(20, 16)
			 start => Start,
			 outedge => start_0_5_us
	);				  
	
	   MDelay_1_5_us: singleimpulse	   	 
		port map (
			 CLK => CLK,
			 RST => RST,	
			 polarity => '1',
			 length => Delay_1_0_us, --CONV_STD_LOGIC_VECTOR(40, 16)
			 start => start_0_5_us,
			 outedge => start_1_5_us
	);	   
	
		
	    DelayRegister <= WorkDelayRegister when KsStrobe = '0' else	CtrlDelayRegister;
	
		Delay_0_5_us_second: singleimpulse	
		port map (
			 CLK => CLK,
			 RST => RST,	
			 polarity => '1',
			 length => DelayRegister,
			 start => start_0_5_us,
			 outedge => start_0_5_us_second
	);	 
	
	
		MDelay_1_5_us_second: singleimpulse	
		port map (
			 CLK => CLK,
			 RST => RST,	
			 polarity => '1',
			 length => DelayRegister,
			 start => start_1_5_us,
			 outedge => start_1_5_us_second
	);	 
		
	
	StartDac <= ((not SingleStrobe)	and start_0_5_us_second) or
				start_0_5_us;
	
	MDac : singleimpulse	   
	port map(
		clk => clk,
		rst => rst,
		polarity => '1', 
		length => DacStrobeLength, --CONV_STD_LOGIC_VECTOR(416, 16)
		start => StartDac,
		outstrobe => RdDacStrobe
	);	   
	
	StartAdc1 <= start_0_5_us;
	
	MAdc1 : singleimpulse 
	port map(
		clk => clk,
		rst => rst,
		polarity => '1', 
		length => AdcStrobeLength, --CONV_STD_LOGIC_VECTOR(475, 16)
		start => StartAdc1,
		outstrobe => AdcFirstStrobe
	);		  
	
	StartAdc2 <= start_0_5_us_second and (not SingleStrobe);
	
	MAdc2 : singleimpulse   
	port map(
		clk => clk,
		rst => rst,
		polarity => '1', 
		length => AdcStrobeLength, --CONV_STD_LOGIC_VECTOR(475, 16)
		start => StartAdc2,
		outstrobe => AdcSecondStrobe
	);			
	
	
	StartPum <= ((not SingleStrobe)	and start_1_5_us_second) or
				start_1_5_us;
	
	
	MPumImpulse : singleimpulse	   
	port map(
		clk => clk,
		rst => rst,
		polarity => '0', 
		length => PumStrobeLength, --CONV_STD_LOGIC_VECTOR(372, 16)
		start => StartPum,
		outstrobe => PumStrobe
	);	
	
	StartClrTR <= start_1_5_us when SingleStrobe = '1' else start_1_5_us_second;	 	 
	--StartClrTR <= start_1_5_us_second;	 	 	
		
		
	TRClear : singleimpulse	   
	port map(
		clk => clk,
		rst => rst,
		polarity => '1', 
		length => PumStrobeLength + Delay_2_0_us,	--CONV_STD_LOGIC_VECTOR((372 + 80), 16)
		start => StartClrTR,	
		outedge => ClrTR 
	);				 
	
	MDelayAfterPairs : singleimpulse	   
	port map(
		clk => clk,
		rst => rst,
		polarity => '1', 
		length => DelayAfterPairs,	--CONV_STD_LOGIC_VECTOR((372 + 80), 16)
		start => ClrTR,	
		outedge => Done  
	);	
	
	
	process(CLK, RST, Start, ClrTR)
	begin		
		if RST = '0' then		
			TR_Strobe <= '0';	
		elsif Start = '1' then				
			TR_Strobe <= '1';	
		else	
			if rising_edge(CLK) then 
				if ClrTR = '1' then
					TR_Strobe <= '0';				
				end if;			
			end	if;		   
		end	if;									 
	end process;	

	TR <= TR_Strobe or (not PumStrobe);

	Pum <= PumStrobe;
	
	RdDac <= RdDacStrobe;
	WrAdc1 <= AdcFirstStrobe and (not KsStrobe);  
	WrAdc2 <= AdcSecondStrobe and (not KsStrobe); 
	
	StartDacOut <= StartDac;

		 
	StartAdc1Out <= StartAdc1 and (not KsStrobe);
	StartAdc2Out <= StartAdc1 and (not KsStrobe);


end coder_arch;
