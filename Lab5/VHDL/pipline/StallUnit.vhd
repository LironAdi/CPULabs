LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;
USE ieee.numeric_std.ALL;
USE work.aux_package.all;


ENTITY  StallUnit IS
	generic(
		DATA_BUS_WIDTH : integer := 32;
		FUNCT_WIDTH : integer := 6;
		PC_WIDTH : integer := 10
	);
	PORT(
		instruction_ID	 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
		write_reg_addr_EX	: IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
		write_reg_addr_MEM	: IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
		MemRead_EX			: IN    STD_LOGIC;
		MemRead_MEM			: IN    STD_LOGIC;
		regwrite_EX			: IN    STD_LOGIC;
		HAZARD				: OUT   STD_LOGIC
	);
END StallUnit;

ARCHITECTURE structure OF StallUnit IS
SIGNAL rs_register_ID 	   	 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rt_register_ID		 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL opcode_ID	 	 	 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL func_ID	 	 		 : STD_LOGIC_VECTOR(5 DOWNTO 0);
--SIGNAL If_idWriteDisable_w   : STD_LOGIC;
--SIGNAL PCWriteDisable_w      : STD_LOGIC;
--SIGNAL stall_w 				 : STD_LOGIC;
SIGNAL I_type 				 : STD_LOGIC;
--SIGNAL HAZARD 				 : STD_LOGIC := '0';
--SIGNAL rd_register_EX : STD_LOGIC_VECTOR(4 DOWNTO 0);
--SIGNAL rt_register_EX : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal HAZARD1 				 : std_logic;
signal HAZARD2				 : std_logic;
signal HAZARD3 				 : std_logic;
signal HAZARD4 				 : std_logic;
signal HAZARD5 				 : std_logic;

begin
	opcode_ID				<= instruction_ID(31 DOWNTO 26);
	rs_register_ID 			<= instruction_ID(25 DOWNTO 21);
   	rt_register_ID			<= instruction_ID(20 DOWNTO 16);
	func_ID					<= instruction_ID(5  DOWNTO  0);

	
   	--rt_register_EX 			<= instruction_EX(20 DOWNTO 16);
   	--rd_register_EX			<= instruction_EX(15 DOWNTO 11);


I_type <= '1' WHEN opcode_ID = ADDI_OPC or opcode_ID = XORI_OPC or opcode_ID = SLTI_OPC or opcode_ID = ORI_OPC 
					or opcode_ID = ANDI_OPC or opcode_ID = ADDIU_OPC or opcode_ID = LUI_OPC ELSE '0';




-- In decode stage we have instruction that it not I_type and in Excute we have load word
-- and we equalize the register of execute and decode
HAZARD1 <= '1' when 
    MemRead_EX = '1' and
    (
      rs_register_ID = write_reg_addr_EX or 
      (rt_register_ID = write_reg_addr_EX and I_type = '0')
    )
    else '0';
HAZARD2 <= '1' when
    (
      (opcode_ID = BEQ_OPC or opcode_ID = BNE_OPC)
      and MemRead_EX = '1'
      and (rs_register_ID = write_reg_addr_EX or rt_register_ID = write_reg_addr_EX)
    )
	else '0';
HAZARD3 <= '1' when
    (
      opcode_ID = JR_FUNC
      and MemRead_EX = '1'
      and rs_register_ID = write_reg_addr_EX
    )
    else '0';
	
HAZARD4 <= '1' when
    (
      (opcode_ID = BEQ_OPC or opcode_ID = BNE_OPC)
      and regwrite_EX = '1' and MemRead_EX = '0'
      and (rs_register_ID = write_reg_addr_EX or rt_register_ID = write_reg_addr_EX)
    )
    else '0';


HAZARD5 <= '1' when
    (
		MemRead_MEM = '1'
      and (rs_register_ID = write_reg_addr_MEM or (rt_register_ID = write_reg_addr_MEM and I_type = '0'))
    )
    else '0';

	
	HAZARD <= HAZARD5 or HAZARD4 or HAZARD3 or HAZARD2 or HAZARD1;


END structure;