LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY PWM IS
  GENERIC (n : INTEGER := 16);
  PORT 
  (  clk, en, rst: IN STD_LOGIC;
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		  PWM_out: OUT STD_LOGIC
  );
END PWM;


ARCHITECTURE PWM_behave OF PWM IS 
Signal Mode0,Mode2:STD_LOGIC:= '0';
Signal Mode1:STD_LOGIC:= '1';
Signal EQUY: STD_LOGIC:= '0';
signal count : STD_LOGIC_VECTOR (n DOWNTO 0);


begin
Counter_ports : Counter generic map (n) port map (clk,en,rst,EQUY,count);

process(clk)
begin
	if rising_edge(clk) then
		--check if count + 1 or Y + 1
		if count + 1 = Y_i then
			EQUY <= '1';		
		else 
			EQUY <= '0';
		END IF;
	
	
		if X_i > Y_i then 
			Mode0<= '0';
			Mode1<= '0';
			Mode2<= '0';
		--END IF;
		elsif count = X_i then
			Mode2 <= not(Mode2);
			Mode0 <= '1';
			Mode1 <= '0';
		--END IF;
		elsif count = Y_i then
			Mode0 <= '0';
			Mode1 <= '1';
		END IF;
		
		

	end if;
end process;

with ALUFN_i select
	PWM_out <= Mode0 when "000",
		Mode1 when "001",
		Mode2 when "010",
		'0' When others;
	
	
	
	
	
END PWM_behave;