library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mux32 is
	port	(a:		in  std_logic_vector(0 to 31);
			b:		in  std_logic_vector(0 to 31);
			sinal:	in  std_logic;
			g:		out std_logic_vector(0 to 31));
end mux32;

architecture m of mux32 is
begin
	process(sinal, a, b)
	begin
		if (sinal = '0') then --se o sinal for 0 passa o A
			g <= a;
		else 
			g <= b;  --se o sinal for 1 passa o B
		end if;
	end process;
end;