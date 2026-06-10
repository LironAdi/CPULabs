---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;


package const_package is
---------------------------------------------------------
--	IDECODE constants
---------------------------------------------------------
	constant R_TYPE_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
	
	constant LW_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "100011";
	constant SW_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";
	
	constant J_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
	constant JAL_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";
	constant JR_FUNC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
	
	constant BEQ_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";
	constant BNE_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";
	
	constant ANDI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001100";
	constant AND_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100100";
	
	constant ORI_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "001101";
	constant OR_FUNC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "100101";
	
	constant XORI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001101";
	constant XOR_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100110";
	
	constant ADDI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
	constant ADDIU_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";
	constant ADD_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100000";
	constant ADDU_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100001";
	
	constant SUB_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100010";
	
	constant SLTI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001010";
	constant SLT_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101010";
	
	constant LUI_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "001111";
	
	constant MUL_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "011100";
	
	constant SLL_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
	constant SRL_FUNC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
	
	
--------------------------------------------------------	
	
	
	

end const_package;

