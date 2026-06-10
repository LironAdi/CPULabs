LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY ALU IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT 
  (  clk: IN STD_LOGIC;
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
  ); -- Zflag,Cflag,Nflag,Vflag
END ALU;
------------- complete the ALU Architecture code --------------
ARCHITECTURE struct OF ALU IS 
	SIGNAL x_Arithmetic, y_Arithmetic : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL x_shifter,y_shifter : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL x_logic, y_logic: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL Nflag_list, Cflag_list, Zflag_list, Vflag_list: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL res_Arithmetic,res_shifter,res_logic: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL Y_t, X_t : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL ALUFN_t : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL ALUout_t : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL Nflag_t,Cflag_t,Zflag_t,Vflag_t: STD_LOGIC;
	
BEGIN
Reg_in: process(clk)
	BEGIN
		if rising_edge(clk) then
			X_t <= X_i;
			Y_t <= Y_i;
			ALUFN_t <= ALUFN_i;
		end if;
	end process;



----------------------------------------------------------Assigning vectors-----------------------------------------	
	x_Arithmetic <= X_t when ALUFN_t(4 DOWNTO 3) = "01" else
			(others=>'0');
			
	y_Arithmetic <= Y_t when ALUFN_t(4 DOWNTO 3) = "01" else
			(others=>'0')	;	
	

	x_shifter <= X_t when ALUFN_t(4 DOWNTO 3) = "10" else
			(others=>'0');
			
	y_shifter <= Y_t when ALUFN_t(4 DOWNTO 3) = "10" else
			(others=>'0');

	
	x_logic <= X_t when ALUFN_t(4 DOWNTO 3) = "11" else
			(others=>'0');
			
	y_logic <= Y_t when ALUFN_t(4 DOWNTO 3) = "11" else
			(others=>'0')	;	
	
------------------------------------------------------port map configuration----------------------------------------
		Arithmetic_map : Arithmetic generic map (n) port map(
			x => x_Arithmetic,
			y => y_Arithmetic,
			ALUFN => ALUFN_t(4 DOWNTO 0),
			cout=> Cflag_list(0),
			s => res_Arithmetic,
			Nflag_o => Nflag_list(0),
			Zflag_o => Zflag_list(0),
			Vflag_o => Vflag_list(0)	
	);

		Shifter_map : Shifter generic map (n,k) port map( 
			x => x_shifter,
			y => y_shifter,
			ALUFN=>ALUFN_t(4 DOWNTO 0),
			s => res_shifter,
			Nflag_o => Nflag_list(1),
			Cflag_o => Cflag_list(1),
			Zflag_o => Zflag_list(1),
			Vflag_o => Vflag_list(1)
	);


		Logic_map : Logic generic map (n) port map(
			ALUFN => ALUFN_t(4 DOWNTO 0),
			x => x_logic,
			y => y_logic,
			res => res_logic,
			Nflag_o => Nflag_list(2),
			Cflag_o => Cflag_list(2),
			Zflag_o => Zflag_list(2),
			Vflag_o => Vflag_list(2)
	);
------------------------------------------------------outputs-------------------------------------------------------	
		ALUout_t <=	res_Arithmetic when ALUFN_t(4 DOWNTO 3) = "01" else 
					res_shifter when ALUFN_t(4 DOWNTO 3) = "10" else 
					res_logic when ALUFN_t(4 DOWNTO 3) = "11" else
					(others=>'0');

		Nflag_t <=	Nflag_list(0) when ALUFN_t(4 DOWNTO 3) = "01" else
					Nflag_list(1) when ALUFN_t(4 DOWNTO 3) = "10" else 
					Nflag_list(2) when ALUFN_t(4 DOWNTO 3) = "11" else
					'0';                    
																  
		Cflag_t <=	Cflag_list(0) when ALUFN_t(4 DOWNTO 3) = "01" else 
					Cflag_list(1) when ALUFN_t(4 DOWNTO 3) = "10" else 
					Cflag_list(2) when ALUFN_t(4 DOWNTO 3) = "11" else
					'0';                    
																  
		Zflag_t <=	Zflag_list(0) when ALUFN_t(4 DOWNTO 3) = "01" else 
					Zflag_list(1) when ALUFN_t(4 DOWNTO 3) = "10" else 
					Zflag_list(2) when ALUFN_t(4 DOWNTO 3) = "11" else
					'1';                    
																  
		Vflag_t <=	Vflag_list(0) when ALUFN_t(4 DOWNTO 3) = "01" else 
					Vflag_list(1) when ALUFN_t(4 DOWNTO 3) = "10" else 
					Vflag_list(2) when ALUFN_t(4 DOWNTO 3) = "11" else
					'0';



Reg_out: process(clk)
	BEGIN
		if rising_edge(clk) then
			Nflag_o <= Nflag_t;
			Cflag_o <= Cflag_t;
			Zflag_o <= Zflag_t;
			Vflag_o <= Vflag_t;	
			ALUout_o <= ALUout_t;
		end if;
	end process;


					
END struct;

