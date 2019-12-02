library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity CPU is
	port(clock:in std_logic;
			deb_current_pc:	out std_logic_vector(0 to 31);
			deb_current_instr: out std_logic_vector(0 to 31);
			deb_reg1:	out std_logic_vector(0 to 31);
			deb_reg2:	out std_logic_vector(0 to 31);
			deb_reg3:	out std_logic_vector(0 to 31);
			deb_reg4:	out std_logic_vector(0 to 31);
			deb_reg5:	out std_logic_vector(0 to 31);
			deb_mem_0:				out std_logic_vector(0 to 31);
			deb_mem_4:				out std_logic_vector(0 to 31);
			deb_mem_8:				out std_logic_vector(0 to 31);
			deb_mem_12:				out std_logic_vector(0 to 31);
			deb_mem_16:				out std_logic_vector(0 to 31);
			deb_opcode: out std_logic_vector(0 to 5) := "000000";
			deb_wb:		out std_logic_vector(0 to 1) := "00";
			deb_mem:		out std_logic_vector(0 to 2) := "000";
			deb_ex:		out std_logic_vector(0 to 3) := "0000"; 
			deb_instrucao: out std_logic_vector(0 to 31); 
			deb_inputifid: out std_logic_vector(0 to 31)); 
end CPU;

architecture a of CPU is
	component instruct_mem
		port (address: in std_logic_vector(0 to 31);
				instrucao: out std_logic_vector(0 to 31));
	end component;
	
	component banco --banco de registradores
		port	(
			   clock: in std_logic;
			   regwrite: in std_logic;
				readrg1:	in  std_logic_vector(0 to 4);
				readrg2:	in  std_logic_vector(0 to 4);
				writerg:	in  std_logic_vector(0 to 4);
				writedata:			in  std_logic_vector(0 to 31);
				read1out: 		out std_logic_vector(0 to 31);
				read2out: 		out std_logic_vector(0 to 31);
			   deb_reg0:		out std_logic_vector(0 to 31);
			   deb_reg1:		out std_logic_vector(0 to 31);
			   deb_reg2:		out std_logic_vector(0 to 31);
				deb_reg3:		out std_logic_vector(0 to 31);
				deb_reg4:		out std_logic_vector(0 to 31);
				deb_reg5:		out std_logic_vector(0 to 31));

	end component;
	
	component data_memory
		port	(address:	in  std_logic_vector(0 to 31);
				clock:		in  std_logic;
				mem_write:	in  std_logic;
				write_data:	in  std_logic_vector(0 to 31);
				mem_read:	in  std_logic;
				read_data:	out std_logic_vector(0 to 31);
				deb_mem_0:	out std_logic_vector(0 to 31);
				deb_mem_4:	out std_logic_vector(0 to 31);
				deb_mem_8:	out std_logic_vector(0 to 31);
				deb_mem_12:	out std_logic_vector(0 to 31);
				deb_mem_16:	out std_logic_vector(0 to 31));
	end component;
	
	component somador
		port	(som1:	in  std_logic_vector(0 to 31);
				som2:		in  std_logic_vector(0 to 31);
				result:		out std_logic_vector(0 to 31));
	end component;
	
	component mux32  is
		port	(a:	in  std_logic_vector(0 to 31);
				b:		in  std_logic_vector(0 to 31);
				sinal:	in  std_logic;
				g:		out std_logic_vector(0 to 31));
	end component;
	
	component mux5 is
		port	(a:	in  std_logic_vector(0 to 4);
				b:		in  std_logic_vector(0 to 4);
				sinal:	in  std_logic;
				g:		out std_logic_vector(0 to 4));
	end component;
	
	component pc is
		port	(clock:	in  std_logic;
				pc_in:	in  std_logic_vector(0 to 31);
				pc_out:		out std_logic_vector(0 to 31));
	end component;
	
	component sign_extend is
		port	(a:	in  std_logic_vector(0 to 15);
				 b:	out std_logic_vector(0 to 31));
	end component;

	component shift_left_2 is
		port	(sl_in: 	in  std_logic_vector(0 to 31);
				 sl_out:	out std_logic_vector(0 to 31));
	end component;
	
	component ula is
		port (A: 	in  std_logic_vector(0 to 31);
				B: 	in  std_logic_vector(0 to 31);
				aluop:		in  std_logic_vector(0 to  1);
				SAIDA: out std_logic_vector(0 to 31);
				zero: 	out std_logic);
	end component;
	
	--========== REGISTRADORES DE PIPELINE ==========
	component IFID is
		port (clock:	in		std_logic;
	
			input: in std_logic_vector(0 to 31);
			pcin: in std_logic_vector(0 to 31);
			
			output: out STD_LOGIC_VECTOR(0 TO 31);
			pcout: out std_logic_vector(0 to 31));
	end component;
	
	component IDEX is
		port (clock:	in		std_logic;
	
			WBin: in std_logic_vector(0 to 1);
			MEin: in std_logic_vector(0 to 2);
			EXin: in std_logic_vector(0 to 3);
			
			pcin: in std_logic_vector(0 to 31);
			
			Read1in: in std_logic_vector(0 to 31);
			Read2in: in std_logic_vector(0 to 31);
			
			
			Imedin: in std_logic_vector(0 to 31); 
			Rtin: in std_logic_vector(0 to 4); 
			Rdin: in std_logic_vector(0 to 4); 
			
				-- Saida
				
			WBout: out std_logic_vector(0 to 1);
			MEout: out std_logic_vector(0 to 2);
			EXout: out std_logic_vector(0 to 3);
			
			
			pcout: out std_logic_vector(0 to 31);
			
			Read1out: out STD_LOGIC_VECTOR(0 TO 31);
			Read2out: out STD_LOGIC_VECTOR(0 TO 31);
			
			
			Imedout: out std_logic_vector(0 to 31); 
			Rtout: out std_logic_vector(0 to 4); 
			Rdout: out std_logic_vector(0 to 4));
	end component;
	
	component EXMEM is
		port (clock:	in		std_logic;
	
			WBin: in std_logic_vector(0 to 1);
			MEin: in std_logic_vector(0 to 2);
			
			pcin: in std_logic_vector(0 to 31);
			Zeroin: in std_logic;
			Resultin: in std_logic_vector(0 to 31);
			Wrin: in std_logic_vector(0 to 31);
			Regdstin: in std_logic_vector(0 to 4); 
			
				-- Saida
				
			WBout: out std_logic_vector(0 to 1);
			MEout: out std_logic_vector(0 to 2);
			
			pcout: out std_logic_vector(0 to 31);
			Zeroout: out STD_LOGIC;
			Resultout: out STD_LOGIC_VECTOR(0 TO 31);
			Wrout: out std_logic_vector(0 to 31);
			Regdstout: out std_logic_vector(0 to 4)); 
			
	end component;

	component MEMWB is
		port (clock:	in		std_logic;
	
			WBin: in std_logic_vector(0 to 1);
			
			readin: in std_logic_vector(0 to 31);
			Resultin: in std_logic_vector(0 to 31);
			Regdstin: in std_logic_vector(0 to 4); 
			
				-- Saida
				
			WBout: out std_logic_vector(0 to 1);
			
			readout: out std_logic_vector(0 to 31);
			Resultout: out STD_LOGIC_VECTOR(0 TO 31);
			Regdstout: out std_logic_vector(0 to 4)); 
	end component;
	
	component UC is
		port (opcode:	in  std_logic_vector(0 to 5);
			pcsrc:	out std_logic := '0';
			jmptp:	out std_logic := '0';
			wb:		out std_logic_vector(0 to 1) := "00";
			mem:		out std_logic_vector(0 to 2) := "000";
			ex:		out std_logic_vector(0 to 3) := "0000");  
	end component;
	
	--signal clock:				std_logic;
	signal deb_reg0: std_logic_vector(0 to 31);
--	signal deb_reg1: std_logic_vector(0 to 31);
--	signal deb_reg2: std_logic_vector(0 to 31);
--	signal deb_reg3: std_logic_vector(0 to 31);
--	signal deb_reg4: std_logic_vector(0 to 31);
--	signal deb_reg5: std_logic_vector(0 to 31);
	--========== SINAIS instrucao FETCH ==========
	signal pc_instr_mem:			std_logic_vector(0 to 31);
	signal  inputin_ifid:		std_logic_vector(0 to 31);

	signal PCSrc:					std_logic;
	signal  pcin_ifid:		std_logic_vector(0 to 31);
	signal pcout_exmem:		std_logic_vector(0 to 31);
	
	signal pc_inate:				std_logic_vector(0 to 31);
	
	--========== SINAIS instrucao DECODE ==========
	signal  pc_idex:	std_logic_vector(0 to 31);
	
	signal RegWrite:				std_logic;
	signal instrucao:			std_logic_vector(0 to 31);
	signal OPCode:					std_logic_vector(0 to 5);
	signal readrg1:		std_logic_vector(0 to 4);
	signal readrg2:		std_logic_vector(0 to 4);
	signal writerg:		std_logic_vector(0 to 4);
	signal writedata:			std_logic_vector(0 to 31);
	signal  Read1in_idex:			std_logic_vector(0 to 31);
	signal  Read2in_idex:			std_logic_vector(0 to 31);
	
	signal Imediato:				std_logic_vector(0 to 15);
	signal  Imedin_idex:		std_logic_vector(0 to 31);
	
	signal  Rtin_idex:					std_logic_vector(0 to 4);
	signal  Rdin_idex:					std_logic_vector(0 to 4);
	
	--signal Jump_imed_ID:			std_logic_vector(0 to 26);
	signal Jump_imed_x_quatro:	std_logic_vector(0 to 31);
	signal Jump_concat:			std_logic_vector(0 to 31);
	signal JumpType:				std_logic;
	signal pcselect_mux_0:		std_logic_vector(0 to 31);
	signal pcselect_mux_1:		std_logic_vector(0 to 31);
	signal IsBranch:				std_logic;
	
	signal Wbin_idex:			std_logic_vector(0 to 1);
	signal Mein_idex:			std_logic_vector(0 to 2);
	signal Exin_idex:			std_logic_vector(0 to 3);
	
	--========== SINAIS EXECUTE ==========
	signal  Imedout_idex:		std_logic_vector(0 to 31);
	signal pcout_idex:	std_logic_vector(0 to 31);
	signal imed_ext_x_quatro:	std_logic_vector(0 to 31);
	signal pcin_exmem:			std_logic_vector(0 to 31);
	
	signal Read2out_idex:				std_logic_vector(0 to 31);
	signal ULA_Src_B:				std_logic_vector(0 to 31);
	signal resultin_exmem:			std_logic_vector(0 to 31);
	signal zeroin_exmem:				std_logic;
	
	signal ALUSrc:					std_logic;
	signal Read1out_idex:			std_logic_vector(0 to 31);
	signal alusrc_mux_1:			std_logic_vector(0 to 31);
	signal ULA_Op:					std_logic_vector(0 to 1);
	
	--signal ULA_Control_Op:		std_logic_vector(0 to 1);
	signal RegDst:					std_logic;
	signal  Rtout_idex:			std_logic_vector(0 to 4);
	signal  Rdout_idex:			std_logic_vector(0 to 4);
	signal rgdstin_exmem:		std_logic_vector(0 to 4);
	
	signal Wbout_idex:			std_logic_vector(0 to 1);
	signal  Meout_idex:			std_logic_vector(0 to 2);
	signal  Exout_idex:			std_logic_vector(0 to 3);
	
	--========== SINAIS MEMORY ==========
	signal resultout_exmem:			std_logic_vector(0 to 31);
	signal memWrite:				std_logic;
	signal wrdataout_exmem:		std_logic_vector(0 to 31);
	signal memRead:				std_logic;
	signal RdDatain_memwb:			std_logic_vector(0 to 31);
	
	signal branch_and_0:			std_logic;
	signal zeroout_exmem:			std_logic;
	
	signal rgdstout_exmem:			std_logic_vector(0 to 4);
	
	signal Wbout_exmem:			std_logic_vector(0 to 1);
	signal Meout_exmem:			std_logic_vector(0 to 2);
	
	--========== SINAIS WRITEBACK ==========
	signal Addrout_memwb:		std_logic_vector(0 to 31);
	signal RdDataout_memwb:		std_logic_vector(0 to 31);
	signal memToReg:				std_logic;
	
	signal Wbout_memwb:			std_logic_vector(0 to 1);
	
begin 
	--========== PASSAGEM DE SINAIS PARA DEBUG ==========
	deb_current_pc <= pc_instr_mem;
	deb_current_instr <=  inputin_ifid;

	
	--========== COMPONENTES instrucao FETCH ==========
	instruction_memory:	instruct_mem			port map (pc_instr_mem,  inputin_ifid);
	add_pc_mais_quatro:	somador					port map (pc_instr_mem, "00000000000000000000000000000100",  pcin_ifid);
	isbranch_mux:			mux32 				port map ( pcin_ifid, pcout_exmem, IsBranch, pcselect_mux_0);
	ProgramCounter:						pc	port map (clock, pc_inate, pc_instr_mem);

	--========== REGISTRADOR IF/ID ==========
	ifid2:	IFID	port map (clock, 
												--entradas
												 inputin_ifid,pcin_ifid,
												--saidas
												 instrucao,pc_idex);
	
	--========== COMPONENTES instrucao DECODE ==========
	deb_instrucao <= instrucao;
	deb_inputifid <= inputin_ifid;
	
	OPCode				<= inputin_ifid( 0 to  5);
	--Jump_imed_ID		<= instrucao( 6 to 31);
	readrg1	<= inputin_ifid( 6 to 10);
	readrg2	<= inputin_ifid(11 to 15);
	Imediato				<= inputin_ifid(16 to 31);
	 Rtin_idex					<= inputin_ifid(11 to 15);
	 Rdin_idex					<= inputin_ifid(16 to 20);
	
	registers:			banco	port map (clock,RegWrite, readrg1, readrg2, writerg, writedata,  Read1in_idex,  Read2in_idex,
																deb_reg0,  deb_reg1,  deb_reg2,  deb_reg3,  deb_reg4,  deb_reg5); 
--																
	dec_sign_extend:	sign_extend		port map (Imediato,  Imedin_idex);
	jumptype_mux:		mux32 			port map (Jump_concat,  Read1in_idex, JumpType, pcselect_mux_1);
	pcsrc_mux:			mux32 			port map (pcselect_mux_0, pcselect_mux_1, PCSrc, pc_inate);
	shift_jump:			shift_left_2	port map (inputin_ifid, Jump_imed_x_quatro);
	Jump_concat <=  pc_idex(0 to 3) & Jump_imed_x_quatro(4 to 31);
	
	ctrl:					UC		port map (OPCode, PCSrc, JumpType, Wbin_idex, Mein_idex,Exin_idex);
	
	deb_opcode <=OPCode;
	deb_wb <= Wbin_idex;	--pega
	deb_mem <= Mein_idex;
	deb_ex <= Exin_idex;  
	
	--========== REGISTRADOR ID/EX ==========
	idex2:	IDEX	port map ( clock, 
										--entradas
										
										Wbin_idex,Mein_idex,Exin_idex,
										pc_idex,Read1in_idex,Read2in_idex,
										Imedin_idex,Rtin_idex,Rdin_idex,
										--saidas
										
										Wbout_idex,Meout_idex,Exout_idex,
										pcout_idex,Read1out_idex,Read2out_idex,
										Imedout_idex,Rtout_idex,Rdout_idex);
	
	
	--========== COMPONENTES EXECUTE ==========
	calcula_branch:	somador				port map ( pcout_idex, imed_ext_x_quatro, pcin_exmem);
	ula_main:			ula				port map ( Read1out_idex, ULA_Src_B, ULA_Op, resultin_exmem, zeroin_exmem); --Removed ULA_Control_Op
	alusrc_mux:			mux32 			port map ( Read2out_idex, alusrc_mux_1, ALUSrc, ULA_Src_B);
	regdst_mux:			mux5			port map ( Rtout_idex,  Rdout_idex, RegDst, rgdstin_exmem);
	shift_exec:			shift_left_2	port map ( Imedout_idex, imed_ext_x_quatro);
	
	alusrc_mux_1 <=  Imedout_idex;
	
	process( Exout_idex)
	begin
		ALUSrc <=  Exout_idex(0);
		ULA_Op <=  Exout_idex(1 to 2);
		RegDst <=  Exout_idex(3);
	end process;

	--========== REGISTRADOR EX/MEM ==========
	exme:	EXMEM	port map (clock, 
								--entradas
									Wbout_idex,  Meout_idex,
									pcin_exmem,zeroin_exmem,
									resultin_exmem,Read2out_idex,	
									rgdstin_exmem,
												--saidas
									Wbout_exmem,Meout_exmem,
									pcout_exmem,zeroout_exmem,
									resultout_exmem,wrdataout_exmem,
									rgdstout_exmem);
	
	--========== COMPONENTES MEMORY ==========
	data_memory2:	data_memory	port map (resultout_exmem, clock, memWrite, wrdataout_exmem, memRead, RdDatain_memwb,deb_mem_0,
	deb_mem_4, deb_mem_8, deb_mem_12, deb_mem_16);
	
	memWrite <= Meout_exmem(0);
	memRead <= Meout_exmem(1);
	branch_and_0 <= Meout_exmem(2);
	IsBranch <= branch_and_0 and zeroout_exmem;

	--========== REGISTRADOR MEM/WB ==========
	mewb:	MEMWB	port map (clock, 
												
									--entradas
												Wbout_exmem, 
												RdDatain_memwb, 
												resultout_exmem, 
												rgdstout_exmem, 
									--saidas
												Wbout_memwb,
												RdDataout_memwb,	
												Addrout_memwb,			
												writerg);
	
	--========== COMPONENTES WRITEBACK ==========
	memtoreg_mux:	mux32 	port map	(Addrout_memwb, RdDataout_memwb, MemToReg, writedata);
	
	MemToReg <= Wbout_memwb(0);
	RegWrite <= Wbout_memwb(1);
end;