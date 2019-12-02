library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mux5 is
	port	(a:		in  std_logic_vector(0 to 4);
			b:		in  std_logic_vector(0 to 4);
			sinal:	in  std_logic;
			g:		out std_logic_vector(0 to 4));
end mux5;

architecture m of mux5 is
begin
	process(sinal, a, b)
	begin
		if (sinal = '0') then -- se sinal for 0 A passa, senao B
			g <= a;
		else 
			g <= b;
		end if;
	end process;
end;