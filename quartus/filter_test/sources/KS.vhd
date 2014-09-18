-- on KDivRegister <= 7 => CLK_OUT = 62.5 Hz (t = 16 ms)
--	Data(31) - Enable
--  Data(30) - Reset
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

entity KS is
	 port(
	 	 CLK : in STD_LOGIC;  
	 	 CLK1350 : in std_logic;
	 	 CLK_CPU : in STD_LOGIC; 
	 	 RST : in STD_LOGIC;	
		 WR : in STD_LOGIC;
		 Data : in std_logic_vector(31 downto 0);  
		 Address : std_logic;
		 
		 CLK_OUT : out STD_LOGIC;
		 FeedForwOut : out std_logic;
		 StrobeKg : out std_logic
	     );
end KS;

--}} End of automatically maintained section	 

library IEEE;
use IEEE.std_logic_unsigned.all;

architecture KS_arch of KS is	 

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

	-- Component declaration of the "delay_lib(delay_arch)" unit defined in
	-- file: "./../src/home/delay_lib.vhd"
	component delay_lib
	generic(
		DelayValue : INTEGER := 10);
	port(
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		Start : in STD_LOGIC;
		DelayedStart : out STD_LOGIC);
	end component;
	for all: delay_lib use entity work.delay_lib(delay_arch);
	
	-- Component declaration of the "sync_lib(sync_arch)" unit defined in
	-- file: "./src/home/sync_lib.vhd"
	component sync_lib
	port(
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		Clear : in STD_LOGIC;
		Input : in STD_LOGIC;
		Output : out STD_LOGIC);
	end component;
	for all: sync_lib use entity work.sync_lib(sync_arch);

	signal Enable : std_logic := '0';	 
	signal KDivRegister : std_logic_vector(31 downto 0);	 
	signal TC : std_logic;
	signal Counter : natural;	
	signal ClrStrobeKg : std_logic;	
	signal StartKs : std_logic;
	
	signal FeedForward : std_logic;
	

begin
	
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 
			Enable <= '0';	
			KDivRegister <= CONV_STD_LOGIC_VECTOR(22, 32);
		elsif rising_edge(CLK_CPU) then
			if WR = '0' then	
				case Address is
					when '0' =>
						KDivRegister <= Data;
					when '1' => 
						Enable <= Data(0); 	
					when others =>
						null;
				end case;
			end if;	
		end if;
	end process;	
		
	
	process(CLK1350, RST)	 
	begin	  
		if RST = '0' then
			Counter <= 0;	 
			TC <= '0';		   
		elsif rising_edge(CLK1350) then	  
			if Enable = '1' then
				if Counter < CONV_INTEGER(KDivRegister(30 downto 0)) then
				   Counter <= Counter + 1;
				   TC <= '0';
				else
				   Counter <= 0;				
				   TC <= '1'; 
				end if;	
			else	
				Counter <= 0;  
				TC <= '0';
			end if;
		end if;	
	
	end process; 	
	
	mFeedForwardOut: sync_lib
	port map(
		CLK => CLK,
		RST => RST,
		Clear => '0',
		Input => TC,
		Output => FeedForward
	);	
	
	FeedForwOut	<= FeedForward;	 

	mOut : delay_lib
	generic map(
		DelayValue => 2800  --ForwardDelay 70 us
	)
	port map(
		CLK => CLK,
		RST => RST,
		Start => TC,
		DelayedStart => StartKs
	);	
	
	CLK_OUT <= StartKs;
	
	out_strobe : singleimpulse
	port map(
		clk => CLK,
		rst => RST,
		polarity => '1',
		length => CONV_STD_LOGIC_VECTOR(1200, 16),  --30 us delay
		start => StartKs,
		outedge => ClrStrobeKg 
	);	

	process(StartKs, RST, ClrStrobeKg)
	begin		
		if RST = '0' or ClrStrobeKg = '1' then		
			StrobeKg  <= '0';	
		elsif  rising_edge(StartKs) then 
			StrobeKg  <= '1';	   
		end	if;									 
	end process;		
	
end	 KS_arch;