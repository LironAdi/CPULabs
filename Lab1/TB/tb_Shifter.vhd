library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity tb_Shifter is
	constant n : integer := 8;
	constant k : integer := 3;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1)
	constant ROWmax : integer := 5; 
end tb_Shifter;
-------------------------------------------------------------------------------
architecture rtb of tb_Shifter is
	type mem is array (0 to ROWmax) of std_logic_vector(4 downto 0);
	SIGNAL Y,X:  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL ALUFN :  STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL ALUout:  STD_LOGIC_VECTOR(n-1 downto 0); -- ALUout[n-1:0]&Cflag
	SIGNAL Nflag,Cflag,Zflag,Vflag: STD_LOGIC; -- Zflag,Cflag,Nflag,Vflag
	SIGNAL Icache : mem := (
							"10000","10001","10000","10001","10000","10001");
begin
	L0 : Shifter generic map(n,k) port map(X,Y,ALUFN,ALUout,Nflag,Cflag,Zflag,Vflag);
    
	--------- start of stimulus section ----------------------------------------		
        tb_x_y : process
        begin
		  x <= (others => '1');
		  y <= (others => '1');
		  wait for 50 ns;
		  for i in 0 to 40 loop
			x <= x-10;
			y <= y-1;
			wait for 50 ns;
		  end loop;
		  wait;
        end process;
		 
		
		tb_ALUFN : process
        begin
		  ALUFN <= (others => '0');
		  for i in 0 to ROWmax loop
			ALUFN <= Icache(i);
			wait for 100 ns;
		  end loop;
		  wait;
        end process;
  
end architecture rtb;
