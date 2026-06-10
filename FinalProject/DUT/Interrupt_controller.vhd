LIBRARY ieee;
USE ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Interrupt_Controller IS
  GENERIC (n : INTEGER := 32);
  PORT 
  ( MCLK_i                               	 :IN STD_LOGIC;
	INTA								 	 :IN STD_LOGIC;
	GIE										 :IN STD_LOGIC;
	irq										 :IN STD_LOGIC_VECTOR (6 DOWNTO 0);
	RST										 :IN STD_LOGIC;
	mem_Write,mem_Read						 :IN STD_LOGIC;
	CS 										 :IN STD_LOGIC;
	FIROUT, FIFOEMPTY						 :IN STD_LOGIC;
	DATA_BUS								 :INOUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	ADDRESS_BUS							  	 :IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	INTR								 	 :OUT STD_LOGIC	 
  );
  
END Interrupt_Controller;

ARCHITECTURE Interrupt_Controller_behave OF Interrupt_Controller IS 
SIGNAL irq_w, irq_clr			:STD_LOGIC_VECTOR (6 DOWNTO 0):= (others => '0');
SIGNAL IE_R, TYPE_R, IFG_R		:STD_LOGIC_VECTOR (7 DOWNTO 0);
--SIGNAL GIE 						:STD_LOGIC:= '0';

BEGIN

PROCESS(MCLK_i,RST)
BEGIN
	IF (RST = '1') then 
		irq_clr <= (others => '1');
		IE_R 	<= (others => '0');
		--TYPE_R  <= (others => '0');
	ELSIF (rising_edge(MCLK_i)) THEN 
		IF (CS = '1' AND mem_Write = '1' AND ADDRESS_BUS = X"0") THEN
			IE_R <= DATA_BUS(7 DOWNTO 0);
		ELSIF (CS = '1' AND mem_Write = '1' AND ADDRESS_BUS = X"1") THEN
			irq_clr <= not (IFG_R(6 downto 0));
		-- ELSIF (mem_Read ='1') AND () then 
			
		-- ELSIF (INTA = '0' AND (TYPE_R = X"04" or TYPE_R = X"08")) THEN
			-- irq_clr(0) <= '1';		
		-- ELSIF (INTA = '0' AND TYPE_R = X"0C") THEN
			-- irq_clr(1) <= '1';
		ELSIF (INTA = '0' AND TYPE_R = X"10") THEN --basic Timer
			irq_clr(2) <= '1';
		ELSIF (INTA = '0' AND TYPE_R = X"14") THEN
			irq_clr(3) <= '1';			
		ELSIF (INTA = '0' AND TYPE_R = X"18") THEN
			irq_clr(4) <= '1';
		ELSIF (INTA = '0' AND TYPE_R = X"1C") THEN
			irq_clr(5) <= '1';			
		ELSIF (INTA = '0' AND (TYPE_R = X"20" or TYPE_R = X"24")) THEN --FIR
			irq_clr(6) <= '1';
		ELSE
			irq_clr <= (OTHERS => '0');
		END IF;	
		
	END IF;
END PROCESS;		



-- irq_clr(2) <= '1' WHEN INTA = '0' AND TYPE_R = X"10" ELSE '0';
-- irq_clr(3) <= '1' WHEN INTA = '0' AND TYPE_R = X"14" ELSE '0';
-- irq_clr(4) <= '1' WHEN INTA = '0' AND TYPE_R = X"18" ELSE '0';
-- irq_clr(5) <= '1' WHEN INTA = '0' AND TYPE_R = X"1C" ELSE '0';





LATCH_w : FOR i IN 6 DOWNTO 0 GENERATE
	latch_ports:D_latch port map (D => '1',EN => irq(i),CLR => irq_clr(i),Q => irq_w(i));
END GENERATE;



-- IE_R <= DATA_BUS(7 DOWNTO 0) WHEN (CS = '1' AND mem_Write = '1' AND ADDRESS_BUS = X"0") ELSE 
		-- unaffected;


--Upadate IFG if there is an intrrupt request or write to IFG in case of mem write
IFG_R <= DATA_BUS(7 downto 0) when mem_Write = '1' and CS = '1' and ADDRESS_BUS = X"1" else
	'0' & (irq_w and IE_R(6 downto 0));

	
--Update TYPE when there is interrupt request according to priority
TYPE_R <= X"04"	when  IFG_R(0) = '1' ELSE
		  --X"08"	when  IFG_R(0) = '1' ELSE
		  X"0C"	when  IFG_R(1) = '1' ELSE
		  X"10"	when  IFG_R(2) = '1' ELSE
		  X"14"	when  IFG_R(3) = '1' ELSE
		  X"18"	when  IFG_R(4) = '1' ELSE
		  X"1C"	when  IFG_R(5) = '1' ELSE
		  X"20"	when  IFG_R(6) = '1' and FIFOEMPTY = '1' ELSE
		  X"24"	when  IFG_R(6) = '1' and FIROUT = '1' ELSE
		  DATA_BUS(7 downto 0) when CS = '1' and mem_Write = '1' and ADDRESS_BUS = X"2" ELSE
		  unaffected;



-- Update data bus when CPU ask to read	
DATA_BUS <= X"000000" & IE_R when mem_Read = '1' and CS = '1' and ADDRESS_BUS = X"0" ELSE
			X"000000" & IFG_R when mem_Read = '1' and CS = '1' and ADDRESS_BUS = X"1" ELSE
			X"000000" & TYPE_R when (mem_Read = '1' and CS = '1' and ADDRESS_BUS = X"2") or (INTA = '0') ELSE 
			(OTHERS => 'Z');

--Check if there is an intrrupt in the IFG register and global enable - then send INTR
INTR <= '1' when (RST = '1' or ((IFG_R /=  X"00" and GIE = '1'))) else '0';


END Interrupt_Controller_behave;