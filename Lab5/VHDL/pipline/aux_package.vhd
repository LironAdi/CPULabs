---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
USE work.cond_comilation_package.all;


package aux_package is

	component MIPS is
	generic( 
			WORD_GRANULARITY : boolean 	:= G_WORD_GRANULARITY;
	        MODELSIM : integer 			:= G_MODELSIM;
			DATA_BUS_WIDTH : integer 	:= 32;
			ITCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
			DTCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
			PC_WIDTH : integer 			:= 10;
			FUNCT_WIDTH : integer 		:= 6;
			DATA_WORDS_NUM : integer 	:= G_DATA_WORDS_NUM;
			clk_CNT_WIDTH : integer 	:= 16;
			INST_CNT_WIDTH : integer 	:= 16;
			NEXT_PC_WIDTH : integer 	:= G_ADDRWIDTH
	);
	PORT(	rst_i		 		:IN	STD_LOGIC;
			clk_i				:IN	STD_LOGIC;
			BPADDR_i			:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			-- Output important signals to pins for easy display in SignalTap
			STCNT_o				:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);	
			FHCNT_o				:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			pc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			alu_result_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data1_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			write_data_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			instruction_top_o	:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			Branch_ctrl_equal_o	:OUT 	STD_LOGIC;
			Branch_ctrl_not_equal_o	:OUT 	STD_LOGIC;
			Zero_o				:OUT 	STD_LOGIC; 
			MemWrite_ctrl_o		:OUT 	STD_LOGIC;
			RegWrite_ctrl_o		:OUT 	STD_LOGIC;
			trigger				:OUT 	STD_LOGIC;	
			mclk_cnt_o			:OUT	STD_LOGIC_VECTOR(clk_CNT_WIDTH-1 DOWNTO 0);
			inst_cnt_o 			:OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0)
	);	
	end component;
---------------------------------------------------------  
	component control is
	   PORT( 	
			opcode_i 					: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
			func_i 						: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
			Branch_on					: IN 	STD_LOGIC;
			RegDst_ctrl_o 				: OUT 	STD_LOGIC;
			JUMP_ctrl_o					: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUSrc_ctrl_o 				: OUT 	STD_LOGIC;
			MemtoReg_ctrl_o 			: OUT 	STD_LOGIC;
			RegWrite_ctrl_o 			: OUT 	STD_LOGIC;
			MemRead_ctrl_o 				: OUT 	STD_LOGIC;
			MemWrite_ctrl_o	 			: OUT 	STD_LOGIC;
			Branch_ctrl_equal_o 		: OUT 	STD_LOGIC;
			Branch_ctrl_not_equal_o 	: OUT 	STD_LOGIC;
			Flush_IF					: OUT 	STD_LOGIC;
			ALUOp_ctrl  	 			: OUT 	STD_LOGIC
		);		
	end component;
---------------------------------------------------------	
	component dmemory is
		generic(
		DATA_BUS_WIDTH : integer := 32;
		DTCM_ADDR_WIDTH : integer := 8;
		WORDS_NUM : integer := 256
		);
		PORT(	clk_i,rst_i			: IN 	STD_LOGIC;
				dtcm_addr_i 		: IN 	STD_LOGIC_VECTOR(DTCM_ADDR_WIDTH-1 DOWNTO 0);
				dtcm_data_wr_i 		: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				MemRead_ctrl_i  	: IN 	STD_LOGIC;
				MemWrite_ctrl_i 	: IN 	STD_LOGIC;
				dtcm_data_rd_o 		: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0)
		);
	end component;
---------------------------------------------------------		
	component Execute is
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
	end component;
---------------------------------------------------------		
	component Idecode is
		generic(
			DATA_BUS_WIDTH : integer := 32;
			PC_WIDTH : integer := 10
		);
		PORT(	clk_i,rst_i		: IN 	STD_LOGIC;
				instruction_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				dtcm_data_rd_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				alu_result_i	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				pc_plus4_i		: IN    STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
				RegWrite_ctrl_i : IN 	STD_LOGIC;
				MemtoReg_ctrl_i : IN 	STD_LOGIC;
				jump_ctrl_i		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
				alu_res_MEM_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				ForwardA		: IN 	STD_LOGIC;
				ForwardB		: IN 	STD_LOGIC;
				write_reg_addr_i: IN	STD_LOGIC_VECTOR(4 DOWNTO 0);
				read_data1_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				read_data2_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				addr_res_o		: OUT	STD_LOGIC_VECTOR(8-1 DOWNTO 0);
				equal_o			: OUT 	STD_LOGIC;
				write_reg_data_o: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				sign_extend_o 	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0)		 
		);
	end component;
---------------------------------------------------------		
	component Ifetch is
		generic(
			WORD_GRANULARITY : boolean 	:= False;
			DATA_BUS_WIDTH : integer 	:= 32;
			PC_WIDTH : integer 			:= 10;
			NEXT_PC_WIDTH : integer 	:= 8; -- NEXT_PC_WIDTH = PC_WIDTH-2
			ITCM_ADDR_WIDTH : integer 	:= 8;
			WORDS_NUM : integer 		:= 256;
			INST_CNT_WIDTH : integer 	:= 16
		);
		PORT(	
			clk_i, rst_i 			: IN 	STD_LOGIC;
			add_result_i 			: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			read_data1_i			: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			Branch_ctrl_equal_i 	: IN 	STD_LOGIC;
			Branch_ctrl_not_equal_i : IN 	STD_LOGIC;
			Equal_i 				: IN 	STD_LOGIC;
			PCWriteDisable			: IN 	STD_LOGIC;
			instruction_ID			: IN	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			JUMP_ctrl_i				: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			Flush					: IN    STD_LOGIC;
			Branch_on				: OUT 	STD_LOGIC;
			pc_o 					: OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			pc_plus4_o 				: OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			instruction_o 			: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			inst_cnt_o 				: OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0)	
		);
	end component;
	
	component Shifter IS
		GENERIC (n : INTEGER := 32;
				k : INTEGER := 5);
		PORT (  x: IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
				y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				Shift_ctrl: IN STD_LOGIC;
				s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
			);
	end component;
---------------------------------------------------------
	COMPONENT PLL port(
	    areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0     		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC );
    END COMPONENT;
---------------------------------------------------------	
	component ForwardingUnit is
		generic(
			DATA_BUS_WIDTH : integer := 32;
			FUNCT_WIDTH : integer := 6;
			PC_WIDTH : integer := 10
		);
		PORT(	
			write_reg_addr_MEM 				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			write_reg_addr_WB 				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			RegWrite_MEM, RegWrite_WB 		: IN STD_LOGIC;
			memwrite_EX						: IN STD_LOGIC;
			rt_register_EX, rt_register_ID  : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			rs_register_EX, rs_register_ID  : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			ForwardA_EX, ForwardB_EX		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			ForwardA_ID, ForwardB_ID		: OUT STD_LOGIC
		);
    END COMPONENT;
	
	component StallUnit is
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
    END COMPONENT;

end aux_package;

