--Control(7) = 1 => Start
--Control(6 downto 0) - MaxIndex
--Control(8) = 1 => Enable Insert
--
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;	 
use IEEE.STD_logic_unsigned.all;  
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;


entity ID is
	 port(
		 CLK : in STD_LOGIC;
		 CLK_CPU : in STD_LOGIC; 
		 CLK_1KHz : in std_logic;  
		 Clk_1350Hz : in std_logic;
		 RST : in std_logic;
		 WR : in STD_LOGIC;
		 Address : in STD_LOGIC_VECTOR(2 downto 0);
		 Data : in STD_LOGIC_VECTOR(31 downto 0);
		 Launch : in std_logic;
		 Blank : out STD_LOGIC;
		 Insert : out STD_LOGIC; 
		 Start : out STD_LOGIC		 
	     );
end ID;


architecture ID_arch of ID is  	 

	---------subtypes for Counters---	 
	subtype	NATURAL16 is natural range 0 to 65535;	
	subtype	NATURAL15 is natural range 0 to 32767;
	subtype	NATURAL12 is natural range 0 to 4095;
	subtype	NATURAL7 is natural range 0 to 127;	  
	subtype	NATURAL5 is natural range 0 to 31; 
	subtype	NATURAL2 is natural range 0 to 3; 
	
	---------------------------------			
	
	constant Time_100ms : natural := 149;


	---------------------RAM------------------------------------------
	type ram_mem_type is array(3 downto 0) of std_logic_vector(31 downto 0);	
	signal ID_Code : ram_mem_type;
	--------------------------------------------------------------------									 
	 
	---------Address for RAM-------									 
	signal WordAddress : NATURAL2;			 
	signal BitAddress : NATURAL5;	
	constant MaxWordAddress : NATURAL2 := 3;	 
	-------------------------------
 
	---------Enable Control--------
	signal GlobalEnable : std_logic;  
	signal EnableID : std_logic;	
	signal EnableIdFlag : std_logic;
	signal DoneID : std_logic;		
	--------------------------------
 
	--------------------------------
	signal Manipulation : std_logic;
	
	--------------------------------		  
	
	--------Delay 100 us (for Insert)
	signal DeleyedSignal : std_logic;
	signal DelayFlag: std_logic;	 
	signal InsertStrobe : std_logic; 
	signal InsertEnable : std_logic;
	---------------------------------  
		
	---------Control Register-------- 
	--Control(7) -> r.e. -> Starting ID
	--Control(6) = 1 - Insert Enable, 0 - Insert Disable	
	signal Control : std_logic_vector(7 downto 0);	
	---------------------------------
		
	-------------Clocks-------------- 
	signal Clk_100ms : std_logic;	
	--signal Clk_1350Hz : std_logic;	 
	--signal Clk_40s : std_logic;
	---------------------------------				
	

begin 
	
------------Set Params--------------------------	
process(CLK_CPU, RST)
begin
	if RST = '0' then 
		Control <= (others => '1');	
	elsif rising_edge(CLK_CPU) then
		if WR = '0' then	
			if CONV_INTEGER(Address) <= 3 then
				ID_Code(CONV_INTEGER(Address)) <= Data;
			else
				Control <= Data(7 downto 0);
			end if;		
		end if;	
	end if;
end process;

InsertEnable <= Control(6);	
------------------------------------------------

-----------------Clk100ms-----------------------
--Clk100ms = CLK_1KHz/100
process (CLK_1KHz, RST)	 
	variable Counter : NATURAL;
begin 
	if RST = '0' then		
	    Counter := 0; 
		Clk_100ms <= '0';
	elsif rising_edge(CLK_1KHz) then
		if Counter  < Time_100ms then
			Counter := Counter + 1;	
			Clk_100ms <= '0';
		else
			Counter := 0;  
			Clk_100ms <= '1';
		end if;	 
	end if;		   
end process;
--------------------------------------------------


----------------------Clk1350Hz--------------------
----Clk1350Hz = CLK/29630 
----Clk1350 = 1350.165 Hz
--
--process (CLK, RST)	  
--	variable Counter : NATURAL15;
--begin 
--	if RST = '0' then		
--	    Counter := 0; 
--		Clk_1350Hz <= '0';
--	elsif rising_edge(CLK) then
--		if Counter  <  29628 then   -- <= 29630 - 1
--			Counter := Counter + 1;	
--			Clk_1350Hz <= '0';
--		else
--			Counter := 0;  
--			Clk_1350Hz <= '1';
--		end if;	 
--	end if;		   
--end process;	
----------------------------------------------------------------		



---------------Delay 100 us (InsertStrobe)---------------------

	process(Clk_1350Hz, RST, InsertStrobe)
	begin
		if RST = '0' or InsertStrobe = '1' then
			DelayFlag <= '0';
		elsif rising_edge(Clk_1350Hz)	 then
			DelayFlag <= '1';
		end if;		
	end process;
	
	
	process(CLK, RST)  
		variable Counter : NATURAL12;	 
	begin			
		if RST = '0' then
		   Counter := 0;  
		   InsertStrobe <= '0';
		elsif rising_edge(CLK) then	 
			if DelayFlag = '1' then 				
				if Counter < 4000 then
			   	   Counter := Counter + 1;
				   InsertStrobe <= '0';	  
				else	  
				   Counter := 0; 
				   InsertStrobe <= '1';
				end if;
			else	
				Counter := 0;	
				InsertStrobe <= '0';
			end if;	
		end if;
	end process;	
	
--------------------------------------		 

	
-----------Enable---------------------	
EnableID <= Launch and Control(7);

process(EnableID, RST, DoneID)
begin 		 
	if RST = '0' or DoneID = '1' then  
		EnableIdFlag <= '0';	
	elsif rising_edge(EnableID) then				
		EnableIdFlag <= '1'; 	
	end if;	
end process;  

process(Clk_100ms, RST, DoneID)
begin 		 
	if RST = '0' or DoneID = '1' then  
		GlobalEnable <= '0';	
	elsif rising_edge(Clk_100ms) then
		if EnableIdFlag = '1' then 
			GlobalEnable <= '1';
		else
			GlobalEnable <= '0';
		end if;
	end if;	
end process;  						 
--------------------------------------

-------------Read Address Counter-----
process(Clk_100ms, RST)
begin 		 
	if RST = '0' then 
		BitAddress <= 0;	   
		WordAddress <= 0;  
		DoneID <= '0';
	elsif rising_edge(Clk_100ms) then
		if GlobalEnable = '1' then	 
			if BitAddress < 31 then
				BitAddress <= BitAddress + 1;	
			else	
				if WordAddress < MaxWordAddress then
					WordAddress <= WordAddress + 1;
				else	
					WordAddress <= 0;	
					DoneID <= '1';
				end if;	
				BitAddress <= 0;  
			end if;	
		else		 
			DoneID <= '0';
			WordAddress <= 0;
			BitAddress <= 0;				
		end if;
	end if;	

end process; 
---------------------------------------		

-----------Read------------------------
process(Clk_100ms, RST)
begin 			   
	if RST = '0' then
		Manipulation <= '0';
	elsif rising_edge(Clk_100ms) then
		if GlobalEnable = '1' then 	
			Manipulation <= ID_Code(WordAddress)(BitAddress);
		else
			Manipulation <= '0';
		end if;
	end if;	
end process;  						 
--------------------------------------

Blank <= Manipulation and GlobalEnable;
Start <= Clk_1350Hz	when Manipulation = '1' else '0';
Insert <= InsertStrobe when	InsertEnable = '1' and Manipulation = '1' else '0';   

end ID_arch;
