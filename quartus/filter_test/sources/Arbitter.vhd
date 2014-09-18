library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all;

entity Arbitter is
	 port(
	 	 CLK : in STD_LOGIC; 
	 	 RST : in STD_LOGIC;
		 ID_Activation : in STD_LOGIC;
		 ID_Blank : in STD_LOGIC;
		 Insert : in STD_LOGIC; 
		 ID : in STD_LOGIC; 
		 KS : in STD_LOGIC;
		 OD : in STD_LOGIC;
		 HIP : in STD_LOGIC;	 
		 
		 StartADC : out std_logic;
		 Start : out STD_LOGIC
	     );
end Arbitter;

--}} End of automatically maintained section

architecture Arbitter_arch of Arbitter is  

	 
		
	--------for Generator--------------------------------------------------------------------------------
	signal LaunchRequest : std_logic;				
	signal StartStrobe : std_logic;
	signal Enable : std_logic;
	signal DelayRegister : std_logic_vector(10 downto 0);	
		
	-----------------------------------------------------------------------------------------------------
	
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
	
	
	
	

begin  
	
-------------------------------------	ID State Machine --------------------------------------------------
	
	process(ID,LaunchRequest, RST)
	begin
		if RST = '0' or LaunchRequest = '1' then
			IDEnable <= '0';
		elsif rising_edge(ID) then 
			if ID_Blank = '1' then
				IDEnable <= '1';	  
			end if;
		end if;
	
	end process;
	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------	Insert State Machine --------------------------------------------------
	
	process(Insert,LaunchRequest, RST)
	begin
		if RST = '0' or LaunchRequest = '1' then
			InsertEnable <= '0';
		elsif rising_edge(Insert) then 
			if ID_Blank = '1' then
				InsertEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------		
	
	
-------------------------------------	KS State Machine --------------------------------------------------
	
	process(KS,LaunchRequest, RST)
	begin
		if RST = '0' or LaunchRequest = '1' then
			KSEnable <= '0';
		elsif rising_edge(KS) then 
			if ID_Blank = '0' then
				KSEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------OD State Machine --------------------------------------------------
	
	process(OD,LaunchRequest, RST)
	begin
		if RST = '0' or LaunchRequest = '1' then
			ODEnable <= '0';
		elsif rising_edge(OD) then 
			if ID_Blank = '0' and KSEnable = '0' then
				ODEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------HIP State Machine --------------------------------------------------
	
	process(HIP,LaunchRequest, RST)
	begin
		if RST = '0' or LaunchRequest = '1' then
			HIPEnable <= '0';
		elsif rising_edge(HIP) then 
			if ID_Blank = '0' and KSEnable = '0' and ODEnable <= '0' then
				HIPEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------	LaunchRequest-----------------------------------------------------	
Enable <= IDEnable or InsertEnable or KSEnable or ODEnable or HIPEnable;


-----------------------------------------------------------------------------------------------------------

-------------------------------------Generator--------------------------------------------------------------	
--		        ____________________
-- Start	___|					|___________ - 25 us (DelayRegister up to 999 )
--
--									 ___________
-- Wait afer Gen ___________________|			|__________ - 25 us + 8 us = 33 us (DelayRegister up to 1319)
	
	process(CLK, RST)
	begin
		if RST = '0' then
			DelayRegister <= (others =>'0');  
			LaunchRequest <= '0';  
			StartStrobe <= '0';
		elsif rising_edge(CLK) then
			if Enable = '1' then				   
				if DelayRegister < "10100100111" then --1319 	  
					if DelayRegister < "1111100111" then -- "1111100111" => 999	 
					  StartStrobe <= '1';
					else
					  StartStrobe <= '0';
					end if;	
					LaunchRequest <= '0';
					DelayRegister <= DelayRegister + 1;
				else   
					LaunchRequest <= '1';
					DelayRegister <= (others =>'0');					
				end if;
			else	
				--StartStrobe <= '0';
				LaunchRequest <= '0';
			end if;
		end if;
	
	end process;	
-----------------------------------------------------------------------------------------------------------	 


------------------------------------- Start ---------------------------------------------------------------	
Start <= StartStrobe;
StartADC <= StartStrobe and KSEnable;

-----------------------------------------------------------------------------------------------------------	



end Arbitter_arch;
