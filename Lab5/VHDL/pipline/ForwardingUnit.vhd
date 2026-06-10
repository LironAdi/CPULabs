LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;
USE ieee.numeric_std.ALL;
USE work.aux_package.all;


ENTITY  ForwardingUnit IS
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
END ForwardingUnit;


ARCHITECTURE structure OF ForwardingUnit IS
begin
ForwardingUnit:process(write_reg_addr_MEM,write_reg_addr_WB,rt_register_ID,RegWrite_MEM,rs_register_ID,rt_register_EX,rs_register_EX,RegWrite_WB)
begin
	
	----Forwarding of B in Decode stage
	if (write_reg_addr_MEM = rt_register_ID AND RegWrite_MEM = '1' AND write_reg_addr_MEM /= "00000") then
		ForwardB_ID <= '1';
	else
		ForwardB_ID <= '0';
	end if;

	----Forwarding of A in Decode stage
	if (write_reg_addr_MEM = rs_register_ID AND RegWrite_MEM = '1' AND write_reg_addr_MEM /= "00000") then
		ForwardA_ID <= '1';
	else
		ForwardA_ID <= '0';
	end if;


	----Forwarding of B in execute stage
	If (write_reg_addr_MEM = rt_register_EX AND (RegWrite_MEM = '1' or memwrite_EX = '1') AND write_reg_addr_MEM /= "00000") then
		ForwardB_EX <= "10"; --ALU result
	elsIf (RegWrite_WB = '1' AND write_reg_addr_WB /= "00000" AND rt_register_EX = write_reg_addr_WB) then 
		ForwardB_EX <= "01"; --Write data
	else 
		ForwardB_EX <= "00";
	end if;

	----Forwarding of A in execute stage
	If (write_reg_addr_MEM = rs_register_EX AND RegWrite_MEM = '1' AND write_reg_addr_MEM /= "00000") then
		ForwardA_EX <= "10"; --ALU result
	elsIf (RegWrite_WB = '1' AND write_reg_addr_WB /= "00000" AND rs_register_EX = write_reg_addr_WB) then 
		ForwardA_EX <= "01"; --Write data
	else 
		ForwardA_EX <= "00";
	end if;

end process;




END Structure;