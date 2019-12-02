library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity data_memory is
	port	(address:	in  std_logic_vector(0 to 31);
			clock:		in std_logic;
			mem_write:	in std_logic;
			write_data:	in  std_logic_vector(0 to 31);
			mem_read:	in 	std_logic;
			read_data:	out std_logic_vector(0 to 31);
			deb_mem_0:	out std_logic_vector(0 to 31);
			deb_mem_4:	out std_logic_vector(0 to 31);
			deb_mem_8:	out std_logic_vector(0 to 31);
			deb_mem_12:	out std_logic_vector(0 to 31);
			deb_mem_16:	out std_logic_vector(0 to 31));
end data_memory;

architecture imem of data_memory is
	type mem_type is array(0 to 100) of std_logic_vector(0 to 7);
	signal memory: mem_type;
begin

	deb_mem_0 <= 
		memory(0) & 
		memory(1) & 
		memory(2) & 
		memory(3);
	
	deb_mem_4 <= 
		memory(4) & 
		memory(5) & 
		memory(6) & 
		memory(7);
	
	deb_mem_8 <= 
		memory(8) & 
		memory(9) & 
		memory(10) & 
		memory(11);
		
	deb_mem_12 <= 
		memory(12) & 
		memory(13) & 
		memory(14) & 
		memory(15);
		
	deb_mem_16 <= 
		memory(16) & 
		memory(17) & 
		memory(18) & 
		memory(19);
		
	process(clock)
	begin
		if (clock'EVENT and clock = '1') then
			if (mem_write = '1') then
				memory(to_integer(unsigned(address))    ) <= write_data(0  to 7 );
				memory(to_integer(unsigned(address)) + 1) <= write_data(8  to 15);
				memory(to_integer(unsigned(address)) + 2) <= write_data(16 to 23);
				memory(to_integer(unsigned(address)) + 3) <= write_data(24 to 31);
			end if;
			if (mem_read = '1') then 
				read_data <= 
					memory(to_integer(unsigned(address))    ) & 
					memory(to_integer(unsigned(address)) + 1) & 
					memory(to_integer(unsigned(address)) + 2) & 
					memory(to_integer(unsigned(address)) + 3);
			else 
				read_data <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
			end if;
		end if;
	end process;
end;