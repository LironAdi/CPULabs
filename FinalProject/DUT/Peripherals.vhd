LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--USE ieee.numeric_std.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Peripherals IS
  GENERIC (n : INTEGER := 32);
  PORT 
  ( MCLK_i                               	 :IN STD_LOGIC;
	INTA								 	 :IN STD_LOGIC;
	GIE										 :IN STD_LOGIC;
	irq										 :IN STD_LOGIC_VECTOR (5 DOWNTO 0);
	--Port_KEYS								 :IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	RST										 :IN STD_LOGIC;
	mem_Write,mem_Read						 :IN STD_LOGIC;
	FIRCLK									 :IN STD_LOGIC;						
	DATA_BUS								 :INOUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	ADDRESS_BUS							  	 :IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	INTR								 	 :OUT STD_LOGIC;
	PWM_out									 :OUT STD_LOGIC	 
	
  );
END Peripherals;


ARCHITECTURE Peripherals_behave OF Peripherals IS 
SIGNAL CS_interrupt :STD_LOGIC:= '0';
SIGNAL INTR_w :STD_LOGIC;
SIGNAL CS :STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL BTHOLD_w,BTCLR_w,BTOUTMD_w,BTOUTEN_w :STD_LOGIC:= '0';
SIGNAL FIFOEMPTY_w, FIRIFG :STD_LOGIC:= '0';
SIGNAL BTIPx_w,BTSSELx_w :STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL BTIFG_o,FIR_IFG	: STD_LOGIC:= '0';
SIGNAL irq_Interrupt:STD_LOGIC_VECTOR (6 DOWNTO 0);
SIGNAL BTCTL_w, FIRCTL_w, COEF3_0_w, COEF7_4_w, UTCL_w, RXBF_w :STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL FIROUT_w, FIRIN_w, BTCCR0_w,BTCCR1_w,BTCNT_w : STD_LOGIC_VECTOR (n-1 DOWNTO 0):= (others=> '0');
BEGIN
IC_ports:Interrupt_Controller generic map(n) Port map (MCLK_i,INTA,GIE,irq_Interrupt,RST,mem_Write,mem_Read,CS_interrupt,FIRIFG,
														FIFOEMPTY_w,DATA_BUS,ADDRESS_BUS(3 downto 0),INTR_w);
BT_Ports:Basic_Timer generic map(n) port map (MCLK_i,BTHOLD_w,BTCLR_w,BTOUTMD_w,BTOUTEN_w,BTCCR0_w,BTCCR1_w,BTIPx_w,BTSSELx_w,
														BTCNT_w,BTIFG_o,PWM_out);
FIR_Ports:FIR GENERIC map(n,24,8,8,24,8,3) port map(rst, FIRCLK,MCLK_i,FIFOEMPTY_w,FIRIFG, DATA_BUS, ADDRESS_BUS(11 downto 0), mem_Write, mem_Read); 

--chip select
With ADDRESS_BUS(11 DOWNTO 4) select
CS <= "0001" WHEN X"84", -- Interrupt (IE, IFG, TYPE)
	  "0010" WHEN X"83", -- FIR (FIRIN, FIROUT, COEF3_0, COEF7_4)
	  "0100" WHEN X"82", -- FIR (FIRCTL) , BT(BTCNT, BTCCR0, BTCCR1)
	  "1000" WHEN X"81", -- UART (UTCL, RXBF, TXBF) , BT(BTCTL) , PORT_KEY(KEY1, KEY2, KEY3)
	  "0000" WHEN OTHERS;
	  
CS_interrupt <= '1' When CS(0) = '1' or (INTR_w = '1' and INTA = '0') ELSE
				'0'; 
irq_Interrupt <= FIR_IFG & irq(5 downto 3) & BTIFG_o & irq(1 downto 0);
INTR <= INTR_w;

FIR_IFG <= FIFOEMPTY_w or FIRIFG;
-- BTCTL REGISTER 
BTHOLD_w <= BTCTL_w(5);	  
BTCLR_w	<= BTCTL_w(2);  
BTOUTMD_w <= BTCTL_w(7);
BTOUTEN_w <= BTCTL_w(6);
BTIPx_w <= BTCTL_w(1 downto 0);
BTSSELx_w <= BTCTL_w(4 downto 3);



process(MCLK_i)
BEGIN
	IF rising_edge(MCLK_i) then 
		IF mem_Write = '1' then 
			If ADDRESS_BUS(3 DOWNTO 0) = X"C" AND CS(3)='1' then 
				BTCTL_w <= DATA_BUS(7 downto 0);
			-- ELSIF ADDRESS_BUS(3 DOWNTO 0) = X"0" AND CS(2)='1' then 
				-- BTCNT_w <= DATA_BUS(7 downto 0);
			ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"4" AND CS(2)='1' then 
				BTCCR0_w <= DATA_BUS;
			ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"8" AND CS(2)='1' then 
				BTCCR1_w <= DATA_BUS;
			-- ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"C" AND CS(2)='1' then 
				-- FIRCTL_w <= DATA_BUS(7 downto 0);
			-- ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"0" AND CS(2)='1' then 
				-- FIRIN_w <= DATA_BUS;
			-- ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"8" AND CS(1)='1' then 
				-- COEF3_0_w <= DATA_BUS(7 downto 0);
			-- ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"C" AND CS(1)='1' then 
				-- COEF7_4_w <= DATA_BUS(7 downto 0);
			-- ELSIF ADDRESS_BUS(3 DOWNTO 0)  = X"8" AND CS(3)='1' then 
				-- UTCL_w <= DATA_BUS(7 downto 0);			
			END IF;
		END IF;
	END IF;
END PROCESS;


PROCESS(mem_read, ADDRESS_BUS, CS, FIRCTL_w, FIROUT_w, RXBF_w)
begin
	if mem_read = '1' then
		-- if ADDRESS_BUS(3 DOWNTO 0)  = X"4" and CS(1) = '1' then
		  -- DATA_BUS <= FIROUT_w;
		-- elsif ADDRESS_BUS(3 DOWNTO 0)  = X"C" and CS(2) = '1' then
		  -- DATA_BUS <= X"000000" & FIRCTL_w;
		if ADDRESS_BUS(3 DOWNTO 0)  = X"0" and CS(2) = '1' then
		  DATA_BUS <= BTCNT_w;
		elsif ADDRESS_BUS(3 DOWNTO 0)  = X"9" and CS(3) = '1' then
		  DATA_BUS <= X"000000" & RXBF_w;
		else
			DATA_BUS <= (others => 'Z'); 
		end if;
	else
		DATA_BUS <= (others => 'Z'); 
	end if;	  
END PROCESS;

END Peripherals_behave;