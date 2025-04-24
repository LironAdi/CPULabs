LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
-------------------------------------
ENTITY AdderSub IS
  GENERIC (n : INTEGER := 8);
  PORT (     x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			   Nflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC );
END AdderSub;
--------------------------------------------------------------
ARCHITECTURE dfl OF AdderSub IS
	SIGNAL reg : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL c : std_logic;
	SIGNAL x_0 : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL y_0 : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL a,b,r : std_logic ;
	SIGNAL d : std_logic_vector(2 DOWNTO 0);
	SIGNAL result : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL V_zero : std_logic_vector(n-1 DOWNTO 0):= (others=>'0') ;

	
BEGIN
------------------------ Modify inputs based on arithmetic function-------------------------------
	with ALUFN(2 DOWNTO 0) select
		c <= ALUFN(0) When "000",
			 ALUFN(0) When "001",
			 ALUFN(0) When "011",
			 ALUFN(0) When "100",
			 ALUFN(1) When "010",
			 '0' When others;
			 
	with ALUFN(2 DOWNTO 0) select
		x_0 <= x When "000",
			 (not x) When "001",
			 (not x) When "010",
			 (others=>'0') When "011",
			 (others=>'1') When "100",
			 (others=>'0') When others;
			 
 	with ALUFN(2 DOWNTO 0) select
		y_0 <= y When "000",
			   y When "001",
			   y When "011",
			   y When "100",
			 (others=>'0') When ("010"),
			 (others=>'0') When others;
			 
---------------------------------------------------------------------			
	first : FA port map(
			xi => x_0(0),
			yi => y_0(0),
			cin => c,
			s => result(0),
			cout => reg(0)
	);
	
	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => x_0(i),
			yi => y_0(i),
			cin => reg(i-1),
			s => result(i),
			cout => reg(i)
		);
	end generate;
	
	cout <= reg(n-1);
			d <= ALUFN(2 DOWNTO 0);
			b <= y(n-1);
			a <= x(n-1);
			r <= result(n-1);
			s <= result;
			
----Flags---------
		Nflag_o <= result(n-1) ;
		Zflag_o <= '1' When (result = V_zero) else '0' ; 
		with ALUFN(2 DOWNTO 0) select
			Vflag_o <= ((a and b and (not(r))) or ((not(a)and(not(b))and r))) When "000",
					   ((a and b and (not(r))) or ((not(a)and(not(b))and r))) When "011",
					   ((not(b) and a and (r)) or (b and (not(a)) and not(r))) When "001",
					   ((not(b) and a and (r)) or (b and (not(a)) and not(r))) When "100",
					   '0' When others;
		--Vflag_o <= ((((d and "000") or (d and"011")) and ((a and b and (not(r))) or ((not(a)and(not(b))and r))))or 
		--(((d and "001") or (d and"100")) and ((a and not(b) and (not(r))) or ((not(a)and b and r)))))   ; 

END dfl;

