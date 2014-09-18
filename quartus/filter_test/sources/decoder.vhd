-------------------------------------------------------------------------------
--
-- Title       : Decoder
-- Design      : KDME
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : Decoder.vhd
-- Generated   : Mon May 17 15:04:36 2010
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
--{entity {Decoder} architecture {Decoder_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	

use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;


entity Decoder is
	port(		 
		 ---------------------	
		 CLK : in STD_LOGIC;
		 CLK_CPU : in STD_LOGIC;
		 RST : in STD_LOGIC;
		 -----------------------
		 Obn : in STD_LOGIC;	
		 --Blank : in std_logic;
		 AdcMax : in STD_LOGIC_VECTOR(11 downto 0);
		 ----------------------
		 WR : in STD_LOGIC;
		 Address : std_logic_vector(1 downto 0);
		 Data : in STD_LOGIC_VECTOR(15 downto 0);  
		 ----------------------
		 
		 AdcMaxOut : out std_logic_vector(11 downto 0);
		 DiffImpulses : out std_logic_vector(10 downto 0);
		 
		 Decode : out STD_LOGIC;
		 --------debug---------
		 dbgStartWaitSecond : out Std_logic;
		 dbgWaitSecond : out std_logic;
		 dbgEndWaitSecond : out std_logic;
		 dbgSecondDetected : out std_logic;
		 dbgDecodeStrobe : out std_logic;
		 HwLock : in std_logic
		 
		 
	     );
end Decoder;
								 




architecture Decoder_arch of Decoder is		 
	signal Edge : std_logic;

	---------------	for setting X or Y Mode----------
	type ModeDME_type is (
		X,
		Y 
		);
	signal Mode : ModeDME_type;					   
	-------------------------------------------------
	
	----------------Convert Std_Logic2ModeDME--------

	function Std_Logic2ModeDME(input : std_logic) return ModeDME_type is 
	begin
		case input is
			when '0' => return X;  			
			when others => return Y;
	    end case;
	end	Std_Logic2ModeDME;	   
	-------------------------------------------------  	   
	-----------------const---------------------------
	constant Time_25ns : natural := 25;
	constant Time_12us : natural := 12000 / Time_25ns;
	constant Time_1us : natural := 1000 / Time_25ns;   
	constant Time_2us : natural := 2000 / Time_25ns;   
											   
	constant Time_36us : natural := 36000 / Time_25ns;
    --constant Tolerance : natural := Time_2us ;	

	-------------------------------------------------
	signal Tolerance : natural := Time_2us;
	
	--------------Select 12us with Tolerance 2 us----
	function Select_12_us(value, tol : natural) return std_logic is		   

	begin		  
		if 	(value >= Time_12us - tol) and (value < Time_12us + tol) then
			return '1';
		else
			return '0';	
		end if;	
		
	end Select_12_us;
	-------------------------------------------------  
	
	--------------Select 30us with Tolerance 2 us----
	function Select_36_us(value, tol : natural) return std_logic is	

	begin		  
		if 	(value >= Time_36us - tol) and (value < Time_36us + tol) then
			return '1';
		else
			return '0';	
		end if;	
		
	end Select_36_us;
	-------------------------------------------------
	
	-------------end 12 us---------------------------
	function End_12_us(value, tol : natural) return std_logic is		   
		constant Time_25ns : natural := 25;
		constant Time_12us : natural := 12000 / Time_25ns;
		constant Time_2us : natural := 2000 / Time_25ns;
		--constant Tolerance : natural := Time_2us ;
	begin		  
		if value >= Time_12us + tol  then
			return '1';
		else
			return '0';	
		end if;	
		
	end End_12_us;
	
	-------------------------------------------------	
	
	-------------end 36 us---------------------------
	function End_36_us(value, tol : natural) return std_logic is		   
		constant Time_25ns : natural := 25;
		constant Time_36us : natural := 36000 / Time_25ns;
		constant Time_2us : natural := 2000 / Time_25ns;
		--constant Tolerance : natural := Time_2us ;
	begin		  
		if value >= Time_36us + tol then
			return '1';
		else
			return '0';	
		end if;	
		
	end End_36_us;
	
	-------------------------------------------------	
	signal ControlRegister: std_logic_vector(7 downto 0);
	
	signal Enable : std_logic;

--	------------------for Level Compare--------------		 
	signal AllowedDifference : std_logic_vector(11 downto 0);  	 
--	-------------------------------------------------	  
--	
--		
--	-------------------for blanking--------------------
	signal BlankRegister : std_logic_vector(12 downto 0);		
	signal BlankEnd : std_logic;	  
	signal BlankEnable : std_logic;	  	   
	signal SelfBlank : std_logic;
--		
--	---------------------------------------------------		
	
	------------------------wait-----------------------		   
	signal StartWaitSecond: std_logic;
	signal WaitSecond : std_logic;
	signal EndWaitSecond : std_logic;	  
	---------------------------------------------------	   
	
	----------------------level------------------------
	signal AdcMaxFirst : std_logic_vector(11 downto 0);	
	signal AdcMaxSecond : std_logic_vector(11 downto 0);
	---------------------------------------------------
	
	----------------------delay interval---------------
	signal DelayCounter : natural;
	signal BlankCounter : natural;
									 
	---------------------------------------------------		
	
	---------------------decode------------------------
	signal SecondDetected : std_logic;		  
	signal DecodeStrobe : std_logic;
	
	---------------------------------------------------

begin 
	
	---------Set Mode by NIOS------------------------- 
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 	
			ControlRegister <= (others => '0');
			AllowedDifference <= CONV_STD_LOGIC_VECTOR(60,12);	--1 dB   
			BlankRegister <= CONV_STD_LOGIC_VECTOR(2400,13);	--60 us
			Tolerance <= Time_2us;
		elsif rising_edge(CLK_CPU) then					   
			if WR = '0' then	  
				case Address is
					when "00" => 
						ControlRegister <= Data(7 downto 0);
					when "01" =>
						AllowedDifference <= Data(11 downto 0);		 
					when "10" =>
						BlankRegister <= Data(12 downto 0);		
					when "11" =>
						Tolerance <= CONV_INTEGER(Data);
					when others =>	null;
				end case;					
			end if;	
		end if;
	end process;	
	---------------------------------------------------	   
						  
   	Mode <= Std_Logic2ModeDME(ControlRegister(0));
	Enable <= ControlRegister(1);		

	Edge <= Obn;-- when HwLock = '0' else '0';
								   


First:
process(Edge, RST, EndWaitSecond)
begin
	if RST = '0' or EndWaitSecond = '1' then 	   	
		StartWaitSecond <= '0';	 	 
		AdcMaxFirst <= (others => '0');
	elsif rising_edge(Edge) then 	  
		if 	BlankEnable /= '1' and Enable = '1' then
	   		StartWaitSecond <= '1';				 
			AdcMaxFirst <= AdcMax;   
		end	if;
	end if;		
end process;	  


DelayInterval:
process(CLK, RST)
begin
	if RST = '0' then 
		DelayCounter <= 0; 
		WaitSecond <= '0';	  
		EndWaitSecond <= '0';
	elsif rising_edge(CLK) then 	  
		if StartWaitSecond = '1' then  			
			DelayCounter <= DelayCounter + 1; 
			if Mode = X then	 			   
				WaitSecond <= Select_12_us(DelayCounter, Tolerance);	   
				EndWaitSecond <= End_12_us(DelayCounter, Tolerance);				
			else	
				WaitSecond <= Select_36_us(DelayCounter, Tolerance);	   
				EndWaitSecond <= End_36_us(DelayCounter, Tolerance);
			end if;				
		else	  
			DelayCounter <= 0;	  				
			WaitSecond <= '0';	 
			EndWaitSecond <= '0';
		end	if;	   		
	end if;		
end process;	 							

Second:
process(Edge, RST, DecodeStrobe, EndWaitSecond)
begin
	if RST = '0' or DecodeStrobe = '1' or EndWaitSecond = '1' then 
		SecondDetected <= '0';		
	elsif rising_edge(Edge) then 	  
		if WaitSecond = '1' then
			SecondDetected <= '1';				  
		end	if;	   		
	end if;		
end process;	 


LatchSecond:
process(Edge, RST)
begin
	if RST = '0' then 
		AdcMaxSecond <= (others => '0');
		DiffImpulses <= (others => '0'); 
	elsif rising_edge(Edge) then 	  
		if WaitSecond = '1' then
			AdcMaxSecond <= AdcMax;	
			DiffImpulses <= CONV_STD_LOGIC_VECTOR(DelayCounter, 11);	 
		end	if;	   		
	end if;		
end process;	


DecodePair:
process(CLK, RST)	
	variable DelayFlag : std_logic;
begin	   
	if RST = '0' then	 
		DecodeStrobe <= '0';  
		DelayFlag := '0';
	elsif rising_edge(CLK) then 
		if SecondDetected = '1' then	
			if DelayFlag = '1' then	
				if AdcMaxSecond > AdcMaxFirst then
					if AdcMaxSecond - AdcMaxFirst <= AllowedDifference  then
						DecodeStrobe <= '1';  
					end if;	
				else	
					if AdcMaxFirst - AdcMaxSecond <= AllowedDifference then
						DecodeStrobe <= '1';	
					end if;	
				end if;	 
			end if;	
			DelayFlag := '1';
		else
			DecodeStrobe <= '0'; 
			DelayFlag := '0';						 
		end if;		
	end if;	
end process;	

--------------Blanking-----------------------------	 
SelfBlank <= DecodeStrobe;

process(SelfBlank, RST, BlankEnd)
begin			
	if RST = '0' or BlankEnd = '1' then
	  BlankEnable <= '0';
	elsif rising_edge(SelfBlank) then		
		BlankEnable <= '1';
	end if;
end process;	


process(CLK, RST)
	variable BlankCounter : natural;
begin			
	if RST = '0' then 
		BlankCounter := 0;
		BlankEnd <= '0';
	elsif rising_edge(CLK) then		
		if BlankEnable = '1' then 
			if BlankCounter < BlankRegister then
				BlankCounter := BlankCounter + 1;
				BlankEnd <= '0';
			else
				BlankCounter := 0;
				BlankEnd <= '1';
			end	if;
		else	  
			BlankEnd <= '0';
		end if;
	end if;
end process;	
-------------------------------------------------	


Decode <= DecodeStrobe;

AdcMaxOut <= AdcMaxFirst; 


--------debug---------
dbgStartWaitSecond <= StartWaitSecond;
dbgWaitSecond <= WaitSecond;
dbgEndWaitSecond <= EndWaitSecond;
dbgSecondDetected <= SecondDetected;
dbgDecodeStrobe <= DecodeStrobe;
----------------------


end Decoder_arch;	  