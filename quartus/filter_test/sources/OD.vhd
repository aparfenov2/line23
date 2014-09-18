library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.STD_LOGIC_unsigned.all;	 
use IEEE.STD_LOGIC_arith.all;	
use IEEE.numeric_std.all;		
use IEEE.std_logic_arith.all;

entity OD is 
	port(
		 CLK : in STD_LOGIC;
		 RST : in STD_LOGIC; 
		 -----------------
		 CLK_CPU : in STD_LOGIC;
		 Data : in STD_LOGIC_VECTOR(15 downto 0);  
		 Address : in std_logic_vector(4 downto 0);
		 WR : in STD_LOGIC;	 
 		 ------------------
		 AdcMax : in std_logic_vector(11 downto 0);	
		 DiffImpulses : in std_logic_vector(11 downto 0);
		 Request : in STD_LOGIC;
		 ------------------
		 Reply : out std_logic


	     );
end OD;


architecture OD_arch of OD is 	   

	constant Time12us : std_logic_vector(11 downto 0) := CONV_STD_LOGIC_VECTOR(480, 12);	
	constant Time30us : std_logic_vector(11 downto 0) := CONV_STD_LOGIC_VECTOR(1200, 12);	

	--signal BaseDelayRegister : std_logic_vector(11 downto 0);	
	signal SummaryDelayRegister : std_logic_vector(11 downto 0);	
	signal AdditionalDelayRegister : std_logic_vector(11 downto 0);	
	signal DiffImpulsesRegister : std_logic_vector(11 downto 0);
	signal CodeIntervalRegister : std_logic_vector(11 downto 0);
	
	
	
	signal AdcMaxRegister : std_logic_vector(11 downto 0); 
	signal ControlRegister : std_logic_vector(7 downto 0);
	
	signal DeleyedRequest : std_logic; 
	signal DelayFlag : std_logic; 
	
--	signal DecodingFlag : std_logic;	  	 
	signal Enable : std_logic;		
	signal Mode : std_logic; --X or Y
	
	------------------------for RAM-----------------
	type ram_mem_type is array (3 downto 0) of std_logic_vector(11 downto 0);
	signal AdditionalDelay : ram_mem_type := ( 
										  CONV_STD_LOGIC_VECTOR(0,12),
										  CONV_STD_LOGIC_VECTOR(0,12),
										  CONV_STD_LOGIC_VECTOR(0,12),
										  CONV_STD_LOGIC_VECTOR(0,12)
										  ); 	  

	------------------------------------------------   

	signal EndDecodingFlag : std_logic;	  			 		 
	signal DelayAdress : std_logic_vector(1 downto 0);

begin	  
	
	-------------Set Params By NIOS-------------------
	process(CLK_CPU, RST)
	begin
		if RST = '0' then 	   	 
			ControlRegister <= (others => '0');
		elsif rising_edge(CLK_CPU) then					   
			if WR = '0' then	
				case Address is	   
					when "11110" =>
						ControlRegister <= Data(7 downto 0);
					when others	=> null;						
				end	case;
			end if;	
		end if;
	end process;			
	
	Enable <= ControlRegister(0);	 
	Mode   <= ControlRegister(1);  -- 0 -> X or 1 -> Y
	
	-------------AdcMaxRegisterLevel-s--------------------
	process(CLK_CPU)
	begin
		if rising_edge(CLK_CPU) then					   
			if WR = '0' then	
				if	Address < CONV_STD_LOGIC_VECTOR(8, 5) then 
					null;
				else 
					if Address < CONV_STD_LOGIC_VECTOR(16, 5) then	
						AdditionalDelay(CONV_INTEGER(Address) - 8) <= Data(11 downto 0); 
					end if;	
				end if;	
			end if;	
		end if;
	end process;		
	----------------------------------------------	 	 
	
	-----------AdcMaxRegister---------------------
	process(CLK, RST)
	begin
		if RST = '0' then  
			AdcMaxRegister <= (others => '0');
		elsif rising_edge(CLK) then	 
			if Enable = '1' and Request = '1'  then 
				AdcMaxRegister <= AdcMax;		
			end if;	
		end if;
	end process;	
							
	----------------------------------------------	  
	
	-----------DiffImpulsesRegister---------------
	process(CLK, RST)
	begin
		if RST = '0' then  
			DiffImpulsesRegister <= (others => '0');
		elsif rising_edge(CLK) then	 
			if Enable = '1' and Request = '1' then 
				DiffImpulsesRegister <= DiffImpulses;
			end if;	
		end if;
	end process;	
							
	----------------------------------------------	 

	------------Decode----------------------------	  
	
	DelayAdress <= AdcMaxRegister(11 downto 10);-- when AdcMaxRegister > CONV_STD_LOGIC_VECTOR(12, 1023) else "01";
	
 	process(CLK, RST)  
	begin 
		if rising_edge(CLK) then	
			AdditionalDelayRegister <= AdditionalDelay(CONV_INTEGER(DelayAdress));			
		end if;
	end process;	   	   
		
   	
	----------------------------------------------		 
	
	
	
	CodeIntervalRegister <= Time30us when Mode = '1' else Time12us;
	
	-------------SummaryDelayRegister-------------
	SummaryDelayRegister <= AdditionalDelayRegister - (DiffImpulsesRegister - CodeIntervalRegister) when DiffImpulsesRegister >= CodeIntervalRegister else
							AdditionalDelayRegister + (CodeIntervalRegister - DiffImpulsesRegister);
	
	----------------------------------------------	   
	
	------------------Summary Delay---------------
	process(CLK, RST, DeleyedRequest)
	begin
		if RST = '0' or DeleyedRequest = '1' then
			DelayFlag <= '0';
		elsif rising_edge(CLK)	 then  
			if Enable = '1' and  Request = '1' then 
				DelayFlag <= '1';
			end if;	
		end if;		
	end process;
	
	
	process(CLK, RST)  
		variable Counter : natural;	 
	begin			
		if RST = '0' then
		   Counter := 0;  
		   DeleyedRequest <= '0';
		elsif rising_edge(CLK) then	 
			if DelayFlag = '1' then 				
				if Counter < SummaryDelayRegister then
			   	   Counter := Counter + 1;
				   DeleyedRequest <= '0';	  
				else	  
				   Counter := 0; 
				   DeleyedRequest <= '1';
				end if;
			else	
				Counter := 0;	
				DeleyedRequest <= '0';
			end if;	
		end if;
	end process;	
	
	----------------------------------------------		
	
	-----------Reply------------------------------		
	Reply <= DeleyedRequest;
	----------------------------------------------
	

end OD_arch;	
