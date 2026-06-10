LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Digital_System IS
  GENERIC (PWM_width : INTEGER := 16;
			ALU_width : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	);
  PORT 
  (  clk, en, rst: IN STD_LOGIC;
		Y,X: IN STD_LOGIC_VECTOR (PWM_width-1 DOWNTO 0);
		  ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  V_flag,N_flag,C_flag,Z_flag: OUT STD_LOGIC;
		  ALU_out: OUT STD_LOGIC_VECTOR (ALU_width-1 DOWNTO 0);
		  PWM_out: OUT STD_LOGIC
  );
END Digital_System;

ARCHITECTURE Digital_System_behave OF Digital_System IS 
begin
top_pwm_unit: top_PWM generic map(PWM_width) port map (clk,en,rst,Y,X,ALUFN,PWM_out);
ALU_unit: ALU generic map(ALU_width,k,m) port map (clk,Y(ALU_width-1 DOWNTO 0),X(ALU_width-1 DOWNTO 0),ALUFN,ALU_out,N_flag,C_flag,Z_flag,V_flag);
END Digital_System_behave;

