library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component ALU is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
	PORT 
	(  clk: IN STD_LOGIC;
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
  );
		-- Zflag,Cflag,Nflag,Vflag
	end component;
---------------------------------------------------------  
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------	
	component Arithmetic is
		GENERIC (n : INTEGER := 8;
				m : INTEGER := 4);
		PORT (     x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				   ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				  cout: OUT STD_LOGIC;
				   s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				   Nflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC );
	end component;
---------------------------------------------------------
	component Shifter IS
		GENERIC (n : INTEGER := 8;
				k : INTEGER := 3);
	    PORT (     x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				   ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				   s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
				   Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC );
	end component;	
---------------------------------------------------------
	component Logic IS
	  GENERIC (n : INTEGER := 8);
	  PORT (     ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				 Res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				 Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC );
	END component;
	
	
	component PWM IS
	  GENERIC (n : INTEGER := 16);
	  PORT 
	  (  clk, en, rst: IN STD_LOGIC;
			Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			  ALUFN_i : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			  PWM_out: OUT STD_LOGIC
	  );
	END component;
	
	component Counter IS
	  GENERIC (n : INTEGER := 16);
	  PORT 
	  (  clk, en, rst, EQUY: IN STD_LOGIC;
			count_o: out STD_LOGIC_VECTOR (n downto 0)
	  );
	END component;
	
	component top_PWM IS
	  GENERIC (n : INTEGER := 16);
	  PORT 
	  (  clk, en, rst: IN STD_LOGIC;
			Y,X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			  PWM_out: OUT STD_LOGIC
	  );
	END component;
	
	component Digital_System IS
	  GENERIC (PWM_width : INTEGER := 16;
				ALU_width : INTEGER := 8;
				k : integer := 3;   -- k=log2(n)
				m : integer := 4	);
	  PORT 
	  (  clk, en, rst: IN STD_LOGIC;
		Y,X: IN STD_LOGIC_VECTOR (PWM_width-1 DOWNTO 0);
		  ALUFN: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  V_flag,N_flag,C_flag,Z_flag: OUT STD_LOGIC;
		  ALU_out: OUT STD_LOGIC_VECTOR (ALU_width-1 DOWNTO 0);
		  PWM_out: OUT STD_LOGIC
	  );
	END component;
	
	component PLL IS
		PORT
		(
			areset		: IN STD_LOGIC  := '0';
			inclk0		: IN STD_LOGIC  := '0';
			c0			: OUT STD_LOGIC ;
			locked		: OUT STD_LOGIC 
		);
	END component;
	
	component Decoder IS
		PORT
		(
		Data_IN			:in STD_LOGIC_VECTOR(3 downto 0);
		Data_OUT		:out STD_LOGIC_VECTOR(6 downto 0)
		);
	END component;

	
end aux_package;

