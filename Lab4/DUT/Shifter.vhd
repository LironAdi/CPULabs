LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------
ENTITY Shifter IS
  GENERIC (n : INTEGER := 8;
			k : INTEGER := 3);
  PORT (     x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC);
END Shifter;
--------------------------------------------------------
architecture Shifter of Shifter is
	constant q_max : integer:= 2**(k);
	subtype vector is STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	type matrix is array (2**(k)-1 DOWNTO 0) of vector;
	SIGNAL row: matrix;
	SIGNAL q: INTEGER:= 0;
	SIGNAL result : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL V_zero : std_logic_vector(n-1 DOWNTO 0):= (others=>'0') ;
	SIGNAL V_U : std_logic_vector(k-1 DOWNTO 0):= (others=>'U') ;
	
	begin
		
		q <= 0 when (x(k-1 downto 0) = V_U)
			else to_integer(unsigned(x(k-1 downto 0)));
		
		row(0) <= y;
		rest: FOR i in 1 to (2**(k)-1) generate
				with ALUFN(2 DOWNTO 0) select
					row(i) <= (row(i-1) (n-2 DOWNTO 0) & '0') When  "000",--shift left
							('0' & row(i-1) (n-1 DOWNTO 1)) When  "001",--shift right
							(others=>'0') When others;							
		end generate;
		result <= row(q);
		s <= result;
------------ Flags ---------
		Nflag_o <= result(n-1);
		Zflag_o <= '1' When (result = V_zero) else '0' ; 
		Cflag_o <= '0' when (q = 0) else 
				row(q-1)(n-1) when (ALUFN(2 DOWNTO 0) = "000") else
				row(q-1)(0) when (ALUFN(2 DOWNTO 0) = "001") else	'0' ;
		Vflag_o <= '0' ; 
	end Shifter;
	