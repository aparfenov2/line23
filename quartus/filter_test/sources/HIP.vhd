--
-- On CLK = 100 kHz => 256 pairs per 84.27 ms => 3037 pairs per second
--	Compare >= 10, e.g. min dT on 100 kHz => 100 us
--
-- On CLK = 40 MHz, KDiv = 833 (Data = 417 !!!!!) => InternalCLK = 24.009 kHz => 256 pairs per 351.446 ms => 728 pairs per second 
--	Data(31) = 1 - Enable HIP
--			   0 - Disable HIP

library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.STD_LOGIC_unsigned.all;


entity HIP is
	port(		 
		 CLK : in STD_LOGIC;
		 CLK_CPU : in STD_LOGIC;
		 WR : in STD_LOGIC;
		 Data : in std_logic_vector(31 downto 0);
		 RST : in STD_LOGIC;
		 Start : out STD_LOGIC
	     );
end HIP;

--}} End of automatically maintained section

architecture HIP_arch of HIP is	  
constant MinimalCompareValue : std_logic_vector(6 downto 0):= "0001010";	 

signal KDivRegister : std_logic_vector(30 downto 0);	

signal RandomCounter : std_logic_vector(6 downto 0);

signal Counter : std_logic_vector(6 downto 0);			
signal Compare : std_logic_vector(6 downto 0);	
signal TC : std_logic; 

signal InternalClk : std_logic;	   
signal DividerData : std_logic_vector(31 downto 0);	
signal Enable : std_logic;			   

begin 
	
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 
			Enable <= '0';	
			KDivRegister <= (others => '0');
		elsif rising_edge(CLK_CPU) then
			if WR = '0' then	
				KDivRegister <= Data(30 downto 0);
				Enable <= Data(31); 	
			end if;	
		end if;
	end process;	
		
	process(CLK, RST)	
		variable Counter : natural;
	begin	  
		if RST = '0' then
			Counter :=0;	 
			InternalClk <= '0';		   
		elsif rising_edge(CLK) then	  
			if Enable = '1' then
				if Counter < CONV_INTEGER(KDivRegister) then
				   Counter := Counter + 1;
				   InternalClk <= '0';
				else
				   Counter :=0;				
				   InternalClk <= '1'; 
				end if;	
			else	
				Counter :=0;  
				InternalClk <= '0';
			end if;
		end if;	
	
	end process; 	
	
	process(TC, RST) 
	begin
			
		if RST = '0' then
			RandomCounter <= (others => '1');		
		elsif rising_edge(TC)	then 
			RandomCounter(6 downto 1) <= RandomCounter(5 downto 0);
			RandomCounter(0) <= RandomCounter(6) xor RandomCounter(0);
		end if;	
	 end process;	
	
	Compare <= RandomCounter when RandomCounter > MinimalCompareValue else MinimalCompareValue;
	 
	process(InternalClk, RST, Enable) 
	begin
		if RST = '0' or Enable = '0' then
			Counter <= (others => '1');
			TC <= '0';	
		elsif rising_edge(InternalClk)	then 
			if Counter < Compare then
				Counter <= Counter + 1;	
				TC <= '0';
			else
				Counter <= (others => '0');
				TC <= '1';
			end	if;	 
		end if;	
	 end process;
	 
	 Start <= TC;	


end HIP_arch;
