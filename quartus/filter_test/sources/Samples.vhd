library IEEE;
use IEEE.STD_LOGIC_1164.all;	 
use	IEEE.std_logic_arith.all;	
use	IEEE.STD_LOGIC_SIGNED.all;	


entity Samples is
	 port(
 

		 CLK : in std_logic; 
		 CLK_CPU : in std_logic;  		 
		 RST : in std_logic; 	  
		 
		 RD : in std_logic; 	 		 		
		 RdAddress : in std_logic_vector(8 downto 0);
		 RData : out std_logic_vector(11 downto 0);	  

		 
		 Start : in std_logic;  	
		 Kick : in std_logic;	
		 ADC : in std_logic_vector(11 downto 0); 		
		 Done : out std_logic	
		 
	     );
end Samples;

--}} End of automatically maintained section

architecture Samples_arch of Samples is	   	
	type mem is array (511 downto 0) of std_logic_vector(11 downto 0);	  	   
	subtype	NATURAL9 is natural	range 0 to 511;

	signal ADC_lachted : std_logic_vector(11 downto 0);
	signal RAM : mem;
	constant MaxAddress : NATURAL9 := 472; 
	
	signal Enable : std_logic;
	signal WrAddress : NATURAL9;	 
	signal WrRam : std_logic;
	
	signal StartFlag : std_logic;  
	signal ClrStart : std_logic;
	

	signal KickFlag : std_logic;
	signal ClrKick : std_logic;	
	

	
	
	
	
	
begin

--	process(CLK, RST) 			
--	begin
--		if RST = '0' then
--			ADC_lachted <= (others => '0');		
--		elsif falling_edge(CLK) then
--			ADC_lachted <= ADC;		
--		end if;	
--	end process;


	
	--Start--
	
	process(Start, RST, ClrStart)
	begin 
		if RST = '0' or ClrStart = '1' then 	 
			StartFlag <= '0';				
		elsif rising_edge(Start) then  
			if KickFlag = '1' then
				StartFlag <= '1';  	   							
			end	if;
		end if;
	end process;	   
	----		
	
	--Kick--	
	process(Kick, RST, ClrKick)
	begin 
		if RST = '0' or ClrKick = '1' then 
			KickFlag <= '0';		
		elsif rising_edge(Kick) then  
			KickFlag <= '1';		
		end if;
	end process;	
	----	
	
	--Done--	
	process(ClrKick, RST, Kick)
	begin 
		if RST = '0' or Kick = '1' then 
			Done <= '0';		
		elsif rising_edge(ClrKick) then  
			Done <= '1';		
		end if;
	end process;	
	----		 		

	process(CLK, RST)	
		variable FirstAddressIndicator : bit;
	begin 
		if RST = '0' then 	  
			FirstAddressIndicator := '0';
			WrAddress <= 0;		
			ClrStart <= '0';   
			ClrKick <= '0';
		elsif rising_edge(CLK) then
			if StartFlag = '1' then	  
				if FirstAddressIndicator = '0' then    
					FirstAddressIndicator := '1';					
					WrAddress <= 0;					
				else	
					if WrAddress < MaxAddress then 
						WrAddress <= WrAddress + 1;
						ClrStart <= '0';
					else	
						WrAddress <= 0;	  
						ClrStart <= '1';	 
						ClrKick <= '1';	
					end	if;			   
				end if;				
			else	 	
				FirstAddressIndicator := '0';
				ClrKick <= '0';	 
				ClrStart <= '0'; 
				
			end if;					
		end if;
	end process;		
	
	
	WrRam <= StartFlag;
	
	process(CLK, RST)
	begin 
		if RST = '0' then
			null;
		elsif rising_edge(CLK) then		 		
			if WrRam = '1' then
				RAM(WrAddress) <= ADC;	
			end	if;
		end if;
	end process;	
	
	
	
	
				
	process(CLK_CPU, RST)
	begin 
		if RST = '0' then 
			null;
		elsif rising_edge(CLK_CPU) then	
			if RD = '0' then
				RData <= RAM(CONV_INTEGER(RdAddress));
			end if;	
		end if;
	end process;				   


end Samples_arch;
