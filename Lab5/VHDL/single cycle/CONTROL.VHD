---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;


ENTITY control IS
   PORT( 	
		opcode_i 					: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		func_i 						: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst_ctrl_o 				: OUT 	STD_LOGIC;
		JUMP_ctrl_o					: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUSrc_ctrl_o 				: OUT 	STD_LOGIC;
		MemtoReg_ctrl_o 			: OUT 	STD_LOGIC;
		RegWrite_ctrl_o 			: OUT 	STD_LOGIC;
		MemRead_ctrl_o 				: OUT 	STD_LOGIC;
		MemWrite_ctrl_o	 			: OUT 	STD_LOGIC;
		Branch_ctrl_equal_o 		: OUT 	STD_LOGIC;
		Branch_ctrl_not_equal_o 	: OUT 	STD_LOGIC;
		ALUOp_ctrl  	 			: OUT 	STD_LOGIC
	);
END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  rtype_w, lw_w, sw_w, beq_w, bne_w, itype_imm_w, jump_J, jump_JAL, jump_R, Shift: STD_LOGIC;

BEGIN           
				-- Code to generate control signals using opcode bits
				
	rtype_w 			<=  '1'	WHEN	opcode_i = R_TYPE_OPC  		ELSE '0';
	lw_w          		<=  '1'	WHEN  	opcode_i = LW_OPC  			ELSE '0';
 	sw_w          		<=  '1'	WHEN  	opcode_i = SW_OPC  			ELSE '0';
   	beq_w         		<=  '1'	WHEN  	opcode_i = BEQ_OPC  		ELSE '0';
	bne_w         		<=  '1'	WHEN  	opcode_i = BNE_OPC  		ELSE '0';
	itype_imm_w			<=	'1'	WHEN	((opcode_i = ADDI_OPC) or 
										( opcode_i = ORI_OPC)  or 
										( opcode_i = ANDI_OPC))		ELSE '0';  							
	jump_J				<=  '1' WHEN   	(opcode_i = J_OPC)         ELSE '0';
	jump_JAL			<=  '1' WHEN   	(opcode_i = JAL_OPC)       ELSE '0';
	jump_R				<=  '1' WHEN 	(opcode_i = R_TYPE_OPC and func_i = JR_FUNC) ELSE '0';	
	
	
	JUMP_ctrl_o(0) <= jump_R;
	JUMP_ctrl_o(1) <=  jump_J or jump_JAL;
  	RegDst_ctrl_o    			<=  rtype_w;
 	ALUSrc_ctrl_o  				<=  lw_w OR sw_w or itype_imm_w;
	MemtoReg_ctrl_o 			<=  lw_w;
  	RegWrite_ctrl_o 			<=  rtype_w OR lw_w or itype_imm_w or jump_JAL;
  	MemRead_ctrl_o 				<=  lw_w;
   	MemWrite_ctrl_o 			<=  sw_w; 
 	Branch_ctrl_equal_o      	<=  beq_w;
	Branch_ctrl_not_equal_o     <=  bne_w;
	ALUOp_ctrl				<=  rtype_w;
   END behavior;


