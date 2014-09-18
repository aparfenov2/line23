-------------------------------------------------------------------------------
--
-- Title       : Detector
-- Design      : KDME
-- Author      : User
-- Company     : III "?ON"
--
-------------------------------------------------------------------------------
--
-- File        : Detector.vhd
-- Generated   : Tue May 11 11:00:29 2010
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
--{entity {Detector} architecture {Detector_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;


entity Detector is
	 port(
		 CLK : in STD_LOGIC;
		 RST : in STD_LOGIC; 
		 -----------------
		 CLK_CPU : in STD_LOGIC;
		 Data : in STD_LOGIC_VECTOR(15 downto 0);  
		 Address : in std_logic_vector(1 downto 0);
		 WR : in STD_LOGIC;	 
 		 ------------------							
		 Obn : in STD_LOGIC;				   
		 TR : in std_logic; 
		 
		 ADC : in STD_LOGIC_VECTOR(11 downto 0);   
		 KS : in std_logic;
		 --------------------
		 Edge : out STD_LOGIC;
		 AdcMaxOut : out STD_LOGIC_VECTOR(11 downto 0);
		 
		 --------------------
		 dbgEnableEdge_6dB : out std_logic;
		 dbgEdge_6dB : out std_logic;
		 dbgClrEdge_6dB : out std_logic;
		 dbgObnOK : out std_logic		 
		 --------------------
	     );
end Detector;

--}} End of automatically maintained section  




architecture Detector_arch of Detector is 		

	------------------------------Delays--------------
	constant Delay_2_0us : std_logic_vector(7 downto 0):= CONV_STD_LOGIC_VECTOR(80-1,8); 	   
	constant Delay_3_0us : std_logic_vector(7 downto 0):= CONV_STD_LOGIC_VECTOR(120-1,8); 	   
	constant Delay_4_0us : std_logic_vector(7 downto 0):= CONV_STD_LOGIC_VECTOR(160-1,8); 	   	   
	constant D_4_0us: integer:=(160-1);	
	--constant Delay_7_0us : std_logic_vector(8 downto 0):= CONV_STD_LOGIC_VECTOR(280-1,9); 
	--------------------------------------------------

	signal Adc_3_us : std_logic_vector(11 downto 0);
	signal AdcMax : std_logic_vector(11 downto 0); 			  
	

	------------------------for RAM-----------------
	type ram_mem_type is array (119 downto 0) of std_logic_vector(11 downto 0);
	signal ram_mem : ram_mem_type; 
	signal WADDR : std_logic_vector(6 downto 0);  
	signal RADDR : std_logic_vector(6 downto 0);  
	--signal DelayLaunchFlag : std_logic;

		
	------------------------------------------------  
	----------------------for detector 6dB--------------   
	
	signal EnableEdge_6dB : std_logic;
	signal Edge_6dB : std_logic;			 
	signal ClrEdge_6dB : std_logic;

	------------------------------------------------	
	
	-----------------for obn time meas--------------
	
	signal ObnTimeCounter : std_logic_vector(8 downto 0);	 
		
	------------------------------------------------	
	
	----------------delay 4 us for Obn--------------
 
--	signal Obn_4_0us : std_logic;
--	signal ObnDelayFlag : std_logic;
	------------------------------------------------			  
	
	--------------All OK-------------------------------	
	signal ObnOK : std_logic;
	---------------------------------------------------		   
	
	-----------------Params----------------------------
	signal LeveL_6dB : std_logic_vector(11 downto 0);
	signal InternalPorog : std_logic_vector(11 downto 0);		
	signal ExternalPorog : std_logic_vector(11 downto 0);	
	signal Porog : std_logic_vector(11 downto 0);	
	signal ControlRegister: std_logic_vector(7 downto 0);
	---------------------------------------------------		  
	
	-----------------Enable----------------------------	  
	signal GlobalEnable : std_logic;	
	signal ExternalEnable : std_logic;
	---------------------------------------------------
	


begin	   	   
	
	-------------Set Params By NIOS-------------------
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 
			LeveL_6dB <= CONV_STD_LOGIC_VECTOR(240,12);	
			ExternalPorog <= CONV_STD_LOGIC_VECTOR(1000,12);  	
			InternalPorog <= CONV_STD_LOGIC_VECTOR(100,12);  
			ControlRegister <= (others => '0');
		elsif rising_edge(CLK_CPU) then					   
			if WR = '0' then	
				case Address is
					when "00" =>
						ControlRegister <= Data(7 downto 0);
					when "01" =>
						LeveL_6dB <= Data(11 downto 0); 
					when "10" =>
						ExternalPorog <= Data(11 downto 0); 
					when "11" =>
						InternalPorog <= Data(11 downto 0);						
					when others	=> null;						
				end	case;
			end if;	
		end if;
	end process;					   
	
	
	
	------------------------------------------------- 	   
	
	--------------Enable-----------------------------
	ExternalEnable <= '1' when TR = '0' or KS = '1' else '0';	
	GlobalEnable <= ControlRegister(0) and ExternalEnable;
	-------------------------------------------------		 
	
	------------Porog--------------------------------
	Porog <= InternalPorog when	KS = '1' else ExternalPorog; 
	
	-------------------------------------------------	
	
	
	---------------ram write address----------------- 
	
	process(CLK,RST)
	begin			
		if RST = '0' then
		   WADDR <= (others => '0');	
		elsif rising_edge(CLK) then	  
			if WADDR < Delay_3_0us then
		   	   WADDR <= WADDR + 1;			
			else	  
			   WADDR <= (others => '0');
			end if;   
		end if;
	end process;	
	
	-------------write & read RAM------------------------------

	
	process(CLK, RST)
	begin  			
		if RST = '0' then				
--       		for I in 0 to 119 loop
--				ram_mem(I) <= (others => '0');  
--			end loop;   				   
			Adc_3_us <= (others => '0');
		elsif rising_edge(CLK) then
		   ram_mem(CONV_INTEGER(WADDR)) <= Adc;	
		   Adc_3_us <= ram_mem(CONV_INTEGER(WADDR));
		end if;
	end process;  
	-------------------------------------------------	
	
	-------------Enable------------------------------
--
--	process(Obn, RST, DisableFlag)
--	begin
--		if RST = '0' or DisableFlag = '1' then
--			GlobalEnable <= '0';					
--		elsif falling_edge(Obn)	then 
--			if Enable = '1' and ControlRegister(0) = '1' then 	 
--				GlobalEnable <= '1'; --on 				
--			end	if;
--		end if;
--	end process;	
--	
--	process(CLK, RST)
--	begin
--		if RST = '0' then
--			DisableFlag <= '0';					
--		elsif rising_edge(CLK)	then 
--			if GlobalEnable	= '1' then 	  
--				if Enable = '0' then --off	
--					if Obn = '1' then  --not active
--						DisableFlag <= '1'; --off
--					end if;		 
--				end	if;	   
--			else	
--				DisableFlag <= '0';			
--			end if;	
--		end if;
--	end process;		
--	
	-------------------------------------------------
	
	---------------meas obn time--------------------

	process(CLK, RST)
	begin		
		if RST = '0' then
			ObnTimeCounter <= (others => '0');
		elsif rising_edge(CLK) then
			if Obn = '0' then
				ObnTimeCounter <= ObnTimeCounter + 1; 
			else
				ObnTimeCounter <= (others => '0');
			end if;
		end	if;		
		
	end process;	
	
	-------------------------------------------------- 	


	--------------All OK-------------------------------			

	process(CLK, RST)
	begin	
		if RST = '0' then
			ObnOK <= '0';
		elsif rising_edge(CLK) then
			if  ObnTimeCounter >= Delay_2_0us and AdcMax >= Porog and GlobalEnable = '1' then --  and (Enable = '0' or KS_PRM = '1')  and (AdcMax >= Porog and EnableEdge_6dB = '1') 
		  		ObnOK <= '1'; 
			else
				ObnOK <= '0'; 
			end if;	  
		end if;	
	end process;
	
	
	---------------------------------------------------
	

	
	------------adc max---------------------------------
	
	process(CLK, RST)
	begin			
		if RST = '0' then 
			AdcMax <= (others => '0');		
		elsif rising_edge(CLK) then	  
			if Obn = '0' then
				if AdcMax < Adc then
					AdcMax <= Adc;			
				end	if;
			else   
				AdcMax <= (others => '0');	
			end if;	
		end if;
	end process;		
	
	---------------------------------------------------	   
	
--	--------------------EnableEdge_6dB-----------------
	process(ObnOK, RST, ClrEdge_6dB, Obn)
	begin			
		if RST = '0' or ClrEdge_6dB = '1' or Obn = '1' then
		  EnableEdge_6dB <= '0';
		elsif rising_edge(ObnOK) then				
		  EnableEdge_6dB <= '1';		 
		end if;
	end process;	
	
	
	---------------------------------------------------
	
	--------------------Edge_6dB------------------------
	process(CLK, RST, ClrEdge_6dB)
	begin			
		if RST = '0' or ClrEdge_6dB = '1' then
		  Edge_6dB <= '0';
		elsif rising_edge(CLK) then		
			if EnableEdge_6dB = '1' then   
				if AdcMax - LeveL_6dB >= LeveL_6dB then
					if Adc_3_us >= (AdcMax - LeveL_6dB) then  
						Edge_6dB <= '1';	   
					end if;	
				end if;	
			else	
				Edge_6dB <= '0';
			end if;
		end if;
	end process;	
	---------------------------------------------------		
	
	
	--------------------ClrEdge_6dB--------------------
	process(CLK, RST)	
		variable DelayCnt : std_logic;
	begin			
		if RST = '0' then
		  ClrEdge_6dB <= '0';	
		  DelayCnt := '0';
		elsif rising_edge(CLK) then		
			if Edge_6dB = '1' then 	 	
			 	if DelayCnt	= '1' then	
					 ClrEdge_6dB <= '1';
				end	if;	
				DelayCnt := '1';
			else	 	
				DelayCnt := '0';  				
				ClrEdge_6dB <= '0';	 			
			end if;
		end if;
	end process;	
	---------------------------------------------------	
	
	------------To output------------------------------
	Edge <= Edge_6dB when ObnOK = '1' else '0';
	AdcMaxOut <= AdcMax; 	
	---------------------------------------------------
	
	---------------------debug-------------------------
	dbgEnableEdge_6dB <= EnableEdge_6dB;
	dbgEdge_6dB <= Edge_6dB;
	dbgClrEdge_6dB <= ClrEdge_6dB;
	dbgObnOK <= ObnOK ;
	
	---------------------------------------------------

end Detector_arch;
