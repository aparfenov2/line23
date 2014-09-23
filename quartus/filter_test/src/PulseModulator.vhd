-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity pulses is
	 port(
		 clk : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 en : in STD_LOGIC;
		 wr : in STD_LOGIC;
		 data : in STD_LOGIC_vector(31 downto 0);
		 addr : in STD_LOGIC_vector(3 downto 0);  
		 OutSamples : out std_logic_vector(11 downto 0);
		 takt : out STD_LOGIC;
		 sync : out STD_LOGIC;
		 cmd : out STD_LOGIC
	     );
end pulses;

--}} End of automatically maintained section

architecture pulses_arch of pulses is	  								

	signal clk_1MHz : std_logic;
	constant Clk1MHzFactor : integer := 40;	--40MHz / 4 = 1 MHz 

	signal clk_10kHz : std_logic;
	constant Clk10KhzFactor : integer := 4000;	--40MHz / 4000 = 10 KHz 	
	
	signal clk_4Hz : std_logic;
	constant Clk4HzFactor : integer := 2500;	--10 KHz / 2500 = 4 Hz 	
	
	
	
	
	signal pulse15ms : std_logic;  		 
	signal pulse15msEnable : std_logic;
	constant Time15msFactor : integer := 150;	-- 15 ms / 150 = 100 us => 10 KHz
	constant Time8_5msFactor : integer := 85;	-- 8.5 ms / 85 = 100 us => 10 KHz
	constant Time6_5msFactor : integer := 65;	-- 6.5 ms / 65 = 100 us => 10 KHz

	
	constant PulsesCount : integer := 16;	
		
	signal strobe15ms : std_logic;		 
	
	signal cmdStrobe : std_logic;	 	
	signal cmdPulse : std_logic;
	constant CmdPosition1 : integer := 2;
	constant CmdPosition2 : integer := 11;	   
	
	--------------for memory:
		
	
	
	
	
		-- Component declaration of the "ram_cos3475(syn)" unit defined in
	-- file: "./src/ram_cos3475.vhd"
	component ram_cos3475
	port(
		address : in STD_LOGIC_VECTOR(8 downto 0);
		clock : in STD_LOGIC;
		data : in STD_LOGIC_VECTOR(11 downto 0);
		wren : in STD_LOGIC;
		q : out STD_LOGIC_VECTOR(11 downto 0));
	end component;
	for all: ram_cos3475 use entity work.ram_cos3475(syn);	
		
		
	constant MaxAddrCos3475 : std_logic_vector(8 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(288,9);		
	signal AddrCos3475 : std_logic_vector(8 DOWNTO 0);	
	signal Cos3475 : std_logic_vector(11 DOWNTO 0);		
	signal StrobedCos3475 : std_logic_vector(11 DOWNTO 0);			
	signal DataBus : std_logic_vector(11 DOWNTO 0);		
	
	-- Component declaration of the "ram_cos5110(syn)" unit defined in
	-- file: "./src/ram_cos5110.vhd"
	component ram_cos5110
	port(
		address : in STD_LOGIC_VECTOR(7 downto 0);
		clock : in STD_LOGIC;
		data : in STD_LOGIC_VECTOR(11 downto 0);
		wren : in STD_LOGIC;
		q : out STD_LOGIC_VECTOR(11 downto 0));
	end component;
	for all: ram_cos5110 use entity work.ram_cos5110(syn);	
		
	constant MaxAddrCos5110 : std_logic_vector(7 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(196,8);		
	signal AddrCos5110 : std_logic_vector(7 DOWNTO 0);	
	signal Cos5110 : std_logic_vector(11 DOWNTO 0);		
	signal StrobedCos5110 : std_logic_vector(11 DOWNTO 0);			

		
		-- Component declaration of the "ram_cos7395(syn)" unit defined in
	-- file: "./src/ram_cos7395.vhd"
	component ram_cos7395
	port(
		address : in STD_LOGIC_VECTOR(7 downto 0);
		clock : in STD_LOGIC;
		data : in STD_LOGIC_VECTOR(11 downto 0);
		wren : in STD_LOGIC;
		q : out STD_LOGIC_VECTOR(11 downto 0));
	end component;
	for all: ram_cos7395 use entity work.ram_cos7395(syn);

	constant MaxAddrCos7395 : std_logic_vector(7 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(135,8);		
	signal AddrCos7395 : std_logic_vector(7 DOWNTO 0);	
	signal Cos7395 : std_logic_vector(11 DOWNTO 0);		
	signal StrobedCos7395 : std_logic_vector(11 DOWNTO 0);		
	signal MixedCos : std_logic_vector(11 DOWNTO 0);			
		
		
		
	
begin	   	
	
	---------Divide Frequency 40 MHz to 1 MHz

	process (clk, rst)	  
		variable Counter : natural;
		begin 
		if rst = '0' then		
		    Counter := 0; 
			clk_1MHz <= '0';
		elsif rising_edge(clk) then
			if Counter  <  Clk1MHzFactor - 1 then   
				Counter := Counter + 1;	
				clk_1MHz <= '0';
			else
				Counter := 0;  
				clk_1MHz <= '1';
			end if;	 
		end if;		
	end process;		
	
	
	InstCos3475 : ram_cos3475
		port map(
			address => AddrCos3475,
			clock => clk,
			data => DataBus,
			wren => '0',
			q => Cos3475
		);	  		
		
		
	process (clk, rst)	  
		begin 
		if rst = '0' then		
		    AddrCos3475 <= (others => '0'); 			
		elsif rising_edge(clk) then
			if clk_1MHz = '1' then
				if AddrCos3475  <  MaxAddrCos3475 - 1 then   
					AddrCos3475 <= AddrCos3475 + 1; 	
				else
					AddrCos3475 <= (others => '0'); 		
				end if;	 
			end if;		
		end if;		
	end process;		
	
	
	
	InstCos5110 : ram_cos5110
		port map(
			address => AddrCos5110,
			clock => clk,
			data => DataBus,
			wren => '0',
			q => Cos5110
		);		 	 
		
	process (clk, rst)	  
		begin 
		if rst = '0' then		
		    AddrCos5110 <= (others => '0'); 			
		elsif rising_edge(clk) then		  
			if clk_1MHz = '1' then
				if AddrCos5110  <  MaxAddrCos5110 - 1 then   
					AddrCos5110 <= AddrCos5110 + 1; 	
				else
					AddrCos5110 <= (others => '0'); 		
				end if;	
			end if;		
		end if;		
	end process;				
		
	InstCos7395 : ram_cos7395
		port map(
			address => AddrCos7395,
			clock => clk,
			data => DataBus,
			wren => '0',
			q => Cos7395
		);				
		
		
	process (clk, rst)	  
		begin 
		if rst = '0' then		
		    AddrCos7395 <= (others => '0'); 			
		elsif rising_edge(clk) then	 
			if clk_1MHz = '1' then
				if AddrCos7395  <  MaxAddrCos7395 - 1 then   
					AddrCos7395 <= AddrCos7395 + 1; 	
				else
					AddrCos7395 <= (others => '0'); 		
				end if;	   
			end if;	   	
		end if;		
	end process;			
	
	
	---------Divide Frequency 40 MHz to 10 kHz

	process (clk, rst)	  
		variable Counter : natural;
		begin 
		if rst = '0' then		
		    Counter := 0; 
			clk_10kHz <= '0';
		elsif rising_edge(clk) then
			if Counter  <  Clk10KhzFactor - 1 then   
				Counter := Counter + 1;	
				clk_10kHz <= '0';
			else
				Counter := 0;  
				clk_10kHz <= '1';
			end if;	 
		end if;		
	end process;	
	
	---------Divide Frequency 10 kHz to 4 Hz
	
	process (clk, rst)	  
		variable Counter : natural;
		begin 
		if rst = '0' then		
		    Counter := 0; 
			clk_4Hz <= '0';
		elsif rising_edge(clk) then		 
			if 	clk_10kHz = '1' then
				if Counter  <  Clk4HzFactor - 1 then   
					Counter := Counter + 1;	
					clk_4Hz <= '0';
				else
					Counter := 0;  
					clk_4Hz <= '1';
				end if;	 
			end if;	
		end if;		
	end process;	 
 
	----------------Generating the burts of pulses-------------	  
	--												240 ms
	--		     ----------------------------------------------------------------------------------
	-- SYNC		|																				   |
	-----------		        																		-----------------------
	--		 	 1			  2													 15			 16
	--		     ---		 ---												 ---		 ---
	-- TAKT		|	|		|	|	......................................		|	|		|	|									   |
	-----------		 -----       ----										---		 -----		 --------------------------
	--			|			|
	--			|8.5ms+6.5ms|
	--			|	15ms	|
	
	--			 		CmdPosition1											CmdPosition2	 
	--		     		 	 ---												 ---		 
	-- CMD					|	|	......................................		|	|										   |
	-----------------------       ----										---		 ------------------------------
	
	
	process (clk, rst, en)	  
		variable Counter : natural;	
		variable PulseCounter : natural;
		begin 
		if rst = '0' or en = '0' then		
		    Counter := 0; 	
			PulseCounter := 0; 	
			pulse15ms <= '0';  
			strobe15ms <= '0';	  
			pulse15msEnable <= '0';	
			cmdStrobe <= '0';
		elsif rising_edge(clk) then		
			if clk_4Hz = '1' then
				pulse15msEnable <= '1';				
			elsif pulse15msEnable = '1' then
				if 	clk_10kHz = '1' then
					if Counter  <  Time15msFactor - 1 then   
						Counter := Counter + 1;	
						pulse15ms <= '0';	  	
					
						if Counter  <  Time8_5msFactor + 1 then  
							strobe15ms <= '1';	
							
						else    
							strobe15ms <= '0';
						end if;	 
						
					else
						Counter := 0;  
						pulse15ms <= '1';  
						strobe15ms <= '0';			  
						if PulseCounter < PulsesCount - 1 then		 							
							PulseCounter := PulseCounter + 1;	 	
							if PulseCounter = CmdPosition1 - 1 or PulseCounter = CmdPosition2 - 1 then
								cmdStrobe <= '1';
							else
								cmdStrobe <= '0';
							end if;									
						else
							pulse15msEnable <= '0';
							cmdStrobe <= '0';
						end if;
					end if;	 
				end if;	
			else
				pulse15ms <= '0';  
				strobe15ms <= '0';	 
				PulseCounter := 0;	  
				cmdStrobe <= '0';
			end if;		
		end if;		
	end process;		
	
	
	StrobedCos7395	<= Cos7395 when  pulse15msEnable = '1' else (others => '0');  --sync
	StrobedCos5110	<= Cos5110 when  strobe15ms = '1' else (others => '0');  --takt
	StrobedCos3475	<= Cos3475 when  cmdPulse = '1' else (others => '0');  --cmd	
		
	
	MixedCos <= ('0' & '0'& StrobedCos7395(11 downto 2) ) + ('0' & '0'& StrobedCos5110(11 downto 2))	+ ('0' & '0'& StrobedCos3475(11 downto 2));	  
	
	OutSamples <= MixedCos;
--	OutSamples <= Cos3475;
--	OutSamples <= ('0' & '0'& StrobedCos7395(11 downto 2));
	
	cmdPulse <= cmdStrobe and strobe15ms;
	takt <=  strobe15ms;
	sync <=  pulse15msEnable;
	cmd <= 	cmdPulse;
	
	

end pulses_arch;
