LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY GPIO IS
  --constant PWM_width : INTEGER := 16;
  --constant ALU_width : INTEGER := 8;
  --constant k : integer := 3;   -- k=log2(n)
  --constant m : integer := 4;
  PORT(  
    SW0_9: IN STD_LOGIC_VECTOR(9 downto 0);
	KEY0_3: IN STD_LOGIC_VECTOR(3 downto 0);
	CLK_50Mhz: IN STD_LOGIC;
	LEDR0,LEDR1,LEDR2,LEDR3: OUT STD_LOGIC;
	LEDR5_9: OUT STD_LOGIC_VECTOR(4 downto 0);
	HEX4: OUT STD_LOGIC_VECTOR(6 downto 0);
	HEX5: OUT STD_LOGIC_VECTOR(6 downto 0);
	HEX2: OUT STD_LOGIC_VECTOR(6 downto 0);
	HEX3: OUT STD_LOGIC_VECTOR(6 downto 0);
	HEX1: OUT STD_LOGIC_VECTOR(6 downto 0);
	HEX0: OUT STD_LOGIC_VECTOR(6 downto 0);
	PWM_out : OUT STD_LOGIC
  );
END GPIO;

ARCHITECTURE GPIO_behave OF GPIO IS 
--SIGNAL SW0,SW1,SW2,SW3,SW4,SW5,SW6,SW7,SW8,SW9: STD_LOGIC;
SIGNAL SW8,SW9: STD_LOGIC:='0';
SIGNAL SW0_7: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL KEY0,KEY1,KEY2,KEY3: STD_LOGIC:='0';
--SIGNAL LEDR0,LEDR1,LEDR2,LEDR3,LEDR4,LEDR5,LEDR6,LEDR7,LEDR8,LEDR9: STD_LOGIC;
SIGNAL CLK_2Mhz: STD_LOGIC;
SIGNAL Y,X : STD_LOGIC_VECTOR (15 downto 0);
SIGNAL Y_LOW_8BIT, X_LOW_8BIT, Y_HIGH_8BIT, X_HIGH_8BIT: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL ALUFN : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL ALU_out:STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL HEX2_3: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL HEX0_1: STD_LOGIC_VECTOR(7 downto 0);

begin

----------------------------Ports conections----------------------------------------------------
Digital_System_unit: Digital_System generic map(16,8,3,4) port map(CLK_2Mhz,SW8,KEY3,Y,X,ALUFN,LEDR3,LEDR0,LEDR1,LEDR2,ALU_out,PWM_out);
PLL_unit: PLL port map (
		inclk0 => CLK_50Mhz,
		c0 => CLK_2Mhz);
		
Decoder_Hex5: Decoder port map (ALU_out(7 downto 4), HEX5); 
Decoder_Hex4: Decoder port map (ALU_out(3 downto 0), HEX4); 
Decoder_Hex3: Decoder port map (HEX2_3(7 downto 4), HEX3); 
Decoder_Hex2: Decoder port map (HEX2_3(3 downto 0), HEX2); 
Decoder_Hex1: Decoder port map (HEX0_1(7 downto 4), HEX1); 
Decoder_Hex0: Decoder port map (HEX0_1(3 downto 0), HEX0); 

----------------------------------------------------------------------------
SW0_7 <= SW0_9(7 downto 0);-- 8 BITs To X and Y and ALUFN
SW8 <= SW0_9(8);-- Enable
SW9 <= SW0_9(9);-- '1' - High 8 bit, '0' - LOW 8 bit


KEY0 <= KEY0_3(0); -- '1' - input for Y
KEY1 <= KEY0_3(1); -- '1' - input for X
KEY2 <= KEY0_3(2); -- Enable ALUFN
KEY3 <= KEY0_3(3); -- rst


LEDR5_9 <= ALUFN;

---------------------------Define entries X and Y--------------------------------------
with (not(KEY0) and not(SW9)) select
	Y_LOW_8BIT <= SW0_7 when '1',
	unaffected when others;

with (not(KEY0) and SW9) select
	Y_HIGH_8BIT <= SW0_7 when '1',
	unaffected when others;
	
with (not(KEY1) and not(SW9)) select
	X_LOW_8BIT <= SW0_7 when '1',
	unaffected when others;
	
with (not(KEY1) and SW9) select
	X_HIGH_8BIT <= SW0_7 when '1',
	unaffected when others;








-- process(KEY0, KEY1, SW0_7, SW9)
-- begin
	-- if (not(KEY0) and not(SW9)) = '1' then
		-- Y_LOW_8BIT <= SW0_7; -- Y LOW 8 bit
		
	-- elsif (not(KEY0) and SW9)= '1' then
		-- Y_HIGH_8BIT <= SW0_7; -- Y High 8 bit

	-- end if;
		
	-- if (KEY1 and not(SW9)) = '1' then
		-- X_LOW_8BIT <= SW0_7; -- X LOW 8 bit
		
	-- elsif (KEY1 and SW9) = '1' then
		-- X_HIGH_8BIT <= SW0_7; -- X High 8 bit

	-- end if;
-- end process;

Y <= Y_HIGH_8BIT & Y_LOW_8BIT;
X <= X_HIGH_8BIT & X_LOW_8BIT;

---------------------------Define HEX for X and Y--------------------------------------
with sw9 select
	HEX2_3 <= Y_LOW_8BIT when '0',
			Y_HIGH_8BIT when '1',
	unaffected when others;

with sw9 select
	HEX0_1 <= X_LOW_8BIT when '0',
			X_HIGH_8BIT when '1',
	unaffected when others;
	
----------------------------Define entries ALUFN------------------------------------
process(KEY2, SW0_7)
begin
	if KEY2 = '0' then
		ALUFN <= SW0_7(4 downto 0);
	end if;
end process;



END GPIO_behave;

