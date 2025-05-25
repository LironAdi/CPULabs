library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.aux_package.all;
--------------------------------------------------------------
entity Datapath is		 
generic(Dwidth:			integer:=16;
		Awidth:			integer:=6;
		offsetwidth:	integer:=8;
		dept :	  		integer:=64;
		OPC_size: 		integer:=4;
		Reg_size: 		integer:=4;
		two: 			integer:=2;
		Alufn_size: 	integer:=4
		);		 
		 
		 
port(clk,rst:					in std_logic;	
	---- PC ------				
	PCin:						in std_logic;
	PCsel:					 	in std_logic_vector(1 downto 0);
	---- program memory ---
	memEn: 						in std_logic;	
	ITCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0);
	ITCM_tb_addr_in:			in std_logic_vector(Awidth-1 downto 0);
	------ IR --------
	IRin:						in std_logic;
	RFadder_rd, RFadder_wr: 	in std_logic_vector(1 downto 0);
	----- OPC ------
	 st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,jn: out std_logic;
	---- RF -------
	RFin, RFout:					in std_logic; 
	----BIDIR-----
	Imm1_in, Imm2_in, DTCM_out:	in std_logic; 
	----- ALU ----------
	Ain: 						in std_logic;
	ALUFN:						in std_logic_vector(Alufn_size-1 downto 0);
	Cflag, Zflag, Nflag:		out std_logic;
	------- MUX -----
	DTCM_addr_sel:				 in std_logic; 
	DTCM_addr_out,DTCM_addr_in:	 in std_logic;   
	-------Data memory --------
	DTCM_tb_out: 				out std_logic_vector(Dwidth-1 downto 0); ------data_out <=> DM_out 
	DTCM_wr, TBactive: 			in std_logic;
	DTCM_tb_wr: 					in std_logic;
	DTCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0); 
	DTCM_tb_addr_in,DTCM_tb_addr_out: in std_logic_vector(Awidth-1 downto 0)
	);
end Datapath;
--------------------------------------------------------------
architecture Data of Datapath is

signal IR_Imm8:						std_logic_vector(offsetwidth-1 downto 0);
signal IR_Imm4:						std_logic_vector(Reg_size-1 downto 0);
signal PC_out:						std_logic_vector(Awidth-1 downto 0); -----RmemData ------ 
signal RmemData:  					std_logic_vector(Dwidth-1 downto 0); -----Data Out --- 
signal writeAddr:  					std_logic_vector(Reg_size-1 downto 0);
signal readAddr:  					std_logic_vector(Reg_size-1 downto 0);
signal OPCin:  						std_logic_vector(Reg_size-1 downto 0);
signal RF_dataout: 					std_logic_vector(Dwidth-1 downto 0);
signal BUS_B, BUS_A:				std_logic_vector(Dwidth-1 downto 0);
signal Sign_ext_Im8, Sign_ext_Im4: 	std_logic_vector(Dwidth-1 downto 0);
signal A: 						std_logic_vector(Dwidth-1 downto 0);
signal F1_in, F2_in: 				std_logic_vector(Awidth-1 downto 0);
signal F1_out, F2_out:				std_logic_vector(Awidth-1 downto 0);
signal DM_out:						std_logic_vector(Dwidth-1 downto 0);
signal DmemEn:  					std_logic;	
signal WmemData:					std_logic_vector(Dwidth-1 downto 0);
signal WmemAddr,RmemAddr:			std_logic_vector(Awidth-1 downto 0);
signal C_flag,N_flag:                       std_logic;


begin		   
-------------------- ADD ALL THE GENERAIC MAPS , PORT MAP
PC : PCunit generic map(two,Awidth,offsetwidth)port map (clk,PCin,PCsel,IR_Imm8,PC_out); 
Prog_mem : progMem generic map(Dwidth, Awidth, dept)port map (clk,memEn,ITCM_tb_in,ITCM_tb_addr_in,PC_out,RmemData);
IR_1: IR generic map(two,Dwidth,Reg_size,4,8)port map(IRin,RFadder_rd,RFadder_wr,RmemData,writeAddr,readAddr,OPCin,IR_Imm4,IR_Imm8);
OPC: OPCdec generic map(OPC_size)port map(OPCin,st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,jn);
RF_1: RF generic map(Dwidth,Reg_size)port map(clk,rst,RFin,BUS_A,writeAddr,readAddr,RF_dataout);
Bidir_RF: BidirPin generic map(Dwidth)port map(RF_dataout,RFout,open,BUS_B);
------------------
Sign_ext_Im8 <= SXT(IR_Imm8, Dwidth);
Sign_ext_Im4 <= SXT(IR_Imm4, Dwidth);	
-------------------
Bidir_IM1: BidirPin generic map(Dwidth)port map(Sign_ext_Im8,Imm1_in,open,BUS_B);
Bidir_IM2: BidirPin generic map(Dwidth)port map(Sign_ext_Im4,Imm2_in,open,BUS_B);
---------------------
Reg_A: RegA generic map(Dwidth)port map(clk,Ain,BUS_A,A); 
ALU_1: ALU generic map(Alufn_size,Dwidth)port map(A,BUS_B,ALUFN,C_flag, Zflag, N_flag,BUS_A);
----MUX ------
F1_in <= BUS_B(Awidth-1 downto 0) when DTCM_addr_sel='1'else BUS_A(Awidth-1 downto 0);
F2_in <= BUS_B(Awidth-1 downto 0) when DTCM_addr_sel='1'else BUS_A(Awidth-1 downto 0);
----- DFF1 + DFF2 ------------
DFF_1: DFF generic map(Awidth) port map(clk, DTCM_addr_out, rst, F1_in,F1_out);
DFF_2: DFF generic map(Awidth) port map(clk, DTCM_addr_in, rst, F2_in,F2_out);
--------------
Bidir_DM: BidirPin generic map(Dwidth)port map(DM_out,DTCM_out,open,BUS_B);
----------------
-------- MUX for DATA Memory ---------
RmemAddr <= F1_out when TBactive='1' else DTCM_tb_addr_out ; 
WmemAddr <= F2_out when TBactive='1' else DTCM_tb_addr_in ; 
WmemData <= BUS_B when TBactive='1' else DTCM_tb_in ; 
DmemEn <= DTCM_wr when TBactive='1' else DTCM_tb_wr ; 
-------Data memory ----------
Data_mem_1: dataMem generic map(Dwidth,Awidth,dept)port map(clk,DmemEn,WmemData,WmemAddr,RmemAddr,DM_out);
DTCM_tb_out <= DM_out;


with ALUFN(3 downto 0) select
	Cflag <= C_flag when "0000",
		 C_flag when "0001",
		 unaffected When others;
	
with ALUFN(3 downto 0) select
	Nflag <= N_flag when "0000",--add
		 N_flag when "0001",--sub
		 N_flag when "0010",--and
		 N_flag when "0011",--or
		 N_flag when "0100",--xor
		 unaffected When others;

end Data;