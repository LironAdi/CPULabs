---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;
USE work.cond_comilation_package.all;
USE work.aux_package.all;


ENTITY MIPS IS
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
END MIPS;
-------------------------------------------------------------------------------------
ARCHITECTURE structure OF MIPS IS
	-- declare signals used to connect VHDL components
	SIGNAL pc_plus4_w1 		: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	SIGNAL pc_plus4_w2 		: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	
	SIGNAL instruction_w1	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL instruction_w2	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL instruction_w3	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	
	SIGNAL read_data1_w1 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL read_data1_w2 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL read_data2_w1 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL read_data2_w2	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

	SIGNAL sign_extend_w1 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL sign_extend_w2 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	
	SIGNAL ForwardA_EX		: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ForwardB_EX		: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ForwardA_ID		: STD_LOGIC;
	SIGNAL ForwardB_ID		: STD_LOGIC;
	
	SIGNAL WriteData_toMEM_w1	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL WriteData_toMEM_w2	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	
	SIGNAL addr_res_w		: STD_LOGIC_VECTOR(7 DOWNTO 0 );
	SIGNAL equal_w			: STD_LOGIC;

	SIGNAL alu_result_w1 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL alu_result_w2 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL alu_result_w3 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

	SIGNAL write_reg_addr_w1: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL write_reg_addr_w2: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL write_reg_addr_w3: STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	SIGNAL dtcm_data_rd_w1 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL dtcm_data_rd_w2	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

	---Ex---
	SIGNAL alu_op_w1 		: STD_LOGIC;
	SIGNAL alu_op_w2 		: STD_LOGIC;
	SIGNAL reg_dst_w1		: STD_LOGIC;
	SIGNAL reg_dst_w2		: STD_LOGIC;
	SIGNAL alu_src_w1 		: STD_LOGIC;
	SIGNAL alu_src_w2 		: STD_LOGIC;
	---M---
	SIGNAL branch_BNE_w 	: STD_LOGIC;
	SIGNAL branch_BEQ_w 	: STD_LOGIC;	
	SIGNAL mem_write_w1 	: STD_LOGIC;
	SIGNAL mem_write_w2 	: STD_LOGIC;
	SIGNAL mem_write_w3 	: STD_LOGIC;
	SIGNAL mem_read_w1 		: STD_LOGIC;	
	SIGNAL mem_read_w2 		: STD_LOGIC;	
	SIGNAL mem_read_w3 		: STD_LOGIC;	
	SIGNAL jump_w1			: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL jump_w2			: STD_LOGIC_VECTOR(1 DOWNTO 0);
	---WB---
	SIGNAL MemtoReg_w1 		: STD_LOGIC;
	SIGNAL MemtoReg_w2 		: STD_LOGIC;
	SIGNAL MemtoReg_w3 		: STD_LOGIC;
	SIGNAL MemtoReg_w4 		: STD_LOGIC;
	SIGNAL reg_write_w1 	: STD_LOGIC;
	SIGNAL reg_write_w2 	: STD_LOGIC;
	SIGNAL reg_write_w3 	: STD_LOGIC;
	SIGNAL reg_write_w4 	: STD_LOGIC;

	SIGNAL Write_data_w     : STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL Mclk_w 			: STD_LOGIC;
	SIGNAL mclk_cnt_q		: STD_LOGIC_VECTOR(clk_CNT_WIDTH-1 DOWNTO 0);
	SIGNAL STCNT_q			: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL FHCNT_q			: STD_LOGIC_VECTOR(7 DOWNTO 0);	
	SIGNAL inst_cnt_w		: STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
	
	SIGNAL Flush_IF_w		: STD_LOGIC;
	signal Hazard			: STD_LOGIC;
	signal Branch_on		: STD_LOGIC;
	signal BPADDR_W			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	signal pc_w				: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	
BEGIN

BPADDR_W <= BPADDR_i(7 DOWNTO 0) & "00";
trigger <= '1' WHEN BPADDR_W = pc_w ELSE '0';

					-- copy important signals to output pins for easy 
					-- display in Simulator
------------------------------------
Reg_IR1: process(clk_i, rst_i)
begin
    if rst_i = '1' then
        pc_plus4_w2 	<= (others => '0');
        instruction_w2  <= (others => '0');
    elsif rising_edge(clk_i) then
        -- if there is a jump or branch instruction clear fetch stage
        if Flush_IF_w = '1' And Hazard = '0' then 
            pc_plus4_w2 <= (others=>'0');
            instruction_w2 <= (others=>'0');
        elsif Hazard = '0' then		
            pc_plus4_w2 <= pc_plus4_w1;
            instruction_w2 <= instruction_w1;
        end if;	
    end if;
end process;	
------------------------------------					
Reg_IR2: process(clk_i, rst_i)
begin
    if rst_i = '1' then
        read_data1_w2    <= (others => '0');
        read_data2_w2    <= (others => '0');
        sign_extend_w2   <= (others => '0');
        instruction_w3   <= (others => '0');
        alu_op_w2        <= '0';
        reg_dst_w2       <= '0';
        alu_src_w2       <= '0';
        mem_write_w2     <= '0';
        mem_read_w2      <= '0';
        jump_w2          <= (others => '0');
        MemtoReg_w2      <= '0';
        reg_write_w2     <= '0';
		
    elsif rising_edge(clk_i) then
        read_data1_w2 <= read_data1_w1;
        read_data2_w2 <= read_data2_w1;
        sign_extend_w2 <= sign_extend_w1;
        instruction_w3 <= instruction_w2;
        
		if Hazard = '1' then
            alu_op_w2    <= '0';
            reg_dst_w2   <= '0';
            alu_src_w2   <= '0';
            mem_write_w2 <= '0';  
            mem_read_w2  <= '0'; 	
            jump_w2      <= "00";
            MemtoReg_w2  <= '0';
            reg_write_w2 <= '0';
        else
            alu_op_w2    <= alu_op_w1;
            reg_dst_w2   <= reg_dst_w1;
            alu_src_w2   <= alu_src_w1; 	
            mem_write_w2 <= mem_write_w1;  
            mem_read_w2  <= mem_read_w1; 	
            jump_w2      <= jump_w1;
            MemtoReg_w2  <= MemtoReg_w1;
            reg_write_w2 <= reg_write_w1;
        end if;
    end if;
end process;
					
------------------------------------					
Reg_IR3: process(clk_i, rst_i)
begin
    if rst_i = '1' then
        alu_result_w2     <= (others => '0');
		WriteData_toMEM_w2<= (others => '0');
        write_reg_addr_w2 <= (others => '0');
        mem_write_w3      <= '0';
        mem_read_w3       <= '0';
        MemtoReg_w3       <= '0';
        reg_write_w3      <= '0';
    elsif rising_edge(clk_i) then
        alu_result_w2     <= alu_result_w1;
		WriteData_toMEM_w2<=WriteData_toMEM_w1;
        write_reg_addr_w2 <= write_reg_addr_w1;
        mem_write_w3      <= mem_write_w2;  
        mem_read_w3       <= mem_read_w2; 	
        MemtoReg_w3       <= MemtoReg_w2;
        reg_write_w3      <= reg_write_w2;
    end if;
end process;
					
					
------------------------------------					
Reg_IR4: process(clk_i, rst_i)
begin
    if rst_i = '1' then
        reg_write_w4       <= '0';
        MemtoReg_w4        <= '0';
        dtcm_data_rd_w2    <= (others => '0');
        alu_result_w3      <= (others => '0');
        write_reg_addr_w3  <= (others => '0');
    elsif rising_edge(clk_i) then
        reg_write_w4       <= reg_write_w3;
        MemtoReg_w4        <= MemtoReg_w3;
        dtcm_data_rd_w2    <= dtcm_data_rd_w1;
        alu_result_w3      <= alu_result_w2;
        write_reg_addr_w3  <= write_reg_addr_w2;
    end if;
end process;
					
------------------------------------					
					
					
					
   instruction_top_o 	<= 	instruction_w1;
   alu_result_o 		<= 	alu_result_w1;
   read_data1_o 		<= 	read_data1_w1;
   read_data2_o 		<= 	read_data2_w1;
   write_data_o  		<= 	dtcm_data_rd_w1 WHEN MemtoReg_w1 = '1' ELSE alu_result_w1;	 						
   Branch_ctrl_equal_o  	<= 	branch_BEQ_w;
   Branch_ctrl_not_equal_o  <= 	branch_BNE_w;
   Zero_o 				<= 	equal_w;
   RegWrite_ctrl_o 		<= 	reg_write_w1;
   MemWrite_ctrl_o 		<= 	mem_write_w1;	
   pc_o					<=  pc_w;
	
	-- connect the PLL component
	G0:
	if (MODELSIM = 0) generate
	  Mclk: PLL
		PORT MAP (
			inclk0 	=> clk_i,
			c0 		=> Mclk_w
		);
	else generate
		Mclk_w <= clk_i;
	end generate;
	-- connect the 5 MIPS components   
	IFE : Ifetch
	generic map(
		WORD_GRANULARITY	=> 	WORD_GRANULARITY,
		DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
		PC_WIDTH			=>	PC_WIDTH,
		NEXT_PC_WIDTH 		=>	NEXT_PC_WIDTH,
		ITCM_ADDR_WIDTH		=>	ITCM_ADDR_WIDTH,
		WORDS_NUM			=>	DATA_WORDS_NUM,
		INST_CNT_WIDTH		=>	INST_CNT_WIDTH
	)
	PORT MAP (	
		clk_i 			=> Mclk_w,  
		rst_i 			=> rst_i, 
		add_result_i 	=> addr_res_w,
		read_data1_i	=> read_data1_w1,
		Branch_ctrl_equal_i => branch_BEQ_w,
		Branch_ctrl_not_equal_i => branch_BNE_w,
		Equal_i 		=> equal_w,
		PCWriteDisable	=> Hazard,
		instruction_ID	=> instruction_w2,
		JUMP_ctrl_i		=> jump_w1,
		Flush			=> Flush_IF_w,		
		Branch_on		=> Branch_on,
		pc_o 			=> pc_w,
		pc_plus4_o	 	=> pc_plus4_w1,
		instruction_o 	=> instruction_w1,
		inst_cnt_o		=> inst_cnt_w
	);

	ID : Idecode
   	generic map(
		DATA_BUS_WIDTH		=>  DATA_BUS_WIDTH,
		PC_WIDTH			=>  PC_WIDTH
	)
	PORT MAP (	
			clk_i 				=> Mclk_w,  
			rst_i 				=> rst_i,
        	instruction_i 		=> instruction_w2,
        	dtcm_data_rd_i 		=> dtcm_data_rd_w2,
			alu_result_i 		=> alu_result_w3,
			pc_plus4_i			=> pc_plus4_w2,
			RegWrite_ctrl_i 	=> reg_write_w4,
			MemtoReg_ctrl_i 	=> MemtoReg_w4,
			jump_ctrl_i			=> jump_w1,
			alu_res_MEM_i		=> alu_result_w2,
			ForwardA			=> ForwardA_ID,
			ForwardB			=> ForwardB_ID,
			write_reg_addr_i	=> write_reg_addr_w3,
			read_data1_o 		=> read_data1_w1,
        	read_data2_o 		=> read_data2_w1,
			addr_res_o			=> addr_res_w,
			equal_o				=> equal_w,
			write_reg_data_o	=> Write_data_w,
			sign_extend_o 		=> sign_extend_w1	 
		);
		
CTL:   control		
		PORT MAP ( 	
		opcode_i 			=> instruction_w2(DATA_BUS_WIDTH-1 DOWNTO 26),
		func_i				=> instruction_w2(5 DOWNTO 0),
		Branch_on			=> Branch_on,
		RegDst_ctrl_o 		=> reg_dst_w1,
		JUMP_ctrl_o			=> jump_w1,
		ALUSrc_ctrl_o 		=> alu_src_w1,
		MemtoReg_ctrl_o 	=> MemtoReg_w1,
		RegWrite_ctrl_o 	=> reg_write_w1,
		MemRead_ctrl_o 		=> mem_read_w1,
		MemWrite_ctrl_o 	=> mem_write_w1,
		Branch_ctrl_equal_o => branch_BEQ_w,
		Branch_ctrl_not_equal_o => branch_BNE_w,
		Flush_IF			=> Flush_IF_w,
		ALUOp_ctrl 			=> alu_op_w1
		);


	EXE:  Execute
   	generic map(
		DATA_BUS_WIDTH 		=> 	DATA_BUS_WIDTH,
		FUNCT_WIDTH 		=>	FUNCT_WIDTH,
		PC_WIDTH 			=>	PC_WIDTH
	)
	PORT MAP (	
		read_data1_i 	=> read_data1_w2,
        read_data2_i 	=> read_data2_w2,
		sign_extend_i 	=> sign_extend_w2,
		ALUOp_ctrl_i 	=> alu_op_w2,
		ALUSrc_ctrl_i 	=> alu_src_w2,
		RegDst_ctrl_i	=> reg_dst_w2,
		instruction_i	=> instruction_w3,
		Write_data_i	=> Write_data_w,
		alu_res_MEM_i   => alu_result_w2,
		ForwardA        => ForwardA_EX, 
		ForwardB        => ForwardB_EX,
		write_reg_addr_o=> write_reg_addr_w1,
		WriteData_toMEM => WriteData_toMEM_w1,
        alu_res_o		=> alu_result_w1		
	);

Forwarding: ForwardingUnit
	generic map(
		DATA_BUS_WIDTH 		=> 	DATA_BUS_WIDTH,
		FUNCT_WIDTH 		=>	FUNCT_WIDTH,
		PC_WIDTH 			=>	PC_WIDTH
	)
	port map(
		write_reg_addr_MEM 		=> write_reg_addr_w2,		
		write_reg_addr_WB 		=> write_reg_addr_w3,		
		RegWrite_MEM            => reg_write_w3,
		RegWrite_WB 		    => reg_write_w4,
		memwrite_EX				=> mem_write_w2,
		rt_register_EX          => instruction_w3(20 DOWNTO 16),
		rt_register_ID          => instruction_w2(20 DOWNTO 16),
		rs_register_EX          => instruction_w3(25 DOWNTO 21),
		rs_register_ID          => instruction_w2(25 DOWNTO 21),
		ForwardA_EX             => ForwardA_EX,
		ForwardB_EX		        => ForwardB_EX,
		ForwardA_ID             => ForwardA_ID,
		ForwardB_ID		        => ForwardB_ID

	);
	
Stall1:	StallUnit
	generic map(
		DATA_BUS_WIDTH 		=> 	DATA_BUS_WIDTH,
		FUNCT_WIDTH 		=>	FUNCT_WIDTH,
		PC_WIDTH 			=>	PC_WIDTH
	)
	port map(
		instruction_ID	 	=> instruction_w2,		
		write_reg_addr_EX	=> write_reg_addr_w1,
		write_reg_addr_MEM	=> write_reg_addr_w2,
		regwrite_EX			=> reg_write_w2,
		MemRead_EX			=> mem_read_w2,
		MemRead_MEM			=> mem_read_w3,
		Hazard				=> Hazard
	);
	

	G1: 
	if (WORD_GRANULARITY = True) generate -- i.e. each WORD has a unike address
		MEM:  dmemory
			generic map(
				DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
				DTCM_ADDR_WIDTH		=> 	DTCM_ADDR_WIDTH,
				WORDS_NUM			=>	DATA_WORDS_NUM
			)
			PORT MAP (	
				clk_i 				=> Mclk_w,  
				rst_i 				=> rst_i,
				dtcm_addr_i 		=> alu_result_w2((DTCM_ADDR_WIDTH+2)-1 DOWNTO 2), -- increment memory address by 4
				dtcm_data_wr_i 		=> WriteData_toMEM_w2,
				MemRead_ctrl_i 		=> mem_read_w3, 
				MemWrite_ctrl_i 	=> mem_write_w3,
				dtcm_data_rd_o 		=> dtcm_data_rd_w1 
			);	
	elsif (WORD_GRANULARITY = False) generate -- i.e. each BYTE has a unike address	
		MEM:  dmemory
			generic map(
				DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
				DTCM_ADDR_WIDTH		=> 	DTCM_ADDR_WIDTH,
				WORDS_NUM			=>	DATA_WORDS_NUM
			)
			PORT MAP (	
				clk_i 				=> Mclk_w,  
				rst_i 				=> rst_i,
				dtcm_addr_i 		=> alu_result_w2(DTCM_ADDR_WIDTH-1 DOWNTO 2)&"00",
				dtcm_data_wr_i 		=> WriteData_toMEM_w2,
				MemRead_ctrl_i 		=> mem_read_w3, 
				MemWrite_ctrl_i 	=> mem_write_w3,
				dtcm_data_rd_o 		=> dtcm_data_rd_w1
			);
	end generate;
---------------------------------------------------------------------------------------
--									IPC - Mclk counter register
---------------------------------------------------------------------------------------
process (Mclk_w , rst_i)
begin
	if rst_i = '1' then
		mclk_cnt_q	<=	(others	=> '0');
		FHCNT_q		<=	(others	=> '0');
		STCNT_q		<=	(others	=> '0');
	elsif rising_edge(Mclk_w) then
		mclk_cnt_q	<=	mclk_cnt_q + '1';
		if rising_edge(Mclk_w) and Hazard = '1' then
			STCNT_q <= STCNT_q + '1';
		elsif rising_edge(Mclk_w) and Flush_IF_w = '1' then
			FHCNT_q <= FHCNT_q + '1';
		end if;
	end if;
end process;

FHCNT_o		<=  FHCNT_q;
STCNT_o     <=  STCNT_q;
mclk_cnt_o	<=	mclk_cnt_q;
inst_cnt_o	<=	inst_cnt_w;
---------------------------------------------------------------------------------------
END structure;

