
library IEEE;
use IEEE.STD_LOGIC_1164.all;	 


entity KontrolGenerator is
	 port( 
	 	 CLK_CPU : in STD_LOGIC; 
	 	 RST : in STD_LOGIC;	
		 WR : in STD_LOGIC;
		 Data : in std_logic_vector(31 downto 0);  	
		 Kg : out STD_LOGIC_VECTOR(6 downto 0);
		 Strobe : out std_logic
	     );
end KontrolGenerator;

--}} End of automatically maintained section	 



architecture KontrolGenerator_arch of KontrolGenerator is	 	  
 
signal KgRegister : std_logic_vector(7 downto 0);		  

begin
	
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 	  
			KgRegister <= (others => '1');
		elsif rising_edge(CLK_CPU) then
			if WR = '0' then
				KgRegister <= Data(7 downto 0);
			end if;	
		end if;
	end process;		
	
Kg <= KgRegister(6 downto 0);
Strobe <= KgRegister(7);	
	
end	 KontrolGenerator_arch;