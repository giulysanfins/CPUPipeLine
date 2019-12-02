library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity somador is
	port	(som1:	in  std_logic_vector(0 to 31);
			som2:	in  std_logic_vector(0 to 31);
			result:	out std_logic_vector(0 to 31));
end somador;

architecture add of somador is
begin
	result <= som1 + som2; --soma som1 e som2 e salva em result
end;