library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity instruct_mem is
	port (address: in std_logic_vector(0 to 31);
			instrucao: out std_logic_vector(0 to 31) := "00000000000000000000000000000000");
end instruct_mem;

architecture programa of instruct_mem is
	type mem_type is array(0 to 200) of std_logic_vector(0 to 7);
	signal memory: mem_type;
begin
	memory(0) <= "00001100"; 
    memory(1) <= "00000001"; 
    memory(2) <= "00000000"; 
    memory(3) <= "00000011"; --addi $r1, $r0, 3

    memory(4) <= "00001100"; 
    memory(5) <= "00000100"; 
    memory(6) <= "00000000"; 
    memory(7) <= "00001111"; --addi $r4, $r0, 15

    memory(8) <= "00000000"; 
    memory(9) <= "00000000"; 
    memory(10) <= "00000000"; 
    memory(11) <= "00000000";-- nop
    --
    memory(12) <= "00000000"; 
    memory(13) <= "00000000"; 
    memory(14) <= "00000000"; 
    memory(15) <= "00000000";-- nop
    --
    memory(16) <= "00000000"; 
    memory(17) <= "00000000"; 
    memory(18) <= "00000000"; 
    memory(19) <= "00000000";-- nop
    --
    ----loop: --10100 --0011100
    memory(20) <= "00010000"; 
    memory(21) <= "00100001"; 
    memory(22) <= "00000000"; 
    memory(23) <= "00000001"; --subi $r1,$r1,1
    --
	memory(24) <= "00000000"; 
    memory(25) <= "00000000"; 
    memory(26) <= "00000000"; 
    memory(27) <= "00000000";-- nop
    --     
    memory(28) <= "00000000"; 
    memory(29) <= "00000000"; 
    memory(30) <= "00000000"; 
    memory(31) <= "00000000";-- nop
    --     
    memory(32) <= "00000000"; 
    memory(33) <= "00000000"; 
    memory(34) <= "00000000"; 
    memory(35) <= "00000000"; -- nop
	       
    memory(36) <= "00101100"; 
    memory(37) <= "01100001"; 
    memory(38) <= "00000000"; 
    memory(39) <= "00001000"; -- beq $r1,$r3,end_loop
    --     
    memory(40) <= "00000000"; 
    memory(41) <= "00000000"; 
    memory(42) <= "00000000"; 
    memory(43) <= "00000000";-- nop
    --     
    memory(44) <= "00000000"; 
    memory(45) <= "00000000"; 
    memory(46) <= "00000000"; 
    memory(47) <= "00000000";-- nop
    --     
    memory(48) <= "00000000"; 
    memory(49) <= "00000000"; 
    memory(50) <= "00000000"; 
    memory(51) <= "00000000"; -- nop
           
    memory(52) <= "00110000"; 
    memory(53) <= "00000000"; 
    memory(54) <= "00000000"; 
    memory(55) <= "00000101"; -- j loop
	        
	memory(56) <= "00000000"; 
    memory(57) <= "00000000"; 
    memory(58) <= "00000000"; 
    memory(59) <= "00000000";-- nop
    --     
    memory(60) <= "00000000"; 
    memory(61) <= "00000000"; 
    memory(62) <= "00000000"; 
    memory(63) <= "00000000";-- nop
    --
    memory(64) <= "00000000"; 
    memory(65) <= "00000000"; 
    memory(66) <= "00000000"; 
    memory(67) <= "00000000"; -- nop
    ----end loop: 11100
	 
    memory(68) <= "00011000"; 
    memory(69) <= "00000100"; 
    memory(70) <= "00000000"; 
    memory(71) <= "00000100"; -- sw $r4,4($r0)
	

	--instruction <= memory(to_integer(unsigned(address)));
	--process (address)
	--begin
		instrucao <= memory(to_integer(unsigned(address))) & memory(to_integer(unsigned(address)) + 1) & memory(to_integer(unsigned(address)) + 2) & memory(to_integer(unsigned(address)) + 3);
	--end process;
	end;