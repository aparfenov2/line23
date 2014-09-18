library IEEE;
use IEEE.STD_LOGIC_1164.all;	
use IEEE.std_logic_unsigned.all;

entity Frequency is
	port(			
		 CLK : in std_logic;
	 	 RST : in std_logic;
		 Input : in STD_LOGIC;	  
		 Kick : in std_logic;
		 Data : out STD_LOGIC_vector(12 downto 0);
		 Done : out std_logic
		 
	     );
end Frequency;



architecture Frequency_arch of Frequency is  

	subtype NATURAL17 is natural range 0 to 131071;
	
	signal ImpulseCounter : std_logic_vector(12 downto 0); 
	signal DelayCounter : NATURAL17;					  
	signal ImpulseCounterDone : std_logic; 						
	signal Result : std_logic_vector(12 downto 0);
	constant MeasurePriod : NATURAL17 := 78124;   
	

	signal KickFlag : std_logic;
	signal ClrKick : std_logic;	  
	
	
	
begin	 				  
			
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
				   
	

CountPeriod: process(CLK,RST)
	begin
		if RST = '0' then  
			DelayCounter <= 0; 		  
			ClrKick <= '0';	
		elsif rising_edge(CLK) then		   
			if KickFlag = '1' then
				if DelayCounter < MeasurePriod then			
					DelayCounter <= DelayCounter + 1;	  
				else
					DelayCounter <= 0;	  
					ClrKick <= '1';	
				end	if;		
			else 
				DelayCounter <= 0; 	   
				ClrKick <= '0';					
			end if;	
		end if;
	end	process;		   
	
	CountImpulses: process(Input, ClrKick, RST)
	begin
		if RST = '0' or ClrKick = '1' then
			ImpulseCounter <= (others => '0'); 
		elsif rising_edge(Input) then	 
			if KickFlag = '1' then
				ImpulseCounter <= ImpulseCounter + 1;	 
			else   
				ImpulseCounter <= (others => '0'); 			
			end if;	
		end if;
	end	process;		 
	
	process(ClrKick, RST)
	begin
		if RST = '0' then
			Result <= (others => '0'); 
		elsif rising_edge(ClrKick) then	
			Result <= ImpulseCounter;	  
		end if;
	end	process;	
			
	Done <= not (KickFlag and ClrKick);
	Data <= Result;

end Frequency_arch;



