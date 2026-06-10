LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-------------------------------------
ENTITY Output_Unit IS
  GENERIC (n : INTEGER := 32);
  PORT 
  (  CLK_i, BTOUTEN_i, BTOUTMD_i	:IN STD_LOGIC;
	 BTCCR0_i, BTCCR1_i				:IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	 Count_i						:IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	 HEU0_o							:OUT STD_LOGIC;
	 PWM_out						:OUT STD_LOGIC
  );
END Output_Unit;


ARCHITECTURE Output_Unit_behave OF Output_Unit IS 


begin
process(CLK_i)
begin
	if rising_edge(CLK_i) then
		if unsigned(Count_i) + 1 = unsigned(BTCCR0_i) then
			HEU0_o <= '1';		
		else 
			HEU0_o <= '0';
		END IF;
		if BTOUTEN_i = '1' then
			if BTOUTMD_i = '0' then
				if Count_i = BTCCR0_i then
					PWM_out <= '0';
				elsif Count_i < BTCCR1_i then 
					PWM_out <= '0';
				elsif Count_i >= BTCCR1_i and Count_i < BTCCR0_i then
					PWM_out <= '1';
				END IF;
			elsif BTOUTMD_i = '1' then
				if Count_i = BTCCR0_i then
					PWM_out <= '1';
				elsif Count_i < BTCCR1_i then 
					PWM_out <= '1';
				elsif Count_i >= BTCCR1_i and Count_i < BTCCR0_i then
					PWM_out <= '0';
				END IF;
			END IF;
		else
			PWM_out <= '0';	
		END IF;	
	END IF;	
END PROCESS;			
	
END Output_Unit_behave;