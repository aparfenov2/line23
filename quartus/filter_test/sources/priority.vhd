--------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity Priority is
	 port(
	 	 CLK : in STD_LOGIC;  
	 	 RST : in STD_LOGIC;	

		
		 ID_Blank : in STD_LOGIC;
		 Insert : in STD_LOGIC; 
		 ID : in STD_LOGIC; 
		 KS : in STD_LOGIC;
		 KsFrw : in std_logic;
		 OD : in STD_LOGIC;
		 HIP : in STD_LOGIC;      
		 
		 DoneGeneration : in std_logic;
		 
		 Start : out std_logic;
		 KsStrobe : out std_logic;		
		 KsBlank : out std_logic
		 		 
	
	     );
end Priority;

--}} End of automatically maintained section

architecture Priority_arch of Priority is  				   

	-- Component declaration of the "singleimpulse(singleimpulse_arch)" unit defined in
	-- file: "./../src/singleimpulse.vhd"
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


	constant Delay_130_0_us : std_logic_vector(15 downto 0) := CONV_STD_LOGIC_VECTOR(5200, 16);

	--signal DoneGeneration : std_logic;		 
	signal EnableStart : std_logic;	  
	
	signal StartForm : std_logic;							
	signal ClrStartForm : std_logic;


	
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

	
	signal LockHip : std_logic;
	signal ClrLockHip : std_logic;
	
		
	-----------------------------------------Blank After KS-----------------------------------------------

	signal KSDone: std_logic;								   	   
	signal BlankAllAfterKS : std_logic := '0';
	------------------------------------------------------------------------------------------------------
	
--	-- Component declaration of the "delay_lib(delay_arch)" unit defined in
--	-- file: "./../src/home/delay_lib.vhd"
--	component delay_lib
--	generic(
--		DelayValue : INTEGER := 10);
--	port(
--		CLK : in STD_LOGIC;
--		RST : in STD_LOGIC;
--		Start : in STD_LOGIC;
--		DelayedStart : out STD_LOGIC);
--	end component;
--	for all: delay_lib use entity work.delay_lib(delay_arch);

	

begin  	 	

	
-------------------------------------	ID State Machine --------------------------------------------------
	
	process(ID, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			IDEnable <= '0';
		elsif rising_edge(ID) then 
			if ID_Blank = '1'and EnableStart = '0' and BlankAllAfterKS = '0' then
				IDEnable <= '1';	  
			end if;
		end if;
	
	end process;
	
	
---------------------------------------------------------------------------------------------------------	

-------------------------------------	Insert State Machine --------------------------------------------
	
	process(Insert, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			InsertEnable <= '0';
		elsif rising_edge(Insert) then 
			if ID_Blank = '1' and IDEnable = '0' and EnableStart = '0' and BlankAllAfterKS = '0' then
				InsertEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
---------------------------------------------------------------------------------------------------------		
	
	
-------------------------------------	KS State Machine ------------------------------------------------
	
	process(KS, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			KSEnable <= '0';
		elsif rising_edge(KS) then 
			if ID_Blank = '0' and EnableStart = '0'  and BlankAllAfterKS = '0'then
				KSEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
---------------------------------------------------------------------------------------------------------	

-------------------------------------OD State Machine ---------------------------------------------------
	
	process(OD, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			ODEnable <= '0';
		elsif rising_edge(OD) then 
			if ID_Blank = '0' and KSEnable = '0' and EnableStart = '0' then	 --   and BlankAllAfterKS = '0' на время после КС не блокируется - ждет ответа на свой КС
				ODEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
---------------------------------------------------------------------------------------------------------	

-------------------------------------HIP State Machine --------------------------------------------------
	
	process(HIP, DoneGeneration, RST)
	begin
		if RST = '0' or DoneGeneration = '1' then
			HIPEnable <= '0';
		elsif rising_edge(HIP) then 
			if ID_Blank = '0' and KSEnable = '0' and ODEnable = '0' and EnableStart = '0' and BlankAllAfterKS = '0' and LockHip = '0' then
				HIPEnable <= '1';  
			end if;	
		end if;
	
	end process;	   	
	
-----------------------------------------------------------------------------------------------------------	

-------------------------------------	EnableGeneration---------------------------------------------------	
	EnableStart <= IDEnable or InsertEnable or KSEnable or ODEnable or HIPEnable;			 

	process(EnableStart, RST, ClrStartForm)
	begin
		if RST = '0' or ClrStartForm = '1' then
			StartForm <= '0';
		elsif rising_edge(EnableStart) then  
			StartForm <= '1';  
		end if;	   	
	end process;	 
	
	process(CLK, RST)
	begin
		if RST = '0' then
			ClrStartForm <= '0';
		elsif rising_edge(CLK) then  
			if StartForm = '1' then
				ClrStartForm <= '1';  
			else	
				ClrStartForm <= '0';
			end if;	
		end if;	   	
	end process;	 	
	



-----------------------------------------------------------------------------------------------------------		  		





-----------------------------------------Blanking KS----------------------------------------------------------	  

 	   Blanking_KS: singleimpulse	   	 
		port map (
			 CLK => CLK,
			 RST => RST,	
			 polarity => '1',
			 length => Delay_130_0_us, --5200
			 start => KSEnable,
			 outedge => KSDone
	);	   
	
	
	process(KSEnable, RST, KSDone)
	begin 
		if RST = '0' or KSDone = '1' then
			BlankAllAfterKS	<= '0';	   
		elsif rising_edge(KSEnable) then  
			BlankAllAfterKS	<= '1';	  		
		end if;
	end process;
	

-----------------------------------------------------------------------------------------------------------

--	mLockHip : delay_lib
--	generic map(
--		DelayValue => 2800
--	)
--	port map(
--		CLK => CLK,
--		RST => RST,
--		Start => KsFrw,
--		DelayedStart => ClrLockHip
--	);
	
	process(CLK, RST, KS)
	begin 
		if RST = '0' or KS = '1' then
			LockHip	<= '0';	   
		elsif rising_edge(CLK) then  
			if KsFrw = '1' then
				LockHip	<= '1';	 
			end if;	
		end if;
	end process;





------------------------------------- Start ---------------------------------------------------------------	
Start <= ClrStartForm;
KsStrobe <= KSEnable;	
KsBlank <= BlankAllAfterKS; 

-----------------------------------------------------------------------------------------------------------


end Priority_arch;
