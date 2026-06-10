LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Counter IS
  GENERIC (n : INTEGER := 16);
  PORT 
  (  clk, en, rst, EQUY: IN STD_LOGIC;
		count_o: out STD_LOGIC_VECTOR (n downto 0)
  );
END Counter;


ARCHITECTURE Counter_behave OF Counter IS 

signal count : STD_LOGIC_VECTOR (n downto 0):=(others=> '0');

begin
	process (clk,rst,EQUY)
	begin
		if (rising_edge(clk)) then 
			if en = '1' then
				count <= count + 1;
			end if;
			if EQUY = '1' or rst = '1' then 
				count <= (others=> '0');
			end if;
		end if;
	end process;
	count_o <= count(n downto 0);
	
	
END Counter_behave;