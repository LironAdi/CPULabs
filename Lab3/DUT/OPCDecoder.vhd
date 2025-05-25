library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

--------------------------------------------------------------------------------------------

entity OPCdec is 
	generic( OPCwidth: integer:=4
	);
	port( OPC: in std_logic_vector(OPCwidth-1 downto 0);
	 st,Id,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,jn: out std_logic
	);
end OPCdec;

architecture OPCdec_behav of OPCdec is
BEGIN
	  st <= '1' When (OPC = "1110") else '0';
	  Id <= '1' When (OPC = "1101") else '0';
	  mov <= '1' When (OPC = "1100") else '0';
	  done_signal <= '1' When (OPC = "1111") else '0';
	  add <= '1' When (OPC = "0000") else '0';
	  sub <= '1' When (OPC = "0001") else '0';
	  jmp <= '1' When (OPC = "0111") else '0';
	  jc <= '1' When (OPC = "1000") else '0';
	  jnc <= '1' When (OPC = "1001") else '0';
	  and_o <= '1' When (OPC = "0010") else '0';
	  or_o <= '1' When (OPC = "0011") else '0';
	  xor_o <= '1' When (OPC = "0100") else '0';
	  jn <= '1' when (OPC="1010") else '0';

end OPCdec_behav;
