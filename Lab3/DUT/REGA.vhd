library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-----------------------------------------------------------------
entity RegA is
	generic( Dwidth: integer:=16 );
	port(   clk,Ain:			in 		std_logic;
			D: 					in 		std_logic_vector(Dwidth-1 downto 0);
			Q:					out		std_logic_vector(Dwidth-1 downto 0)
			);
end RegA;

architecture op_REG_A of RegA is

begin 
	Q <= D when (rising_edge(clk) and Ain='1') 
			else 
				unaffected;

	
end op_REG_A;

