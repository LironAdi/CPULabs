LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------
ENTITY Shifter IS
  GENERIC (n : INTEGER := 32;
			k : INTEGER := 5);
  PORT (    x: IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
			y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			Shift_ctrl: IN STD_LOGIC;
			--ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
		);
			--Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC);
END Shifter;
--------------------------------------------------------
architecture Shifter of Shifter is
	constant q_max : integer:= 2**(k);
	subtype vector is STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	type matrix is array (q_max-1 DOWNTO 0) of vector;
	SIGNAL row: matrix;
	SIGNAL q : integer range 0 to q_max-1 := 0;	
	--SIGNAL result : std_logic_vector(n-1 DOWNTO 0);
	--SIGNAL V_zero : std_logic_vector(n-1 DOWNTO 0):= (others=>'0') ;
	--SIGNAL V_U : std_logic_vector(k-1 DOWNTO 0):= (others=>'U') ;
	begin
		
		q <= to_integer(unsigned(x));
		
		row(0) <= y;
		
		rest: FOR i in 1 to (q_max-1) generate
			row(i) <= (row(i-1)(n-2 downto 0) & '0') when Shift_ctrl = '1' else
					  ('0' & row(i-1)(n-1 downto 1));							
		end generate rest;
		s <= row(q);
		--s <= result;
	end Shifter;