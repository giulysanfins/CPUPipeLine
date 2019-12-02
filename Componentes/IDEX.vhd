library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY IDEX is
	PORT(	clock: in STD_LOGIC;
			
	
			WBin: in std_logic_vector(0 to 1);
			MEin: in std_logic_vector(0 to 2);
			EXin: in std_logic_vector(0 to 3);
			
			pcin: in std_logic_vector(0 to 31);
					
			Read1in: in std_logic_vector(0 to 31);
			Read2in: in std_logic_vector(0 to 31);
			
			Imedin: in std_logic_vector(0 to 31); 
			Rtin: in std_logic_vector(0 to 4); 
			Rdin: in std_logic_vector(0 to 4); 
			
				-- Saida
				
			WBout: out std_logic_vector(0 to 1);
			MEout: out std_logic_vector(0 to 2);
			EXout: out std_logic_vector(0 to 3);
			
			pcout: out std_logic_vector(0 to 31);
			
			Read1out: out STD_LOGIC_VECTOR(0 TO 31);
			Read2out: out STD_LOGIC_VECTOR(0 TO 31);
			
			Imedout: out std_logic_vector(0 to 31); 
			Rtout: out std_logic_vector(0 to 4); 
			Rdout: out std_logic_vector(0 to 4));
	
	END IDEX;
	
	ARCHITECTURE Behavior OF IDEX IS
	BEGIN 
		PROCESS(clock)
		BEGIN 
				if (clock'EVENT AND clock = '1') THEN  --sensivel a descida
				
			WBout		<= WBin;
			MEout		<= MEin;
			EXout		<= EXin;
			pcout		<= pcin;
			read1out	<= read1in;
			read2out	<= read2in;
			imedout		<= imedin;
			Rtout		<= Rtin;
			Rdout		<= Rdin;
			
				
				END if;
						
		END PROCESS;
	END;