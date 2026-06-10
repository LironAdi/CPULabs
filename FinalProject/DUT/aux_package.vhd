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
			CLK_CNT_WIDTH : integer 	:= 16;
			INST_CNT_WIDTH : integer 	:= 16;
			NEXT_PC_WIDTH : integer 	:= G_ADDRWIDTH
		);
		PORT(	rst_i		 		:IN	STD_LOGIC;
				clk_i				:IN	STD_LOGIC;
				INTR				:IN STD_LOGIC;
				-- Output important signals to pins for easy display in SignalTap
				INTA				:OUT STD_LOGIC;
				GIE_o				:OUT 	STD_LOGIC;
				pc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
				ADDRESS_BUS 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);			
				DATA_BUS 			:INOUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				instruction_top_o	:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				Zero_o				:OUT 	STD_LOGIC; 
				MemWrite_ctrl_o		:OUT 	STD_LOGIC;
				mclk_cnt_o			:OUT	STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
				mem_read_o			:OUT	STD_LOGIC;
				inst_cnt_o 			:OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0)
		);		
	end component;
---------------------------------------------------------  
	component control is
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
			is_IO_addr			: IN 	STD_LOGIC;
			DATA_BUS			:INOUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
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
			funct_i 		: IN 	STD_LOGIC_VECTOR(FUNCT_WIDTH-1 DOWNTO 0);
			ALUOp_ctrl_i 	: IN 	STD_LOGIC;
			ALUSrc_ctrl_i 	: IN 	STD_LOGIC;
			pc_plus4_i 		: IN 	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			opc_i			: IN 	STD_LOGIC_VECTOR(FUNCT_WIDTH-1 DOWNTO 0);
			zero_o 			: OUT	STD_LOGIC;
			alu_res_o 		: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			addr_res_o 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 )
	);
	end component;
---------------------------------------------------------		
	component Idecode is
		generic(
			DATA_BUS_WIDTH : integer := 32;
			PC_WIDTH : integer 		 := 10
			
		);
		PORT(	clk_i,rst_i		: IN 	STD_LOGIC;
				--ISR_MODE		: IN 	STD_LOGIC;
				INTR			: IN 	STD_LOGIC;
				ack_stage_i		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);	
				instruction_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				dtcm_data_rd_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				alu_result_i	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				RegWrite_ctrl_i : IN 	STD_LOGIC;
				MemtoReg_ctrl_i : IN 	STD_LOGIC;
				RegDst_ctrl_i 	: IN 	STD_LOGIC;
				pc_plus4_i 		: IN	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
				jump_ctrl_i		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
				GIE_o			: OUT 	STD_LOGIC;
				rs_register_o	: OUT   STD_LOGIC_VECTOR( 4 DOWNTO 0 );	
				read_data1_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				read_data2_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
				ISR_ADDRESS		: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
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
			ack_stage_i				: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);	
			add_result_i 			: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			read_data1_i			: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			ISR_address				: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			TYPE_R					: IN 	STD_LOGIC_VECTOR(15 DOWNTO 0);
			Branch_ctrl_equal_i 	: IN 	STD_LOGIC;
			Branch_ctrl_not_equal_i : IN 	STD_LOGIC;
			zero_i 					: IN 	STD_LOGIC;
			INTR					: IN    STD_LOGIC;
			JUMP_ctrl_i				: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
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
	COMPONENT GPIO is 
		PORT(  clock,reset       		: IN 	 STD_LOGIC;
			memRead,	memWrite 		: IN 	 STD_LOGIC;
			Address_in		       		: IN 	 STD_LOGIC_VECTOR(15 DOWNTO 0);
			SW   			 			: IN 	 STD_LOGIC_VECTOR(7 DOWNTO 0);
			Data		         		: INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
			Leds						: OUT 	 STD_LOGIC_VECTOR(7 DOWNTO 0);
			Hex0,Hex1,Hex2,Hex3,Hex4,Hex5 : OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
			);
	end COMPONENT;
----------------------------------------------------------

	COMPONENT bidirpin IS
		generic( width: integer:=16 );
		port(   Dout: 	in 		std_logic_vector(width-1 downto 0);
				en:		in 		std_logic;
				Din:	out		std_logic_vector(width-1 downto 0);
				IOpin: 	inout 	std_logic_vector(width-1 downto 0)
		);
	end COMPONENT;

------------------------------------------------------------

	COMPONENT PLL 
	generic( 
			clk0_multiply_by : integer 	:= 1;
	        clk0_divide_by : integer 	:= 1
	);
	port(
	    areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0     		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC );
    END COMPONENT;
	
		COMPONENT PLL_lower_freq 
	port(
	    areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0     		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC );
    END COMPONENT;
	
---------------------------------------------------------	
	COMPONENT Interrupt_Controller IS
	  GENERIC (n : INTEGER := 32);
	  PORT 
	  ( MCLK_i                               	 :IN STD_LOGIC;
		INTA								 	 :IN STD_LOGIC;
		GIE										 :IN STD_LOGIC;
		irq										 :IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		RST										 :IN STD_LOGIC;
		mem_Write,mem_Read						 :IN STD_LOGIC;
		CS 										 :IN STD_LOGIC;
		FIROUT, FIFOEMPTY						 :IN STD_LOGIC;
		DATA_BUS								 :INOUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ADDRESS_BUS							  	 :IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		INTR								 	 :OUT STD_LOGIC	 
	  );
    END COMPONENT;
---------------------------------------------------------	
	COMPONENT Basic_Timer IS
	  GENERIC (n : INTEGER := 32);
	  PORT 
	  ( MCLK_i                               :IN STD_LOGIC;
		BTHOLD_i, BTCLR_i 	                 :IN STD_LOGIC;
		BTOUTMD_i, BTOUTEN_i 			 	 :IN STD_LOGIC;
		BTCCR0_i, BTCCR1_i 				 	 :IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		BTIPx_i, BTSSELx_i 		 	         :IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		BTCNT_io							 :OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		BTIFG_o						 	     :OUT STD_LOGIC;
		PWM_out								 :OUT STD_LOGIC	 
	  );
    END COMPONENT;
---------------------------------------------------------	
	COMPONENT Output_Unit IS
	  GENERIC (n : INTEGER := 32);
	  PORT 
	  (  CLK_i, BTOUTEN_i, BTOUTMD_i	:IN STD_LOGIC;
		 BTCCR0_i, BTCCR1_i				:IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		 Count_i						:IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		 HEU0_o							:OUT STD_LOGIC;
		 PWM_out						:OUT STD_LOGIC
	  );
    END COMPONENT;
---------------------------------------------------------	
	COMPONENT BTCNT IS
	  GENERIC (n : INTEGER := 32);
	  PORT (    EN_i, CLK_i, BTCLR_i, HEU0_i   :IN STD_LOGIC;
				Q24_o, Q28_o, Q32_o 		   :OUT STD_LOGIC;
				Count_o 				       :OUT STD_LOGIC_VECTOR (n-1 downto 0)
			);
    END COMPONENT;

---------------------------------------------------------	
	COMPONENT Peripherals IS
	  GENERIC (n : INTEGER := 32);
	  PORT 
	  ( MCLK_i                               	 :IN STD_LOGIC;
		INTA								 	 :IN STD_LOGIC;
		GIE										 :IN STD_LOGIC;
		irq										 :IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		--Port_KEYS								 :IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		RST										 :IN STD_LOGIC;
		mem_Write,mem_Read						 :IN STD_LOGIC;
		FIRCLK									 :IN STD_LOGIC;						
		DATA_BUS								 :INOUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ADDRESS_BUS							  	 :IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		INTR								 	 :OUT STD_LOGIC;
		PWM_out									 :OUT STD_LOGIC	 
		
	  );
    END COMPONENT;
---------------------------------------------------------		
	COMPONENT top IS
		generic( 
	        MODELSIM : integer 			:= G_MODELSIM
	);
	PORT(  reset,CLK_50Mhz				 : IN 	STD_LOGIC; 
		   --ena						 	 : IN 	STD_LOGIC; 
		   SW   						 : IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
		   --RX,TX 					     : IN 	STD_LOGIC; 
		   Key1,Key2,Key3			     : IN 	STD_LOGIC; 
		   --FIR						     : IN 	STD_LOGIC;
		   Leds							 : OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0 );
		   Hex0,Hex1,Hex2,Hex3,Hex4,Hex5 : OUT 	STD_LOGIC_VECTOR(6 DOWNTO 0 );
		   PWM_out                  	 : OUT 	STD_LOGIC
		   );
    END COMPONENT;
---------------------------------------------------------		
	COMPONENT D_latch IS
		PORT ( D, EN, CLR : IN  STD_LOGIC;
			   Q          : OUT STD_LOGIC
		);
	END COMPONENT;
---------------------------------------------------------
	COMPONENT Decoder is
	  port (
			Data_IN:			in STD_LOGIC_VECTOR(3 downto 0);
			Data_OUT:			out STD_LOGIC_VECTOR(6 downto 0)
	  );
	END COMPONENT;
---------------------------------------------------------	
	COMPONENT DFF_h is
		generic( Awidth: integer:=6 );
		port(   clk,en,rst:			in 		std_logic;
				D: 					in 		std_logic_vector(Awidth-1 downto 0);
				Q:					out		std_logic_vector(Awidth-1 downto 0)
				);
	end COMPONENT;	
	
--------------------------------------------------------------------[

	COMPONENT FIR IS
	    generic(
			n:         INTEGER := 32;
			W : integer := 24;
			Q : integer := 8;
			M : integer := 8;
			cell : integer := 24;  -- !!! 25 in upper modules
			k         : integer := 8;
			pointer  : integer := 3
		);
		-------
		
		port(
			rst_global 	:in  std_logic;
			FIRCLK,FIFOCLK									:IN  std_logic;
			FIFOEMPTY_IFG,FIRIFG					:OUT std_logic;
			Data									:inout std_logic_vector(n-1 downto 0);
			address_in								:in  std_logic_vector(11 downto 0);
			MemWrite_i,MemRead_i				:in std_logic
		
			);
	end COMPONENT;	

end aux_package;

