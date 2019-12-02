library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ula is 
	port (A: in std_logic_vector(0 to 31);
			B: in std_logic_vector(0 to 31);
			aluop:	in std_logic_vector(0 to  1);
			SAIDA: out std_logic_vector(0 to 31);
			zero: out std_logic);
end ula;

architecture alu of ula is 
	signal res: std_logic_vector(0 to 31);
begin
	process(A, B, aluop)
	begin
		case aluop is
			when "00" => res <= A + B;
			when "01" => res <= A - B;
			when "10" => res <= A and B;
			when "11" => res <= A or B;
			when others => res <= "00000000000000000000000000000000";
		end case;
		
		if(res = "00000000000000000000000000000000") then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
		SAIDA <= res;
	end process;
end alu;