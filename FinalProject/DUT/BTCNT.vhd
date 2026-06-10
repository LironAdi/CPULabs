LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------
ENTITY BTCNT IS
  GENERIC (n : INTEGER := 32);
  PORT (    EN_i, CLK_i, BTCLR_i, HEU0_i   :IN STD_LOGIC;
            Q24_o, Q28_o, Q32_o 		   :OUT STD_LOGIC;
            Count_o 				       :OUT STD_LOGIC_VECTOR (n-1 downto 0)
		);
END BTCNT;

ARCHITECTURE BTCNT_behave OF BTCNT IS 

signal count : STD_LOGIC_VECTOR (n-1 downto 0):=(others=> '0');

begin
	process (CLK_i,BTCLR_i,HEU0_i)
	begin
		if (rising_edge(CLK_i)) then 
			if EN_i = '0' then
				count <= count + 1;
			end if;
			if HEU0_i = '1' or BTCLR_i = '1' then 
				count <= (others=> '0');
			end if;
		end if;
	end process;
	Q24_o <= count(23);
	Q28_o <= count(27);
	Q32_o <= count(31);
	Count_o <= count(n-1 downto 0);
	
	
END BTCNT_behave;