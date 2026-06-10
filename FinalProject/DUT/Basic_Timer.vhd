LIBRARY ieee;
USE ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Basic_Timer IS
  GENERIC (n : INTEGER := 32);
  PORT 
  ( MCLK_i                               :IN STD_LOGIC;
	BTHOLD_i, BTCLR_i 	                 :IN STD_LOGIC;
	BTOUTMD_i, BTOUTEN_i 			 	 :IN STD_LOGIC;
	BTCCR0_i, BTCCR1_i 				 	 :IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	BTIPx_i, BTSSELx_i 		 	         :IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	BTCNT_IO							 :OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	BTIFG_o						 	     :OUT STD_LOGIC;
	PWM_out								 :OUT STD_LOGIC	 
  );
  
END Basic_Timer;

ARCHITECTURE Basic_Timer_behave OF Basic_Timer IS 
SIGNAL CLK_w :STD_LOGIC;
SIGNAL HEU0_w :STD_LOGIC;
SIGNAL Q24_w, Q28_w, Q32_w :STD_LOGIC;
SIGNAL BTCCR0_w, BTCCR1_w :STD_LOGIC_VECTOR (n-1 DOWNTO 0):= (others => '0');
signal BTCNT_w : STD_LOGIC_VECTOR(n-1 downto 0);
SIGNAL div_count :STD_LOGIC_VECTOR (2 DOWNTO 0):= (others => '0');
SIGNAL clk_div2, clk_div4, clk_div8 :STD_LOGIC:= '0';
SIGNAL BTCLK :STD_LOGIC:= '0';

--signal temp_PWM_out : STD_LOGIC:='0';
begin
Counter: BTCNT GENERIC map (n) port map (BTHOLD_i, CLK_w, BTCLR_i, HEU0_w, Q24_w, Q28_w, Q32_w, BTCNT_w);
OutputUnit: Output_Unit GENERIC map (n) port map (CLK_w, BTOUTEN_i, BTOUTMD_i, BTCCR0_i, BTCCR1_i, BTCNT_w, HEU0_w, PWM_out);


-- BTIFG output selection
BTIFG_o <= HEU0_w when BTIPx_i = "00" else
		   Q24_w when  BTIPx_i = "01" else
		   Q28_w when  BTIPx_i = "01" else
		   Q32_w;


-- Latch BTCCR
process(MCLK_i)
begin
  if rising_edge(MCLK_i) then
    if BTCNT_w = std_logic_vector(to_unsigned(0, n)) then
      BTCCR0_w <= BTCCR0_i;
      BTCCR1_w <= BTCCR1_i;
    end if;
  end if;
end process;


-- Clock divider from MCLK
process(MCLK_i, BTSSELx_i)
	begin
		if rising_edge(MCLK_i) then
		  div_count <= std_logic_vector(unsigned(div_count) + 1);
		end if;
end process;

clk_div2 <= div_count(0); -- toggles every 2 MCLKs
clk_div4 <= div_count(1); -- toggles every 4 MCLKs
clk_div8 <= div_count(2); -- toggles every 8 MCLKs

-- Select clock based on BTSSELx

with BTSSELx_i select
BTCLK <=   MCLK_i     when "00",
		   clk_div2   when "01",
		   clk_div4   when "10",
		   clk_div8   when "11",
		   MCLK_i     when others;
	
CLK_w <= BTCLK;
BTCNT_IO <= BTCNT_w;

END Basic_Timer_behave;