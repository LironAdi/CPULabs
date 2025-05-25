library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

--------------------------------------------------------------------------------------------

entity PCunit is 
generic( PCsel_width: integer:=2;
			Awidth: integer:=6;
			offsetwidth: integer:=8);
	port( clk: in std_logic;
		PCin: in std_logic;
		PCsel: in std_logic_vector(PCsel_width-1 downto 0);
		offsetAddr: in std_logic_vector(offsetwidth-1 downto 0);
		ReadAddr : out std_logic_vector(Awidth-1 downto 0)
	);
end PCunit;

architecture PCunit_behav of PCunit is
signal PC: std_logic_vector(Awidth-1 downto 0);
signal PC_offset: std_logic_vector(Awidth-1 downto 0);
signal incPC: std_logic_vector(Awidth-1 downto 0);
signal toPC: std_logic_vector(Awidth-1 downto 0);
BEGIN



incPC <= PC + 1;
PC_offset <= PC + 1 + offsetAddr(Awidth-1 downto 0); -- to check


---------MUX PC----------------------------
	with PCsel(1 downto 0) select 
		toPC <=(others=>'0') when "00", -- reset
					PC_offset(Awidth-1 downto 0) when "01", -- PC offset
					incPC when "10", -- PC+1
					 unaffected When others;


--------------------------------------------
	PC_init:process(clk)
	begin
		if(PCin='1' and clk'event and clk='1') then 
			PC<=toPC;
		else
			PC <= PC;
		end if;
	end process;

	ReadAddr<=PC;

end PCunit_behav;
