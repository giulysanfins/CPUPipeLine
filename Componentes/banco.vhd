LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY banco is
	PORT(	clock: in STD_LOGIC;
			regwrite: in STD_LOGIC;
			
			readrg1: in std_logic_vector(0 to 4);
			readrg2: in std_logic_vector(0 to 4);
			writerg: in std_logic_vector(0 to 4);
			writedata: in std_logic_vector(0 to 31);
			
			read1out: out STD_LOGIC_VECTOR(0 TO 31);
			read2out: out STD_LOGIC_VECTOR(0 TO 31);
	
			deb_reg0:		out std_logic_vector(0 to 31);
			deb_reg1:		out std_logic_vector(0 to 31);
			deb_reg2:		out std_logic_vector(0 to 31);
			deb_reg3:		out std_logic_vector(0 to 31);
			deb_reg4:		out std_logic_vector(0 to 31);
			deb_reg5:		out std_logic_vector(0 to 31));
	END banco;
	
	ARCHITECTURE Behavior OF banco IS
	
	type regclass is array(0 to 31) of STD_LOGIC_VECTOR(0 TO 31);
	signal regread : regclass;
	
	begin 
	--regread(1) <= "00000000000000000000000000001111";
	--regread(2) <= "00000000000000000000000000000111";
	--regread(3) <= "00000000000000000000000000000011";
	--regread(4) <= "00000000000000000000000000001001";
	--regread(5) <= "00000000000000000000000000111111";
	
	deb_reg0  <= regread(0);
	deb_reg1  <= regread(1);
	deb_reg2  <= regread(2);
	deb_reg3  <= regread(3);
	deb_reg4  <= regread(4);
	deb_reg5  <= regread(5);
	
	
	process(clock)
	begin
		if (clock'EVENT AND clock = '1' and regwrite = '1' and not (writerg = "00000" )) THEN  --sensivel a descida

		regread(to_integer(unsigned(writerg))) <= writedata;
		
		end if;

			end process;
			
			read1out <= regread(to_integer(unsigned(readrg1)));
			read2out <= regread(to_integer(unsigned(readrg2)));


END Behavior;
