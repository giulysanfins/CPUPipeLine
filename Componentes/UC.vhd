library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity UC is
	port (opcode:	in  std_logic_vector(0 to 5);
			pcsrc:	out std_logic := '0';
			jmptp:	out std_logic := '0';
			wb:		out std_logic_vector(0 to 1) := "00";
			mem:		out std_logic_vector(0 to 2) := "000";
			ex:		out std_logic_vector(0 to 3) := "0000");  
			
			
			--1)posicoes do EX
			--primeira: AluSRC 
			--segunda/terceira: Codigo ALUOUT 
			--quarta:REGDST
			
			--2)posicoes da MEM
			--primeira:MemWrite 
			--segunda: MemRead
			--terceira:Branch
			
			--3)posicoes do WB
			--primeira: MemtoReg
			--segunda: RegWrite
end UC;

architecture ctrl of UC is
begin
	process(opcode)
	begin
		case opcode is
			when "000000" => -- NOP
				pcsrc			<= '0';
				ex				<= "XXXX";
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				
				wb				<= "X0";
				--primeira:N IMPORTA RESULTADO DA ULA OU DO REG
			   --segunda:  N deixa habilitado regwrite
				
			when "000001" => -- ADD
				pcsrc			<= '0';
				ex 			<=	"0001"; 
				--primeira pos:alusrc=0 (le o dado)
			   --segunda e terceira:operacao de ADD 
			   --quarta:pega rd

				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb <= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
				
			when "000010" => -- SUB
				pcsrc			<= '0';
				ex 			<= "0011";
				--primeira pos:alusrc=0 (le o dado)
			   --segunda e terceira:operacao de SUB 
			   --quarta:pega rd
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "000011" => -- ADDI
				pcsrc			<= '0';
				ex				<= "1000";
				--primeira pos:alusrc=1 (PEGA DO IMEDIATO)
			   --segunda e terceira:operacao de ADD 
			   --quarta:pega rT
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "000100" => -- SUBI
				pcsrc			<= '0';
				ex				<= "1010";
				--primeira pos:alusrc=1 (PEGA DO IMEDIATO)
			   --segunda e terceira:operacao de SUB 
			   --quarta:pega rT
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "000101" => -- LW
				pcsrc			<= '0';
				ex				<= "1000";
				--primeira pos:alusrc=1 (PEGA DO IMEDIATO)
			   --segunda e terceira:operacao de ADD 
			   --quarta:pega rT
				mem			<= "010";
				--primeira:n libera memWrite
			   --segunda: libera memRead
				--terceira:n usa branch
				wb				<= "11";
				--primeira:pega do read data do registrador
			   --segunda:  deixa habilitado regwrite
			
			when "000110" => -- SW
				pcsrc			<= '0';
				ex				<= "100X";
				--primeira pos:alusrc=1 (PEGA DO IMEDIATO)
			   --segunda e terceira:operacao de ADD 
			   --quarta:N IMPORTA SE EH DE RT OU RD
				mem			<= "1X0";
				--primeira:libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "00";
				--primeira:pega resultado da ula
			   --segunda: NAO deixa habilitado regwrite
				
			when "000111" => -- AND
				pcsrc			<= '0';
				ex				<= "0101";
				--primeira pos:alusrc=0 (le o dado)
			   --segunda e terceira:operacao de AND 
			   --quarta:pega rd
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "001000" => -- OR
				pcsrc			<= '0';
				ex				<= "0111";
				--primeira pos:alusrc=0 (le o dado)
			   --segunda e terceira:operacao de OR 
			   --quarta:pega rd
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "001001" => -- ANDI
				pcsrc			<= '0';
				ex				<= "1100";
				--primeira pos:alusrc=1 (PEGA DO IMEDIATO)
			   --segunda e terceira:operacao de ANDI 
			   --quarta:pega rt
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "001010" => -- ORI
				pcsrc			<= '0';
				ex				<= "1110";
				--primeira pos:alusrc=1 (PEGA DO IMEDIATO)
			   --segunda e terceira:operacao de OR
			   --quarta:pega rt
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:n usa branch
				wb				<= "01";
				--primeira:pega resultado da ula
			   --segunda: deixa habilitado regwrite
				
			when "001011" => -- BEQ
				pcsrc			<= '0';
				ex				<= "001X";
				--primeira pos:alusrc=0 le o dado
			   --segunda e terceira:operacao de SUB 
			   --quarta:N USA ENTAO N IMPORTA
				mem			<= "0X1";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:USA BRANCH
				wb				<= "00";
				--primeira:pega resultado da ula
			   --segunda: NAO deixa habilitado regwrite
				
			when "001100" => -- J
				pcsrc			<= '1';
				jmptp			<= '0';
				ex				<= "XXXX";
				mem			<= "0XX";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:N IMPORTA PQ N USA BRANCH
				wb				<= "00";
				--primeira:pega resultado da ula
			   --segunda: NAO deixa habilitado regwrite
				
			when "001101" => -- JR
				pcsrc			<= '1';
				jmptp			<= '1';
				ex				<= "XXXX";
				mem			<= "0XX";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:N IMPORTA PQ N USA BRANCH
				wb				<= "00";
				--primeira:pega resultado da ula
			   --segunda: NAO deixa habilitado regwrite
			
			when others => 
				pcsrc			<= '0';
				ex				<= "XXXX";
				mem			<= "0X0";
				--primeira:n libera memWrite
			   --segunda: sinal n passa pra frente. entao n importa
				--terceira:conferir se eh branch
				wb				<= "00";
				--primeira:pega resultado da ula
			   --segunda: NAO deixa habilitado regwrite
		end case;
	end process;
end;