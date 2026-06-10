---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;
USE ieee.numeric_std.ALL;
USE work.aux_package.all;


ENTITY  Execute IS
	generic(
		DATA_BUS_WIDTH : integer := 32;
		FUNCT_WIDTH : integer := 6;
		PC_WIDTH : integer := 10
	);
	PORT(	read_data1_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			sign_extend_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			ALUOp_ctrl_i 	: IN 	STD_LOGIC;
			ALUSrc_ctrl_i 	: IN 	STD_LOGIC;
			RegDst_ctrl_i 	: IN 	STD_LOGIC;
			instruction_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			Write_data_i	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			alu_res_MEM_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			ForwardA		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ForwardB		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
			write_reg_addr_o: OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			WriteData_toMEM : OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			alu_res_o 		: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0)
	);
END Execute;


ARCHITECTURE behavior OF Execute IS
SIGNAL a_input_w, b_input_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL shifter_res				: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL alu_out_mux_w			: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL alu_ctl_w				: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Shiftside				: STD_LOGIC;
SIGNAL rt_register_w		: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL shmat_w				: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rd_register_w		: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL funct_w				: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL opc_w				: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL Temp_b_mux_w			: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
BEGIN

	-- ALU input mux
	b_input_w <= 	Temp_b_mux_w WHEN (ALUSrc_ctrl_i = '0') ELSE
					sign_extend_i(DATA_BUS_WIDTH-1 DOWNTO 0);
					
    rt_register_w 			<= instruction_i(20 DOWNTO 16);
   	rd_register_w			<= instruction_i(15 DOWNTO 11);
	funct_w					<= instruction_i(5 DOWNTO 0);
	shmat_w					<= instruction_i(10 DOWNTO 6);
	opc_w					<= instruction_i(DATA_BUS_WIDTH-1 DOWNTO 26);
--------------------------------------------------------------------------------------------------------
--  Generate ALU control bits
--------------------------------------------------------------------------------------------------------

alu_ctl_w <= "0000" when 
						(ALUOp_ctrl_i = '1' and (funct_w = ADD_FUNC or funct_w = ADDU_FUNC)) or 
						(ALUOp_ctrl_i = '0' and 
						   (opc_w = ADDI_OPC or  
							opc_w = ADDIU_OPC or  
							opc_w = LW_OPC or  
							opc_w = SW_OPC)) 
           else "0001" when 
							(ALUOp_ctrl_i = '1' and funct_w = SUB_FUNC) or 
							(ALUOp_ctrl_i = '0' and (opc_w = BEQ_OPC or opc_w = BNE_OPC))
           else "0010" when 
							(ALUOp_ctrl_i = '1' and funct_w = AND_FUNC) or 
							(ALUOp_ctrl_i = '0' and opc_w = ANDI_OPC)
           else "0011" when 
							(ALUOp_ctrl_i = '1' and funct_w = OR_FUNC) or 
							(ALUOp_ctrl_i = '0' and opc_w = ORI_OPC)
           else "0100" when 
							(ALUOp_ctrl_i = '1' and funct_w = XOR_FUNC) or 
							(ALUOp_ctrl_i = '0' and opc_w = XORI_OPC)
           else "0101" when 
							(ALUOp_ctrl_i = '1' and funct_w = SLL_FUNC)
           else "0110" when 
							(ALUOp_ctrl_i = '1' and funct_w = SRL_FUNC)
           else "0111" when 
							(ALUOp_ctrl_i = '1' and funct_w = SLT_FUNC) or 
							(ALUOp_ctrl_i = '0' and opc_w = SLTI_OPC)
           else "1000" when 
							(ALUOp_ctrl_i = '0' and opc_w = MUL_OPC)
		   else "1001" when 
							(ALUOp_ctrl_i = '0' and opc_w = LUI_OPC)
           else "0000";  -- default
					

	-- Mux for Register Write Address
	write_reg_addr_o <= rd_register_w WHEN RegDst_ctrl_i = '1' ELSE 
						rt_register_w;
						
	-- Mux for ForwadingA
	a_input_w <= read_data1_i WHEN ForwardA = "00" ELSE
				Write_data_i WHEN ForwardA = "01" ELSE
				alu_res_MEM_i WHEN ForwardA = "10" ELSE 
				(others => '0');

	-- Mux for ForwadingB
	Temp_b_mux_w <= read_data2_i WHEN ForwardB = "00" ELSE
				Write_data_i WHEN ForwardB = "01" ELSE
				alu_res_MEM_i WHEN ForwardB = "10" ELSE 
				(others => '0');
	WriteData_toMEM <= Temp_b_mux_w;
	  
	
	-- Select ALU output        
	alu_res_o <= 	X"0000000" & B"000"  & alu_out_mux_w(31) WHEN  alu_ctl_w = "111" ELSE 
					alu_out_mux_w(DATA_BUS_WIDTH-1 DOWNTO 0);
						
	
	Shiftside <= '1' WHEN alu_ctl_w = "0101" ELSE
				'0' WHEN alu_ctl_w = "0110" ELSE
				'X';

do_shift:Shifter generic map (DATA_BUS_WIDTH, 5) port map (shmat_w,b_input_w,Shiftside,shifter_res);  

PROCESS (alu_ctl_w, a_input_w, b_input_w, shifter_res)
	BEGIN		
 	CASE alu_ctl_w IS	-- Select ALU operation
		WHEN "0000" 	=>	alu_out_mux_w 	<= a_input_w + b_input_w; 
     	WHEN "0001" 	=>	alu_out_mux_w 	<= a_input_w - b_input_w;
	 	WHEN "0010" 	=>	alu_out_mux_w 	<= a_input_w AND b_input_w;
	 	WHEN "0011" 	=>	alu_out_mux_w 	<= a_input_w OR b_input_w;
	 	WHEN "0100" 	=>	alu_out_mux_w 	<= a_input_w XOR b_input_w;
		WHEN "0101" 	=>	alu_out_mux_w 	<= shifter_res;
		WHEN "0110" 	=>	alu_out_mux_w 	<= shifter_res;
		


		WHEN "0111" =>
			if (signed(a_input_w) < signed(b_input_w)) then
				alu_out_mux_w <= (others => '0'); alu_out_mux_w(0) <= '1';
			else
				alu_out_mux_w <= (others => '0');
			end if;
		WHEN "1000" => alu_out_mux_w <= a_input_w(15 DOWNTO 0) * b_input_w(15 DOWNTO 0);
		WHEN "1001" =>	alu_out_mux_w 	<=  b_input_w(15 DOWNTO 0) & X"0000";

		WHEN OTHERS => alu_out_mux_w <= (others => '0');
  	END CASE;
  END PROCESS;
  
END behavior;

