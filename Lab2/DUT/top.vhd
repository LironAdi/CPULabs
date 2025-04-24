LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity top is
	generic ( n : positive := 16 ); 
	port( rst_i, clk_i, repeat_i : in std_logic;
		  upperBound_i : in std_logic_vector(n-1 downto 0);
		  count_o : out std_logic_vector(n-1 downto 0);
		  busy_o : out std_logic);
end top;
------------------------------------------------------------------
architecture arc_sys of top is
	signal control:std_logic_vector(2 downto 0);
	signal fast_c:std_logic_vector(n-1 downto 0):= (others=> '0');
	signal slow_c:std_logic_vector(n-1 downto 0):= (others=> '0');
	signal one:std_logic_vector(n-1 downto 0):= (0=> '1',others=> '0');
	
	
begin
	----------------------------------------------------------------
	----------------------- fast counter process -------------------
	----------------------------------------------------------------
	proc1 : process(clk_i,rst_i)
	begin
		if (rst_i = '1' and rising_edge(clk_i)) then
			fast_c <= (others=> '0');
		elsif (rising_edge(clk_i) and rst_i = '0') then 
			CASE control is 
				when "000" => 
					fast_c <= (others=> '0');
				when "001" => 
					fast_c <= fast_c + one;
				when "010" => 
					fast_c <= (others=> '0');
				when "100" => 
					fast_c <= (others=> '0');
				--when "011" or "101" =>
				--	fast_c <= fast_c;
				when others =>
					fast_c <= fast_c;
			end case;
		end if;
		
	end process;
	----------------------------------------------------------------
	---------------------- slow counter process --------------------
	----------------------------------------------------------------
	proc2 : process(clk_i,rst_i)
	begin
		if (rst_i = '1' and rising_edge(clk_i)) then
			slow_c <= (others=> '0');
		elsif (rising_edge(clk_i) and rst_i = '0') then 
			CASE control is 
				when "000" => 
					slow_c <= slow_c + one;
				--when "001" => 
				--	slow_c <= slow_c;
				when "010" => 
					slow_c <= (others=> '0');
				when "100" => 
					slow_c <= (others=> '0');
				--when "011" or "101" =>
				--	slow_c <= slow_c;
				when others =>
					slow_c <= slow_c;
			end case;
		
		end if;	
		
	end process;
	---------------------------------------------------------------
	--------------------- combinational part ----------------------
	---------------------------------------------------------------
	 control <= "000" when fast_c = slow_c and slow_c < upperBound_i else-- clear fast counter and +1 for slow counter
				"001" when fast_c < slow_c else -- +1 fast counter
				"010" when  slow_c = upperBound_i and repeat_i = '1'else -- do repeat - reset all
				"011" when  slow_c = upperBound_i and repeat_i = '0' else-- no repeat and busy off
				"100" when  slow_c > upperBound_i and repeat_i = '1' else-- do repeat - reset all
				"101" when  slow_c > upperBound_i and repeat_i = '0' else -- no repeat and busy off
				"111";
	count_o <= fast_c;
	busy_o <= '0' when control = "011" or control = "101" else --not busy
			 '1'; 

	----------------------------------------------------------------
end arc_sys;







