Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY IFID is
	PORT(	clock: in STD_LOGIC;
	
			input: in std_logic_vector(0 to 31);
			pcin: in std_logic_vector(0 to 31);
			
			output: out STD_LOGIC_VECTOR(0 TO 31);
			pcout: out std_logic_vector(0 to 31));
	
	END IFID;
	
	ARCHITECTURE behavior OF IFID IS
	BEGIN 
		PROCESS(clock)
		BEGIN 
				if (clock'EVENT AND clock = '1') THEN  --sensivel a descida
				
						output <= input;
						pcout <= pcin;
				END if;
						
		END PROCESS;
	END;	