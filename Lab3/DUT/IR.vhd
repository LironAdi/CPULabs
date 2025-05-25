library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

--------------------------------------------------------------------------------------------

entity IR is 
generic( RFaddr_width: integer:=2;
			IRwidth: integer:=16;
			Reg_width: integer:=4;
			imm4_width: integer:=4;
			imm8_width: integer:=8
			);
	port(IRin: in std_logic;
		R_RFaddr: in std_logic_vector(RFaddr_width-1 downto 0);
		W_RFaddr: in std_logic_vector(RFaddr_width-1 downto 0);
		dataOut: in std_logic_vector(IRwidth-1 downto 0);
		writeAddr: out std_logic_vector(Reg_width-1 downto 0);
		readAddr: out std_logic_vector(Reg_width-1 downto 0);
		OPC_o: out std_logic_vector(Reg_width-1 downto 0);
		imm4_o: out std_logic_vector(imm4_width-1 downto 0);
		imm8_o: out std_logic_vector(imm8_width-1 downto 0)
	);
end IR;


architecture IR_behav of IR is

signal IRval:          std_logic_vector(IRwidth-1 downto 0);
alias rc is IRval      (Reg_width-1 downto 0);
alias rb is IRval      (2*Reg_width-1 downto Reg_width);
alias ra is IRval      (3*Reg_width-1 downto 2*Reg_width);
alias opc is IRval      (4*Reg_width-1 downto 3*Reg_width);
alias imm4 is IRval      (Reg_width-1 downto 0);
alias imm8 is IRval      (2*Reg_width-1 downto 0);


BEGIN
	 IRval <= dataOut when (IRin= '1')
	else
		unaffected ;

	with R_RFaddr(1 downto 0) select 
		readAddr <= rc when "00", 
						rb when "01", 
						ra when "10", 
						unaffected When others;
	with W_RFaddr(1 downto 0) select 
		writeAddr <= rc when "00", 
						rb when "01", 
						ra when "10", 
						unaffected When others;					
	imm4_o <= imm4;
	imm8_o <= imm8;
	OPC_o <= opc;	


end IR_behav;
