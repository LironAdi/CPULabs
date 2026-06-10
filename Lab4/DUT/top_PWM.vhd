LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top_PWM IS
  GENERIC (n : INTEGER := 16);
  PORT 
  (  clk, en, rst: IN STD_LOGIC;
		Y,X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  PWM_out: OUT STD_LOGIC
  );
END top_PWM;


ARCHITECTURE top_PWM_behave OF top_PWM IS 
signal en_i : STD_LOGIC;
signal Y_i,X_i : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
--signal temp_PWM_out : STD_LOGIC:='0';
begin
PWM_ports: PWM GENERIC map (n) port map (clk, en_i, rst, Y_i, X_i, ALUFN_i(2 DOWNTO 0),PWM_out);
process(clk)
	begin
		if (rising_edge(clk)) then 
			if ALUFN_i(4 DOWNTO 3) = "00" then
				Y_i<=Y;
				X_i<=X;
				en_i<=en;
			else
				Y_i<=(others=> '0');
				X_i<=(others=> '0');
				en_i<='0';
				
			--PWM_out<=temp_PWM_out;	
			end if;
		end if;
end process;
END top_PWM_behave;

