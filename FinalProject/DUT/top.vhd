				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY work;
USE work.aux_package.all;
USE work.cond_comilation_package.all;

ENTITY top IS
	generic( 
	        MODELSIM : integer 			:= G_MODELSIM
	);
	PORT(  reset,CLK_50Mhz				 : IN 	STD_LOGIC; 
		   --ena						 	 : IN 	STD_LOGIC; 
		   SW   						 : IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
		   --RX,TX 					     : IN 	STD_LOGIC; 
		   Key1,Key2,Key3			     : IN 	STD_LOGIC; 
		   --FIR						     : IN 	STD_LOGIC;
		   Leds							 : OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0 );
		   Hex0,Hex1,Hex2,Hex3,Hex4,Hex5 : OUT 	STD_LOGIC_VECTOR(6 DOWNTO 0 );
		   PWM_out                  	 : OUT 	STD_LOGIC
		   );
END 	top;

ARCHITECTURE structure OF top IS
signal memRead,	memWrite,reset_local : STD_LOGIC;
signal Address_Bus       			 : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal Data_Bus          			 : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal set_TBIFG,GIE,INTA,INTR 		 : STD_LOGIC;	
signal irq							 : STD_LOGIC_VECTOR(5 DOWNTO 0):=(others=>'0');
signal CLK_2Mhz,reset_i				 : STD_LOGIC;
signal clk_20k						 : STD_LOGIC:= '0';
signal div_cnt 						 : integer range 0 to 1249 := 0; 
signal first_lower_clock,second_lower_clock,FIRCLK_w	: std_logic := '0';
BEGIN
reset_i <= not(reset);
--reset_i <= reset;
irq(0) <= '0';
irq(1) <= '0';
irq(3) <= '1' when not(Key1) = '1' else '0';
irq(4) <= '1' when not(Key2) = '1' else '0';
irq(5) <= '1' when not(Key3) = '1' else '0';
--irq(6) <= '0';

-- address_i <= ALU_Result_DM_w(11 downto 0);
-- ICaddress	   <= address_i(11) & address_i(6 DOWNTO 0);
-- GPIOaddress	   <= address_i(11) & address_i(6 DOWNTO 0);
-- INTRsrc(7)     <= Status_IFG;
-- INTRsrc(0) 	   <= RX_IFG;
-- INTRsrc(1) 	   <= TX_IFG;
-- INTRsrc(2)     <= BTIFG_w;
-- INTRsrc(3)	   <= (KEY1_INTR);
-- INTRsrc(4)	   <= (KEY2_INTR);
-- INTRsrc(5) 	   <= (KEY3_INTR);
-- INTRsrc(6)     <= FIFO_status_INTR;
-- INTRsrc(8)     <= FIRIFG_w;										  

	-- connect the PLL component
	G0:
	if (MODELSIM = 0) generate
	  MCLK: PLL
	  generic map( 
			clk0_multiply_by => 1,
	        clk0_divide_by=> 3
		)
		PORT MAP (
			
			inclk0 	=> CLK_50Mhz,
			c0 		=> CLK_2Mhz
		);
	else generate
		CLK_2Mhz <= CLK_50Mhz;
	end generate;
	
FIRCLK_w <= clk_20k when (G_MODELSIM = 1) else second_lower_clock;

PLL_lower_freq_Ports1: PLL_lower_freq
port map (
	areset => '0',
	inclk0 => CLK_50Mhz,  -- FPGA input cloc
	c0     => first_lower_clock,     -- lowering the clock to few MHz
	locked => open
);
PLL_lower_freq_Ports2: PLL_lower_freq
port map (
	areset => '0',
	inclk0 => first_lower_clock,  -- FPGA input cloc
	c0     => second_lower_clock,     -- ~44kHz out
	locked => open
);		


process (CLK_50Mhz)
begin
  if rising_edge(CLK_50Mhz) then
    if reset = '1' then
      div_cnt  <= 0;
      clk_20k  <= '0';
    elsif div_cnt = 1249 then
      div_cnt  <= 0;
      clk_20k  <= not clk_20k;
    else
      div_cnt  <= div_cnt + 1;
    end if;
  end if;
end process;	   
	
	-- PLL_unit: PLL port map (
		-- inclk0 => CLK_50Mhz,
		-- c0 => CLK_2Mhz);

	Mips_portmap:MIPS
	PORT MAP (	rst_i				=> reset_i,
				clk_i	    		=> CLK_2Mhz,
				INTR				=> INTR,
				INTA				=> INTA,
				GIE_o				=> GIE, 
				MemWrite_ctrl_o		=> memWrite,
				mem_read_o			=> memRead,
				ADDRESS_BUS			=> Address_Bus,			
				DATA_BUS			=> Data_Bus
			--	reset_local			=> reset_local
				
			
				--clr_req      => clr_req,
		
				);
	
	GPIO_portmap: GPIO
	PORT MAP (	clock        => CLK_2Mhz,	 
				reset        => reset_i,
				memRead		 =>memRead,
				memWrite	 =>memWrite,			
				Address_in	 =>Address_Bus(15 downto 0),       			 
				SW			 =>SW,   			 			 
				Data		 =>Data_Bus,        			 
				Leds		 =>Leds,							
				Hex0		 =>Hex0,
				Hex1		 =>Hex1,
				Hex2		 =>Hex2,
				Hex3		 =>Hex3,
				Hex4		 =>Hex4,
				Hex5		 =>Hex5
				);
				
	Peripherals_portmap: Peripherals
	PORT MAP (	MCLK_i 		=> CLK_2Mhz,
				INTA		=> INTA,
				GIE			=> GIE,
				irq			=> irq,
				RST			=> reset_i, 
				mem_Read 	=> memRead,
				mem_Write 	=> memWrite, 		
				ADDRESS_BUS => Address_Bus, 
				DATA_BUS	=> Data_Bus, 
				INTR		=> INTR,
				PWM_out		=> PWM_out,				 
				FIRCLK		=> FIRCLK_w				
				);
	
END structure;

