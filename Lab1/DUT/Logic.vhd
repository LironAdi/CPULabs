LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY Logic IS
  GENERIC (n : INTEGER := 8);
  PORT (     ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 Res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC );
END Logic;
--------------------------------------------------------------
ARCHITECTURE dfl OF Logic IS
	SIGNAL result : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL V_zero : std_logic_vector(n-1 DOWNTO 0):= (others=>'0') ;

	
BEGIN
	with ALUFN(2 DOWNTO 0) select
		result <= not y When "000",
			   y or x When "001",
			   y and x When "010",
			   y xor x When "011",
			   not(y or x) When "100",
			   not(y and x) When "101",
			   not(y xor x) When "111",
			  (others=>'0') When others;
	  RES <= result;
----- Flags ---------
		Nflag_o <= result(n-1);
		Zflag_o <= '1' When (result = V_zero) else '0' ; 
		Cflag_o <= '0' ;
		Vflag_o <= '0' ; 
			 

END dfl;			 

