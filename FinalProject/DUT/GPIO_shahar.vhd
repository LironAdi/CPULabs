				-- GPIO - SHAHAR AND LIRON ------
				
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY work;
USE work.aux_package.all;


ENTITY GPIO IS

	PORT(  clock,reset       			 : IN 	 STD_LOGIC;
		   memRead,	memWrite 			 : IN 	 STD_LOGIC;
		   Address_in					 : IN 	 STD_LOGIC_VECTOR(15 DOWNTO 0);
		   SW   			 			 : IN 	 STD_LOGIC_VECTOR(7 DOWNTO 0);
		   Data		         			 : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		   Leds							 : OUT 	 STD_LOGIC_VECTOR(7 DOWNTO 0);
		   Hex0,Hex1,Hex2,Hex3,Hex4,Hex5 : OUT 	 STD_LOGIC_VECTOR(6 DOWNTO 0)
		   );
END 	GPIO;

ARCHITECTURE behavior OF GPIO IS
	SIGNAL	CS											: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	Data_7odwnto0								: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL	Leds_O							 			: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL	Hex0_O,Hex1_O,Hex2_O,Hex3_O,Hex4_O,Hex5_O	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL 	EN_HEX0, EN_HEX1, EN_HEX2, EN_HEX3, EN_HEX4, EN_HEX5, EN_LD		: STD_LOGIC;
	--signal	Address		       							 :STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal  en_sw										:STD_LOGIC;
	signal	Address		       							 :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL	data_out									:STD_LOGIC_VECTOR(31 downto 0);
	signal	data_in										:STD_LOGIC_VECTOR(31 downto 0);
	
alias A0  is Address_in(0);



BEGIN
	--Address <= Address_in(11) & Address_in(5 DOWNTO 2) ;
	Address <= Address_in(11 DOWNTO 1) ;
	
	data_out(31 DOWNTO 8) <= (OTHERS => '0');
	data_out(7 DOWNTO 0)   <= SW;		
	

	WITH address SELECT
		CS <= "0000001" WHEN "10000000000",		--CS(0) 0x800		      LEDR		
			"0000010" WHEN 	 "10000000010",		--CS(1) 0x804 or 0x805    HEX0/1		
			"0000100" WHEN 	 "10000000100",		--CS(2) 0x808 or 0x809    HEX2/3	
			"0001000" WHEN 	 "10000000110",		--CS(3) 0x80C or 0x80D    HEX4/5	 
			"0010000" WHEN 	 "10000001000",		--CS(4) 0x810		      SW	
			--"0100000" WHEN "10101",
			--"1000000" WHEN "10110",
			"0000000" WHEN OTHERS;
			
			
	---ENABALING----
	

	EN_HEX0 <= '1' WHEN ( memWrite = '1' AND (A0='0' AND CS(1)='1') ) ELSE '0' ; 
	EN_HEX1 <= '1' WHEN ( memWrite = '1' AND (A0='1' AND CS(1)='1') ) ELSE '0' ;	

	EN_HEX2 <= '1' WHEN ( memWrite = '1' AND (A0='0' AND CS(2)='1') ) ELSE '0' ;	
	EN_HEX3 <= '1' WHEN ( memWrite = '1' AND (A0='1' AND CS(2)='1') ) ELSE '0' ;
	
	EN_HEX4 <= '1' WHEN ( memWrite = '1' AND (A0='0' AND CS(3)='1') ) ELSE '0' ;
	EN_HEX5 <= '1' WHEN ( memWrite = '1' AND (A0='1' AND CS(3)='1') ) ELSE '0' ;
	
	EN_LD	<= '1' WHEN (CS(0)='1' AND memWrite='1') ELSE '0' ; 
	en_sw <= '1' when (CS(4)='1' and memRead='1') else '0';	

	--Data <= (others => 'Z');
	port_sw: BidirPin generic map(width => 32) port map(Dout => data_out,
	en => en_sw , Din => data_in , IOpin => Data);

	
	GPIO_process:process(reset,clock)
		BEGIN
			IF (reset = '1')THEN
					Leds_O<=(others=>'0');
					Hex0_O<=(others=>'0');
					Hex1_O<=(others=>'0');
					Hex2_O<=(others=>'0');
					Hex3_O<=(others=>'0');
					Hex4_O<=(others=>'0');
					Hex5_O<=(others=>'0');		
					
			ELSIF (clock'EVENT  AND clock = '1' )THEN

					
				IF (EN_LD='1') THEN 
					Leds_O <= Data_in(7 DOWNTO 0);				
					
				ELSIF (EN_HEX0='1') THEN 
					Hex0_O <= Data_in(3 DOWNTO 0); 
					
				ELSIF (EN_HEX1='1') THEN 
					Hex1_O <= Data_in(7 DOWNTO 4);
					
				ELSIF (EN_HEX2='1') THEN 
					Hex2_O <= Data_in(3 DOWNTO 0);
					
				ELSIF (EN_HEX3='1') THEN 
					Hex3_O <= Data_in(7 DOWNTO 4);
					
				ELSIF (EN_HEX4='1') THEN 
					Hex4_O <= Data_in(3 DOWNTO 0);
					
				ELSIF (EN_HEX5='1') THEN 
					Hex5_O <= Data_in(7 DOWNTO 4);

					
				END IF;
			END IF;
	END process;
-- Leds_O <= Data_in(7 DOWNTO 0) WHEN EN_LD ='1' ELSE (others=>'0');
-- Hex0_O <= Data_in(3 DOWNTO 0) WHEN EN_HEX0='1' ELSE (others=>'0');
-- Hex1_O <= Data_in(7 DOWNTO 4) WHEN EN_HEX1='1' ELSE (others=>'0');
-- Hex2_O <= Data_in(3 DOWNTO 0) WHEN EN_HEX2='1' ELSE (others=>'0');
-- Hex3_O <= Data_in(7 DOWNTO 4) WHEN EN_HEX3='1' ELSE (others=>'0');
-- Hex4_O <= Data_in(3 DOWNTO 0) WHEN EN_HEX4='1' ELSE (others=>'0');
-- Hex5_O <= Data_in(7 DOWNTO 4) WHEN EN_HEX5='1' ELSE (others=>'0');


Decoder_Hex5: Decoder port map (Hex5_O, Hex5); 
Decoder_Hex4: Decoder port map (Hex4_O, Hex4); 
Decoder_Hex3: Decoder port map (Hex3_O, Hex3); 
Decoder_Hex2: Decoder port map (Hex2_O, Hex2); 
Decoder_Hex1: Decoder port map (Hex1_O, Hex1); 
Decoder_Hex0: Decoder port map (Hex0_O, Hex0); 

--update out signals 

 --Data <= Data_7odwnto0	;
 Leds <= Leds_O;





END behavior;
