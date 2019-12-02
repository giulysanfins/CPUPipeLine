library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY EXMEM is
	PORT(	clock: in STD_LOGIC;
	
			WBin: in std_logic_vector(0 to 1);
			MEin: in std_logic_vector(0 to 2);
			
			pcin: in std_logic_vector(0 to 31);
			Zeroin: in std_logic;
			Resultin: in std_logic_vector(0 to 31);
			Wrin: in std_logic_vector(0 to 31);
			Regdstin: in std_logic_vector(0 to 4); 
			
				-- Saida
				
			WBout: out std_logic_vector(0 to 1);
			MEout: out std_logic_vector(0 to 2);
			
			pcout: out std_logic_vector(0 to 31);
			Zeroout: out STD_LOGIC;
			Resultout: out STD_LOGIC_VECTOR(0 TO 31);
			Wrout: out std_logic_vector(0 to 31);
			Regdstout: out std_logic_vector(0 to 4)); 
	
	END EXMEM;
	
	ARCHITECTURE Behavior OF EXMEM IS
	BEGIN 
		PROCESS(clock)
		BEGIN 
				if (clock'EVENT AND clock = '1') THEN  --sensivel a descida
				
				WBout 		<= WBin;
			MEout 		<= MEin;
			pcout 		<= pcin;
			Zeroout 	<= Zeroin;
			Resultout 	<= Resultin;
			Wrout 	<= Wrin;
			Regdstout 	<= Regdstin;
				
				
				END if;
						
		END PROCESS;
	END;	