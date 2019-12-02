library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pc is
	port	(clock:	in  std_logic;
			pc_in:	in  std_logic_vector(0 to 31);
			pc_out:		out std_logic_vector(0 to 31) := "00000000000000000000000000000000");
end pc;

architecture pc_reg of pc is
begin 
	process (clock, pc_in)
	begin
		if (clock'event and clock = '1') then  --se clock na borda de subida então pc_out =pc_in
			pc_out  <= pc_in;
		end if;
	end process;
end;