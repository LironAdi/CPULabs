library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;


entity ALU is 
generic( 	ALUFN_width: integer:=4;
			Bus_width: integer:=16
		
			);
	port(
		A,B: in std_logic_vector(Bus_width-1 downto 0);
		AlUFN: in std_logic_vector(ALUFN_width-1 downto 0);
		Cflag, Zflag, Nflag: out std_logic;
		C: out std_logic_vector(Bus_width-1 downto 0)
		
	);
end ALU;


ARCHITECTURE ALU_behav OF ALU IS
SIGNAL reg : std_logic_vector(Bus_width-1 DOWNTO 0);
SIGNAL carry_in : std_logic;
SIGNAL A_0 : std_logic_vector(Bus_width-1 DOWNTO 0);
SIGNAL result : std_logic_vector(Bus_width-1 DOWNTO 0);
SIGNAL add_sub : std_logic_vector(Bus_width-1 DOWNTO 0);
SIGNAL V_zero : std_logic_vector(Bus_width-1 DOWNTO 0):= (others=>'0');
SIGNAL cout : std_logic;
	


	
BEGIN

with ALUFN(3 downto 0) select
	carry_in <= ALUFN(0) When "0000", -- add
				ALUFN(0) When "0001", -- sub
				'0' When others;
			 

with ALUFN(3 downto 0) select
	A_0 <= A When "0000", -- add
		 (not A) When "0001", -- sub
		 (others=>'0') When others;
			 

			 
			 
first : FA port map(
			xi => A_0(0),
			yi => B(0),
			cin => carry_in,
			s => add_sub(0),
			cout => reg(0)
	);
	
	rest : for i in 1 to Bus_width-1 generate
		chain : FA port map(
			xi => A_0(i),
			yi => B(i),
			cin => reg(i-1),
			s => add_sub(i),
			cout => reg(i)
		);
	end generate;
	
	cout <= reg(Bus_width-1);



	with ALUFN(3 downto 0) select
		result <= add_sub When "0000", -- add
			    add_sub When "0001", -- sub
				B and A When "0010", -- and
				B or A When "0011", -- or
				B xor A When "0100", -- xor
				B when "1111",
				(others=>'0') When others;
	  C <= result;
	  
	  

----- Flags ---------
		Nflag <= result(Bus_width-1);
		Zflag <= '1' When (result = V_zero) else '0'; 
	with ALUFN(3 downto 0) select
		Cflag <= cout When "0000",
				cout When "0001",
				unaffected When others;
			 

END ALU_behav;
