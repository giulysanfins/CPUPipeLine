  
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shift_left_2 is
	port	(sl_in: in  std_logic_vector(0 to 31);
			sl_out:	out std_logic_vector(0 to 31));
end shift_left_2;

architecture sl2 of shift_left_2 is
begin
	sl_out <= sl_in(2 to 31) & "00"; -- sl_out = sl_in[2-31] concatenado com 00 
end;