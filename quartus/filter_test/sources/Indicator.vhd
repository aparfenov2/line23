
library IEEE;
use IEEE.STD_LOGIC_1164.all;	 


entity Indicator is
	 port( 
	 	 CLK_CPU : in STD_LOGIC; 
	 	 RST : in STD_LOGIC;	
		 WR : in STD_LOGIC;
		 Data : in std_logic_vector(31 downto 0);  	
		 
		 IdBlank : in std_logic;
		 
		 Ind : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end Indicator;

--}} End of automatically maintained section	 



architecture Indicator_arch of Indicator is	 	  
 
signal IndRegister : std_logic_vector(6 downto 0);		  

begin
	
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 	  
			IndRegister <= (others => '0');
		elsif rising_edge(CLK_CPU) then
			if WR = '0' then
				IndRegister <= Data(6 downto 0);
			end if;	
		end if;
	end process;		
	
Ind(6 downto 0) <= IndRegister;	
Ind(7) <= not IdBlank;
	
end	Indicator_arch;