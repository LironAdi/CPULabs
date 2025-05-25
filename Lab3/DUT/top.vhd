library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
--------------------------------------------------------------
entity top is
generic( Dwidth:		integer:=16;
		 Awidth:		integer:=4;
		 n:				integer:=16;
		 m:				integer:=16;
		 offsetwidth:	integer:=8;
		dept :	  		integer:=64;
		OPC_size: 		integer:=4;
		Reg_size: 		integer:=4;
		two: 			integer:=2;
		Alufn_size: 	integer:=4 
		 );
port(	rst, En, clk:				in std_logic; ----control unit + clk for datapath
		done: 						out std_logic; 
		--control:					in std_logic_vector;
		memEn: 						in std_logic;	
		ITCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0);
		ITCM_tb_addr_in:			in std_logic_vector(Awidth-1 downto 0);
		DTCM_tb_out: 				out std_logic_vector(Dwidth-1 downto 0); ------data_out <=> DM_out 
		TBactive: 					in std_logic;
		DTCM_tb_wr: 				in std_logic;
		DTCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0); 
		DTCM_tb_addr_in,DTCM_tb_addr_out: in std_logic_vector(Awidth-1 downto 0)	
);
end top;



--------------------------------------------------------------
architecture behav of top is
-----satus ports --------
signal st,ld,mov,done_signal,add,sub,jmp,
jc,jnc,and_o,or_o,xor_o,jn: 				std_logic; --status 12/15
signal Cflag, Zflag, Nflag:				std_logic; ---status 15/15
-----conrol ports---------
signal PCin:							std_logic;
signal PCsel:					 		std_logic_vector(1 downto 0);
signal IRin:							std_logic;
signal RFadder_rd, RFadder_wr:			std_logic_vector(1 downto 0);
signal RFin, RFout:						std_logic; 
signal Imm1_in, Imm2_in, DTCM_out:		std_logic; 
signal Ain:								std_logic;
signal ALUFN:							std_logic_vector(Alufn_size-1 downto 0);
signal DTCM_addr_sel:					std_logic; 
signal DTCM_addr_out,DTCM_addr_in:		std_logic;   
signal DTCM_wr:							std_logic;


begin
DataPath_port: datapath generic map(Dwidth,Awidth,offsetwidth,dept,OPC_size,Reg_size,two,Alufn_size)
port map(clk,rst,PCin,PCsel,memEn,ITCM_tb_in,ITCM_tb_addr_in,IRin,RFadder_rd, RFadder_wr,st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,jn,
	RFin, RFout,Imm1_in, Imm2_in, DTCM_out,Ain,ALUFN,Cflag, Zflag, Nflag,DTCM_addr_sel,DTCM_addr_out,DTCM_addr_in,
	DTCM_tb_out,DTCM_wr, TBactive,DTCM_tb_wr,DTCM_tb_in,DTCM_tb_addr_in,DTCM_tb_addr_out);
	

Control_ports: control generic map(Dwidth)port map(clk,rst,En,st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,
		xor_o,jn,Cflag,Zflag,Nflag,IRin,RFin,RFout,Imm1_in,Imm2_in,Ain,PCin,DTCM_out,DTCM_addr_sel,
		DTCM_addr_out,DTCM_addr_in,DTCM_wr,RFadder_rd,RFadder_wr,PCsel,ALUFN,done); 

end behav;

