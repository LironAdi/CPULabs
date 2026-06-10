LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY TB_Digital_System IS
  GENERIC (PWM_width : INTEGER := 16;
			ALU_width : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	);
  
END TB_Digital_System;

Architecture TB_Digital_System_behav of TB_Digital_System is
signal rst,clk,en: std_logic;
signal Y,X: STD_LOGIC_VECTOR (PWM_width-1 DOWNTO 0);
signal ALUFN : STD_LOGIC_VECTOR (4 DOWNTO 0);
signal ALU_out: STD_LOGIC_VECTOR (ALU_width-1 DOWNTO 0);
signal PWM_out:STD_LOGIC;
signal V_flag,N_flag,C_flag,Z_flag:STD_LOGIC;
begin 
Digital_System_ports: Digital_System GENERIC map (PWM_width,ALU_width,k,m) port map (clk, en, rst, Y, X, ALUFN,V_flag,N_flag,C_flag,Z_flag,ALU_out,PWM_out);


------------------------------------------clk simulation-----------------------------------------------------
gen_clk : process
	begin
	  clk <= '0';
	  wait for 20 ns;
	  clk <= not clk;
	  wait for 20 ns;
	end process;

------------------------------------------Rst simulation-----------------------------------------------------

genRST: process
        begin
		  rst <='1','0' after 100 ns;
		  wait;
        end process;	
		

PWM_TB:process
	begin
		en <= '1';
		X <= "0000000000000100";--4
		Y <= "0000000000100000";--32
		ALUFN(4 DOWNTO 3) <= "00";
		ALUFN(2 DOWNTO 0) <= "000";--mode0
		wait for 3000 ns;
		ALUFN(4 DOWNTO 3) <= "00";
		ALUFN(2 DOWNTO 0) <= "001";--mode1
		wait for 3000 ns;
		ALUFN(4 DOWNTO 3) <= "00";
		ALUFN(2 DOWNTO 0) <= "010";--mode2
		wait for 3000 ns;
		ALUFN(4 DOWNTO 3) <= "01";
		ALUFN(2 DOWNTO 0) <= "000";--add
		wait for 3000 ns;
		ALUFN(4 DOWNTO 3) <= "01";
		ALUFN(2 DOWNTO 0) <= "101";--swap
		wait for 3000 ns;
		X <= "0000000000000100";--4
		Y <= "0000000000000010";--2
		ALUFN(4 DOWNTO 3) <= "10";
		ALUFN(2 DOWNTO 0) <= "000";--shift left
		wait for 3000 ns;
		ALUFN(4 DOWNTO 3) <= "11";
		ALUFN(2 DOWNTO 0) <= "000";--not
		wait for 3000 ns;
		ALUFN(4 DOWNTO 3) <= "11";
		ALUFN(2 DOWNTO 0) <= "100";--nor
		wait;	
end process;

end TB_Digital_System_behav;