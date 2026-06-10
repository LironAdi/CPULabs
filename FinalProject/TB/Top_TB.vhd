---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
--use ieee.std_logic_unsigned.all;
USE work.cond_comilation_package.all;
USE work.aux_package.all;


ENTITY top_tb IS
	generic( 
	        MODELSIM : integer 			:= G_MODELSIM
	);
END top_tb ;


ARCHITECTURE struct OF top_tb IS
   -- Internal signal declarations
   SIGNAL rst_tb_i           	: STD_LOGIC;
   SIGNAL clk_tb_i           	: STD_LOGIC;
   SIGNAL Key1,Key2,Key3		: STD_LOGIC;
   SIGNAL PWM_out			  	: STD_LOGIC;
   SIGNAL SW,Leds			 	: STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL Hex0,Hex1,Hex2,Hex3,Hex4,Hex5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
	CORE : Top
	PORT MAP (
		reset           	=> rst_tb_i,
		CLK_50Mhz           => clk_tb_i,
		SW					=> SW,	
		Key1				=> Key1,
		Key2              	=> Key2,
		Key3  				=> Key3,
		Leds 				=> Leds,
		Hex0        		=> Hex0,
		Hex1    			=> Hex1,
		Hex2		   		=> Hex2,
		Hex3				=> Hex3,
		Hex4				=> Hex4,
		Hex5                => Hex5,
		PWM_out				=> PWM_out
	);	
--------------------------------------------------------------------	
	gen_clk : 
	process
        begin
		  clk_tb_i <= '1';
		  wait for 50 ns;
		  clk_tb_i <= not clk_tb_i;
		  wait for 50 ns;
    end process;
	
	gen_rst : 
	process
        begin
		  rst_tb_i <='1','0' after 80 ns;
		  wait;
    end process;
	
	-- Stimulus process to simulate KEY1 press after 10 clock cycles
stim_proc : process
begin
	Key3 <= '1';
    wait for 5000 ns;
	SW <= "01001000"; 
    Key3 <= '0';  -- Press KEY1
    wait for 100 ns;
    Key3 <= '1';  -- Release KEY1
    -- wait for 1200 ns;
    -- Key2 <= '0';  -- Press KEY1
	-- Key1 <= '0';
    -- wait for 100 ns;
    -- Key2 <= '1';  -- Release KEY1
	-- Key1 <= '1';
    wait;
end process;

--------------------------------------------------------------------		
END struct;
