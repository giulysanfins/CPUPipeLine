library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY MEMWB is
	PORT(	clock: in STD_LOGIC;
	
			WBin: in std_logic_vector(0 to 1);
			
			readin: in std_logic_vector(0 to 31);
			Resultin: in std_logic_vector(0 to 31);
			Regdstin: in std_logic_vector(0 to 4); 
			
				-- Saida
				
			WBout: out std_logic_vector(0 to 1);
			
			readout: out std_logic_vector(0 to 31);
			Resultout: out STD_LOGIC_VECTOR(0 TO 31);
			Regdstout: out std_logic_vector(0 to 4)); 
	
	END MEMWB;
	
	ARCHITECTURE Behavior OF MEMWB IS
	BEGIN 
		PROCESS(clock)
		BEGIN 
				if (clock'EVENT AND clock = '1') THEN  --sensivel a descida
				
				WBout		<= WBin;
				readout		<= readin;
				Resultout   <= Resultin;
				Regdstout	<= Regdstin;
				
				
				END if;
						
		END PROCESS;
	END;