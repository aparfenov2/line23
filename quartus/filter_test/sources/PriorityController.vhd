---------------------------------X mode:-------------------------------------------------	

--
-- Start 		 ______________________________________________________________
--		 _______|						 						               |________ 25 us
--
--										  
--				| 0 us											               |	25 us
-- StartDAC		    _______________________ 
--		 	_______|   	  464 samples	   |_____________________________________________
--
--				   | 0.7 us  	 		   |  12.3 us
-- StartDAC							    	 __________________________ 
--	________________________________________|   	464 samples		   |_________________
--
--				   							|  12.7 us				   | 24.3 us
--
-- StartPUM			    __________________		   ___________________
--	___________________|		9.3 us	  |_______|  9.3 us			  |___________________
--
--					   | 1.5 us		      |10.8us |  13.5 us		  |  22.8	|25 us
--
--																								
--StartADC1	= StartDAC1	+ 0.2 us (transport ADC delay)	 len = 473 samples
--StartADC2	= StartDAC2	+ 0.2 us (transport ADC delay)	 len = 473 samples
--
--				
--
--
--

-------------------------------------------Y mode:--------------------------------------------------------	   

--HIP, ID, OD:

--
-- Start 		 ____________________________________________________________________________
--		 _______|						 						                             |__________  us
--
--										  
--				| 0 us											            				 |	 43 us
-- StartDAC		    _______________________ 
--		 	_______|   	  464 samples	   |____________________________________________________________
--
--				   | 0.7 us  	 		   |  12.3 us
-- StartDAC							    	                   __________________________ 
--	__________________________________________________________|   	464 samples          |______________
--									
--				   										      |  30.7 us				 | 42.3 us
--
-- StartPUM			    __________________		                   ___________________
--	___________________|		9.3 us	  |_______________________|  9.3 us			  |_________________
--
--					   | 1.5 us		      |10.8us 				  | 31.5 us		   	  | 40.8  |43 us
--
--																		


-------------------------------------------Y mode (just KS):--------------------------------------------

--HIP, ID, OD:

--
-- Start 		 ____________________________________________________________________________
--		 _______|						 						                             |__________  us
--
--										  
--				| 0 us											            				 |	 49 us
-- StartDAC		    _______________________ 
--		 	_______|   	  464 samples	   |____________________________________________________________
--
--				   | 0.7 us  	 		   |  12.3 us
-- StartDAC							    	                   __________________________ 
--	__________________________________________________________|   	464 samples          |______________
--									
--				   										      |  36.7 us				 | 48.3 us
--
-- StartPUM			    __________________		                   ___________________
--	___________________|		9.3 us	  |_______________________|  9.3 us			  |_________________
--
--					   | 1.5 us		      |10.8us 				  | 37.5 us		   	  | 46.8  |49 us
--
--																		





--------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity PriorityController is
	 port(
	 	 CLK : in STD_LOGIC; 
	 	 CLK_CPU : in STD_LOGIC; 
	 	 RST : in STD_LOGIC;	
		 WR : in STD_LOGIC;
		 Data : in std_logic_vector(31 downto 0);  

		
		 ID_Blank : in STD_LOGIC;
		 Insert : in STD_LOGIC; 
		 ID : in STD_LOGIC; 
		 KS : in STD_LOGIC;
		 OD : in STD_LOGIC;
		 HIP : in STD_LOGIC;  
		 
		 WrRequest : in std_logic;
		 WrDone : in std_logic;	 
		 WrReady : out std_logic;
		 
		 SwitchTR : out std_logic;
		 StartDAC : out STD_LOGIC;
		 StartPUM : out STD_LOGIC;
		 StartADCFirst : out std_logic;
		 StartADCSecond : out std_logic;
		 StrobeKS : out	std_logic	;
		 StrobeOD : out std_logic
		 
	
	     );
end PriorityController;

--}} End of automatically maintained section

architecture PriorityController_arch of PriorityController is  

   
	----------------------------------------------------------------------------------------  
	
	constant VectorLength : natural := 11;
	
	signal DelayCounter : std_logic_vector(VectorLength - 1 downto 0);	 --max Delay = 43 us log2(43us/25ns) = 10.7 => 11 bit
	
	constant SampleTime : integer :=25;	 
	constant ADCTransportDelay : integer :=200; 
	
	constant Delay_0_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(700/SampleTime-1,VectorLength); 
	constant Delay_0_9us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(900/SampleTime-1,VectorLength); 
	constant Delay_1_5us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(1500/SampleTime-1,VectorLength); 
	constant Delay_10_8us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(10800/SampleTime-1,VectorLength); 
	constant Delay_12_3us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(12300/SampleTime-1,VectorLength); 
	constant Delay_12_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(12700/SampleTime-1,VectorLength); 
	constant Delay_12_8us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(12800/SampleTime-1,VectorLength); 
	constant Delay_12_9us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(12900/SampleTime-1,VectorLength); 
	constant Delay_13_5us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(13500/SampleTime-1,VectorLength); 
	constant Delay_22_8us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(22800/SampleTime-1,VectorLength); 
	constant Delay_24_3us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(24300/SampleTime-1,VectorLength); 	
	constant Delay_24_5us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(24500/SampleTime-1,VectorLength); 	
	constant Delay_25_0us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(25000/SampleTime-1,VectorLength);
	constant Delay_30_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(30700/SampleTime-1,VectorLength);
	constant Delay_30_9us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(30900/SampleTime-1,VectorLength);
	constant Delay_31_5us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(31500/SampleTime-1,VectorLength);   	 
	constant Delay_31_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(31700/SampleTime-1,VectorLength);   	 
	constant Delay_33_0us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(33000/SampleTime-1,VectorLength);   	 	
	constant Delay_36_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(36700/SampleTime-1,VectorLength);
	constant Delay_36_9us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(36900/SampleTime-1,VectorLength);	
	constant Delay_37_5us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(37500/SampleTime-1,VectorLength);		 		
	constant Delay_40_8us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(40800/SampleTime-1,VectorLength); 	
	constant Delay_42_3us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(42300/SampleTime-1,VectorLength); 	
	constant Delay_42_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(42700/SampleTime-1,VectorLength); 	
	constant Delay_43_0us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(43000/SampleTime-1,VectorLength); 		   	
	constant Delay_46_8us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(46800/SampleTime-1,VectorLength);
	constant Delay_48_3us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(48300/SampleTime-1,VectorLength);
	constant Delay_48_7us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(48700/SampleTime-1,VectorLength);
	constant Delay_49_0us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(49000/SampleTime-1,VectorLength);
	constant Delay_51_0us : std_logic_vector(VectorLength - 1 downto 0):= CONV_STD_LOGIC_VECTOR(51000/SampleTime-1,VectorLength);
	constant Delay_100_0us : std_logic_vector(11 downto 0):= CONV_STD_LOGIC_VECTOR(100000/SampleTime-1,12);
	constant TransferTimeX : std_logic_vector(VectorLength - 1 downto 0) := Delay_25_0us;
	constant TransferTimeY : std_logic_vector(VectorLength - 1 downto 0) := Delay_43_0us; 
	constant FullTimeX : std_logic_vector(VectorLength - 1 downto 0) := Delay_33_0us;
	constant FullTimeY : std_logic_vector(VectorLength - 1 downto 0) := Delay_51_0us; 
	--
	--	FullTimeX = TransferTimeX + 8 us
	-- aaa 8 us - aiionoeiia a?aiy naee?aiey ia? eiioeunia
	
	
	signal StrobeDAC : std_logic;
	signal StrobePUM : std_logic;	 
	signal StrobeTR : std_logic;   
	signal StrobeADCFirst : std_logic;
	signal StrobeADCSecond : std_logic;
	
	type ModeDME_type is (
			X,
			Y 
			);
	
	
	signal ModeDME : ModeDME_type;	
	signal EnableGeneration : std_logic;	
	signal DoneGeneration : std_logic;		 	 
	
	-----------------------------------------------------------------------------------------
	signal ConfigurationRegister : std_logic_vector(7 downto 0);								 
	--ConfigurationRegister(0) = 0 => X mode (default)
	--ConfigurationRegister(0) = 1 => Y mode 
	
	-----------------------------------------------------------------------------------------
	
	------for ID State Machine----------------------------------------------------------------------------
	
	signal IDEnable : std_logic;  
	------------------------------------------------------------------------------------------------------
	
	------for Insert State Machine------------------------------------------------------------------------
	
	signal InsertEnable : std_logic;  
	------------------------------------------------------------------------------------------------------	
		
		
	------for KS State Machine----------------------------------------------------------------------------
	
	signal KSEnable : std_logic;  
	------------------------------------------------------------------------------------------------------
	
		
	------for OD State Machine----------------------------------------------------------------------------
	
	signal ODEnable : std_logic;  
	------------------------------------------------------------------------------------------------------

	------for HIP State Machine----------------------------------------------------------------------------
	
	signal HIPEnable : std_logic;  
	------------------------------------------------------------------------------------------------------		

	------for WR Control----------------------------------------------------------------------------------
	
	signal WrRequestFlag : std_logic;  	  
	signal WrReadyFlag : std_logic;
	------------------------------------------------------------------------------------------------------	
	
		
	-----------------------------------------Blank After KS-----------------------------------------------
	signal KSDelayCounter :std_logic_vector(11 downto 0);  -- blank all signals on 100 us ater KS
	signal KSDone: std_logic;
	signal EnableKSDelayCounter: std_logic;		   
	signal BlankAllAfterKS : std_logic;
	------------------------------------------------------------------------------------------------------
	

begin  
	
------------------------------------  Settings -----------------------------------------------------------

process(CLK_CPU, RST)
begin
	if RST = '0' then 
		ConfigurationRegister <= (others => '0');
	elsif rising_edge(CLK_CPU) then
		if WR = '0' then	 
			ConfigurationRegister <= Data(7 downto 0);
		end if;	
	end if;
end process;	

ModeDME <= X when ConfigurationRegister(0) = '0' else Y;

----------------------------------------------------------------------------------------------------------
	

-----------------------------------  WR Control ----------------------------------------------------------

process(WrRequest, RST, WrDone)	
begin 		
	if RST = '0' or WrDone = '1' then	 
		WrRequestFlag <= '0';		
	elsif rising_edge(WrRequest) then
		WrRequestFlag <= '1';
	end	if;
end process;	  

process(CLK, RST, WrDone)	
begin 		
	if RST = '0' or WrDone = '1' then	 
		WrReadyFlag <= '0';		
	elsif rising_edge(CLK) then	
		if WrRequestFlag = '1' and ID_Blank = '0' and EnableGeneration = '0' then
			WrReadyFlag <= '1';
		end	if;
	end	if;
end process;	  	  

WrReady <= WrReadyFlag;

----------------------------------------------------------------------------------------------------------	

	
-------------------------------------	ID State Machine --------------------------------------------------
	
	process(ID, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			IDEnable <= '0';
		elsif rising_edge(ID) then 
			if ID_Blank = '1' and WrReadyFlag = '0' and BlankAllAfterKS = '0' then
				IDEnable <= '1';	  
			end if;
		end if;
	
	end process;
	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------	Insert State Machine ----------------------------------------------
	
	process(Insert, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			InsertEnable <= '0';
		elsif rising_edge(Insert) then 
			if ID_Blank = '1' and IDEnable = '0' and WrReadyFlag  = '0' and BlankAllAfterKS = '0' then
				InsertEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------		
	
	
-------------------------------------	KS State Machine --------------------------------------------------
	
	process(KS, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			KSEnable <= '0';
		elsif rising_edge(KS) then 
			if ID_Blank = '0' and WrReadyFlag  = '0' and BlankAllAfterKS = '0'  then
				KSEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------OD State Machine -----------------------------------------------------
	
	process(OD, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			ODEnable <= '0';
		elsif rising_edge(OD) then 
			if ID_Blank = '0' and KSEnable = '0' and WrReadyFlag = '0' and BlankAllAfterKS = '0' then
				ODEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------HIP State Machine --------------------------------------------------
	
	process(HIP, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			HIPEnable <= '0';
		elsif rising_edge(HIP) then 
			if ID_Blank = '0' and KSEnable = '0' and ODEnable = '0' and WrReadyFlag = '0' and BlankAllAfterKS = '0' then
				HIPEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------	EnableGeneration-----------------------------------------------------	
EnableGeneration <= IDEnable or InsertEnable or KSEnable or ODEnable or HIPEnable;


-----------------------------------------------------------------------------------------------------------		  

-----------------------------------------Blank KS----------------------------------------------------------	  
process(CLK, RST, KSDone)
begin
	if RST = '0' or KSDone = '1' then
		EnableKSDelayCounter <= '0';
	elsif rising_edge(CLK) then	   
		if KSEnable = '1' then 
			EnableKSDelayCounter <= '1';			
		end	if;	
	end	if;
end	process;

 

process(CLK, RST)
begin
	if RST = '0' then
		KSDelayCounter <= (others => '0');
		KSDone <= '0';
	elsif rising_edge(CLK) then
		if EnableKSDelayCounter = '1' then
			if KSDelayCounter < Delay_51_0us then 
				KSDelayCounter <= KSDelayCounter + 1; 
				KSDone <= '0';
			else
				KSDelayCounter <= (others => '0'); 
				KSDone <= '1';
			end	if;
		
		else	
			KSDone <= '0';
		end	if;
		
	end	if;
end	process;	   

BlankAllAfterKS <= EnableKSDelayCounter;

-----------------------------------------------------------------------------------------------------------


---------------------------------------Timing Diagram------------------------------------------------------



process(CLK,RST)
begin
	if RST = '0' then
		DelayCounter <= (others => '0');
		StrobeDAC <= '0';
		StrobePUM <= '1';  	
		StrobeTR <= '0';   
		StrobeADCFirst <= '0'; 
		StrobeADCSecond <= '0';					
		DoneGeneration <= '0';			
	elsif rising_edge(CLK) then			
		if EnableGeneration = '1' then	 
			if ModeDME = X then	  
				if DelayCounter < FullTimeX then	
					if DelayCounter < TransferTimeX then	
						
						----------------StrobeDAC--------------------------------
						if (DelayCounter >= Delay_0_7us and DelayCounter < Delay_12_3us) or (DelayCounter >= Delay_12_7us and DelayCounter < Delay_24_3us) then
							StrobeDAC <= '1'; 
						else	
							StrobeDAC <= '0';					
						end if;
						---------------------------------------------------------
						
						----------------StrobePUM--------------------------------
						if (DelayCounter >= Delay_1_5us and DelayCounter < Delay_10_8us) or (DelayCounter >= Delay_13_5us and DelayCounter < Delay_22_8us)	 then
							StrobePUM <= '0'; 
						else	
							StrobePUM <= '1';					
						end if;		
						-------------------------------------------------------- 
						
						---------------StrobeADC1-------------------------------
						if (DelayCounter >= Delay_0_9us and DelayCounter < Delay_12_7us) then
							StrobeADCFirst <= '1'; 
						else	
							StrobeADCFirst <= '0';					
						end if;	
						
						--------------------------------------------------------  
						
						---------------StrobeADC2-------------------------------
						if (DelayCounter >= Delay_12_9us and DelayCounter < Delay_24_5us) then
							StrobeADCSecond <= '1'; 
						else	
							StrobeADCSecond <= '0';					
						end if;	
						
						--------------------------------------------------------
						
						---------------Transfer Enable ------------------------- 
						StrobeTR <= '1';										
						--------------------------------------------------------
						
					else --DelayCounter < TransferTime
						---------------Disable DAC------------------------------
						StrobeDAC <= '0';	  
						--------------------------------------------------------
						---------------Disable PUM------------------------------
						StrobePUM <= '1';			
						--------------------------------------------------------
						---------------Disable Transfer-------------------------
						StrobeTR <= '0'; 
						--------------------------------------------------------
								
					end if;	 --DelayCounter < TransferTime 
					
					--Increment DelayCounter--------------------------------
					DelayCounter <= DelayCounter + 1;  				
					DoneGeneration <= '0';	
					
					--------------------------------------------------------
				else  --DelayCounter < FullTimeX 
					DelayCounter <= (others => '0');
					DoneGeneration <= '1';
					
			   	end if;	 --DelayCounter < FullTransferTime 
				
			else   	--ModeDME = Y 
				if KSEnable = '1' then 
					if DelayCounter < FullTimeY then	
						if DelayCounter < Delay_49_0us then	
							
							----------------StrobeDAC--------------------------------
							if (DelayCounter >= Delay_0_7us and DelayCounter < Delay_12_3us) or (DelayCounter >= Delay_36_7us and DelayCounter < Delay_48_3us)	 then
								StrobeDAC <= '1'; 
							else	
								StrobeDAC <= '0';					
							end if;
							---------------------------------------------------------
							
							----------------StrobePUM--------------------------------
							if (DelayCounter >= Delay_1_5us and DelayCounter < Delay_10_8us) or (DelayCounter >= Delay_37_5us and DelayCounter < Delay_46_8us) then
								StrobePUM <= '0'; 
							else	
								StrobePUM <= '1';					
							end if;		
							--------------------------------------------------------  
							
							---------------StrobeADC1-------------------------------
							if (DelayCounter >= Delay_0_9us and DelayCounter < Delay_12_7us) then
								StrobeADCFirst <= '1'; 
							else	
								StrobeADCFirst <= '0';					
							end if;	
							
							--------------------------------------------------------
							
							---------------StrobeADC2-------------------------------
							if (DelayCounter >= Delay_36_9us and DelayCounter < Delay_48_7us) then
								StrobeADCSecond <= '1'; 
							else	
								StrobeADCSecond <= '0';					
							end if;	
							
							--------------------------------------------------------
							
							---------------Transfer Enable ------------------------- 
							StrobeTR <= '1';										
							--------------------------------------------------------
							
						else --DelayCounter < TransferTime
							---------------Disable DAC------------------------------
							StrobeDAC <= '0';	  
							--------------------------------------------------------
							---------------Disable PUM------------------------------
							StrobePUM <= '1';			
							--------------------------------------------------------
							---------------Disable Transfer-------------------------
							StrobeTR <= '0'; 
							--------------------------------------------------------   
							
							StrobeADCFirst <= '0'; 
							StrobeADCSecond <= '0';	
									
						end if;	 --DelayCounter < TransferTime 
						
						--Increment DelayCounter--------------------------------
						DelayCounter <= DelayCounter + 1;  				
						DoneGeneration <= '0';	
						
						--------------------------------------------------------
					else  --DelayCounter < FullTimeY 
						DelayCounter <= (others => '0');
						DoneGeneration <= '1';
						
				   	end if;	 --DelayCounter < FullTransferTime 
				  else -- if KSEnable = '1' then 	 
					 if DelayCounter < FullTimeY then	
						if DelayCounter < TransferTimeY then	
							
							----------------StrobeDAC--------------------------------
							if (DelayCounter >= Delay_0_7us and DelayCounter < Delay_12_3us) or (DelayCounter >= Delay_30_7us and DelayCounter < Delay_42_3us)	 then
								StrobeDAC <= '1'; 
							else	
								StrobeDAC <= '0';					
							end if;
							---------------------------------------------------------
							
							----------------StrobePUM--------------------------------
							if (DelayCounter >= Delay_1_5us and DelayCounter < Delay_10_8us) or (DelayCounter >= Delay_31_5us and DelayCounter < Delay_40_8us) then
								StrobePUM <= '0'; 
							else	
								StrobePUM <= '1';					
							end if;		
							--------------------------------------------------------  
							
							---------------StrobeADC1-------------------------------
							if (DelayCounter >= Delay_0_9us and DelayCounter < Delay_12_7us) then
								StrobeADCFirst <= '1'; 
							else	
								StrobeADCFirst <= '0';					
							end if;	
							
							--------------------------------------------------------
							
							---------------StrobeADC2-------------------------------
							if (DelayCounter >= Delay_30_9us and DelayCounter < Delay_42_7us) then
								StrobeADCSecond <= '1'; 
							else	
								StrobeADCSecond <= '0';					
							end if;	
							
							--------------------------------------------------------
							
							---------------Transfer Enable ------------------------- 
							StrobeTR <= '1';										
							--------------------------------------------------------
							
						else --DelayCounter < TransferTime
							---------------Disable DAC------------------------------
							StrobeDAC <= '0';	  
							--------------------------------------------------------
							---------------Disable PUM------------------------------
							StrobePUM <= '1';			
							--------------------------------------------------------
							---------------Disable Transfer-------------------------
							StrobeTR <= '0'; 
							--------------------------------------------------------   
							
							StrobeADCFirst <= '0'; 
							StrobeADCSecond <= '0';	
									
						end if;	 --DelayCounter < TransferTime 
						
						--Increment DelayCounter--------------------------------
						DelayCounter <= DelayCounter + 1;  				
						DoneGeneration <= '0';	
						
						--------------------------------------------------------
					else  --DelayCounter < FullTimeY 
						DelayCounter <= (others => '0');
						DoneGeneration <= '1';
						
				   	end if;	 --DelayCounter < FullTransferTime  
					  				  
				  end if; --if KSEnable = '1' then 	  
				end if;	--ModeDME = X
			else -- EnableGeneration = '1'
			
			StrobeDAC <= '0';
			StrobePUM <= '1'; 
			StrobeTR <= '0';  
			StrobeADCFirst <= '0'; 
		    StrobeADCSecond <= '0';	
			DoneGeneration <= '0';
							
		end if;	-- EnableGeneration = '1'
	end if; --rising_edge(CLK)
end process;



------------------------------------- Start ---------------------------------------------------------------	
SwitchTR <= StrobeTR;
StartDAC <= StrobeDAC;
StartADCFirst <= StrobeADCFirst and KSEnable;
StartADCSecond <= StrobeADCSecond and KSEnable;
StartPUM <= StrobePUM;	 
StrobeKS <= BlankAllAfterKS;		   
StrobeOD <= ODEnable and StrobeTR;
-----------------------------------------------------------------------------------------------------------


end PriorityController_arch;
