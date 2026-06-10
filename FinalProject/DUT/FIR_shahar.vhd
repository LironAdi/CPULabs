-- FIR - SHAHAR AND LIRON 
library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library work;
use work.aux_package.all;


entity FIR is
  generic(
	n:         INTEGER := 32;
    W : integer := 24;
    Q : integer := 8;
    M : integer := 8;
    cell : integer := 24;  
    k         : integer := 8;
    pointer  : integer := 3
  );
  -------
 
  port(
    rst_global 	:in  std_logic;
	FIRCLK,FIFOCLK									:IN  std_logic;
    FIFOEMPTY_IFG,FIRIFG					:OUT std_logic;
    Data									:inout std_logic_vector(n-1 downto 0);
    address_in								:in  std_logic_vector(11 downto 0);
    MemWrite_i,MemRead_i				:in std_logic
   
	);
end entity;

architecture behavior of FIR is

    signal x_in      :std_logic_vector(W-1 downto 0);  
	type COEF_arr_type  is array (0 to M-1) of std_logic_vector(q-1 downto 0); --creating MAT size 8X8
	signal COEF		: COEF_arr_type := (others => (others => '0'));
	
	type X_arr_type  is array (0 to M-1) of std_logic_vector(W-1 downto 0); -- לרישום דרך DFF
	signal X_array : X_arr_type := (others => (others => '0'));
	
	
	type mul_type   is array (0 to M-1) of std_logic_vector(W+Q-1 downto 0);
	signal mul_CA  : mul_type  := (others => (others => '0'));
	
	type sum_type   is array (1 to M-1) of std_logic_vector(W+Q-1 downto 0);
	signal SUM     : sum_type;
	
    signal FIROUT    : std_logic_vector(31 downto 0);
	    -- memory
    type mem_type is array(0 to k-1) of std_logic_vector(cell-1 downto 0);
    signal mem      : mem_type := (others => (others => '0'));
    signal dout_reg : std_logic_vector(cell-1 downto 0) := (others => '0');

    -- pointers/count
    signal WR_pointer : std_logic_vector(pointer-1 downto 0) := (others => '0');
    signal RD_pointer : std_logic_vector(pointer-1 downto 0) := (others => '0');
    signal count  : std_logic_vector(pointer downto 0)    := (others => '0');

    -- flags(registered)
    signal FULL  : std_logic := '0';
    signal EMPTY : std_logic := '1';

    -- reset combine
    signal rst_w : std_logic := '0';

    -- constants
    constant ZERO_VEC : std_logic_vector(pointer downto 0) := (others => '0');
	constant K_VEC : std_logic_vector(pointer downto 0):= conv_std_logic_vector(k, pointer+1);
	
	signal EN_DataRead:     std_logic := '0';
    signal Dout,Din:            std_logic_vector(n-1 downto 0):= (others => '0');
    signal	Y_N   	    :std_logic_vector(W+Q-1 downto 0) ;
    signal FIRIN:        std_logic_vector(n-1 downto 0) := (others => '0');
   
   
    signal FIRCTL:              std_logic_vector(7 downto 0):="00010010";
    alias FIFOWEN   : std_logic is FIRCTL(5);
    alias FIFORST   : std_logic is FIRCTL(4);
    alias FIFOFULL  : std_logic is FIRCTL(3);
    alias FIFOEMPTY : std_logic is FIRCTL(2);
    alias FIRRST    : std_logic is FIRCTL(1);
    alias fire_EN    : std_logic is FIRCTL(0);

    signal DATAOUT:  std_logic_vector(W-1 downto 0);
    signal FIFOREN:  std_logic := '0';
    signal FIFOIN:   std_logic_vector(W-1 downto 0) := (others => '0');


    signal FIFOEMPTY_w: std_logic := '0';

    -- FIR to FIFO read pulse
    signal fir_tog : std_logic := '0';
    signal tog_s1, tog_s2 : std_logic := '0';
    signal EN_FIFO_rd : std_logic := '0';

    -- FIRIFG pulse
    signal FIRST_RDY       : std_logic := '0';
    signal Firing_ON  : std_logic := '0';
    signal keep_new_sample_firclk          : std_logic := '0';
    signal sync1, sync2       : std_logic := '0';
    signal firifg_pulse_fifoclk : std_logic := '0';

    signal WR_Q     : std_logic;
    signal WR_Q1   : std_logic := '0';
    signal EN_FIFO_WR : std_logic := '0';

BEGIN


---------------------------------------------------
-------this is the part of the DFF ---------------
-----------------------------------------------------------

  -- קלט לשלב הראשון של השרשרת
  X_array(0) <= DATAOUT;

----פירוק של הCOEF 
 -- COEF_i : for i in 0 to M-1 generate
 --   COEFs(i) <= signed(COEF((i+1)*Q-1 downto i*Q));
--  end generate;

  ---------------------------------------------------------------------------
  gen_x_dffs : for i in 0 to M-2 generate
    XFF: DFF_h
      generic map (Awidth => W)
      port map (clk => FIRCLK,en  => '1', rst => FIRRST,	--##FIRENA 
	  D => X_array(i),Q => X_array(i+1)
      );
  end generate;

  gen_mult : for i in 0 to M-1 generate
    mul_CA(i) <= X_array(i) * COEF(i);   
  end generate;

  SUM(1) <= mul_CA(0) + mul_CA(1);
  gen_sum : for i in 2 to M-1 generate
    SUM(i) <= SUM(i-1) + mul_CA(i);
  end generate;

  YFF: DFF_h
    generic map (Awidth => W+Q)
    port map (clk => FIRCLK,en  => '1' ,rst => FIRRST,
      D => SUM(M-1), Q => Y_N
    );

  
 ---------------------------------------------- 
  --------- Data i / out controlling -------------
  ---------------------------------------------
  
    EN_DataRead <= '1' when ((address_in = x"82C" or address_in = x"830"
			or address_in = x"834" or address_in = x"838" or
			address_in = x"83C")and (MemRead_i = '1'))
            
      else '0';
  
    WR_Q <= '1' when (MemWrite_i = '1' and address_in = x"82C") else '0'; --writing is hapenning

    process (FIFOCLK, rst_global)
    begin
      if rst_global = '1' then
        FIRCTL(4) <= '0';                
        FIRCTL(1 downto 0) <= (others => '0');  
        COEF <= (others => (others => '0'));
        WR_Q1 <= '0'; --last cycle war written
      elsif rising_edge(FIFOCLK) then
        -- capture write edge to make a one-shot
        WR_Q1 <= WR_Q;

        -- latch control bits on FIRCTL write
        if WR_Q = '1' then
            FIRCTL(4)          <= Din(4);         
            FIRCTL(1 downto 0) <= Din(1 downto 0); 
        end if;

        -- FIRIN / COEF writes unchanged
        if (MemWrite_i = '1') and (address_in = x"830") then
            FIRIN <= Din;
        elsif (MemWrite_i = '1') and (address_in = x"838") then
            COEF(0) <= Din(7  downto 0);
            COEF(1) <= Din(15 downto 8);
            COEF(2) <= Din(23 downto 16);
            COEF(3) <= Din(31 downto 24);
        elsif (MemWrite_i = '1') and (address_in = x"83C") then
            COEF(4) <= Din(7  downto 0);
            COEF(5) <= Din(15 downto 8);
            COEF(6) <= Din(23 downto 16);
            COEF(7) <= Din(31 downto 24);
        end if;
      end if;
    end process;  
  
 -----------Fifo when read ---------
     process(FIRCLK, rst_global)
    begin
      if rst_global = '1' then
        fir_tog <= '0';
      elsif rising_edge(FIRCLK) then
        if fire_EN = '1' then
            fir_tog <= not fir_tog;
        end if;
      end if;
    end process;

    process(FIFOCLK, rst_global)
    begin
      if rst_global = '1' then
        tog_s1 <= '0';
        tog_s2 <= '0';
      elsif rising_edge(FIFOCLK) then
        tog_s1 <= fir_tog;
        tog_s2 <= tog_s1;
      end if;
    end process;

    process(FIFOCLK, rst_global)
    begin
      if rst_global = '1' then
        EN_FIFO_rd <= '0';
      elsif rising_edge(FIFOCLK) then
        EN_FIFO_rd <= tog_s1 xor tog_s2;
      end if;
    end process;

    FIFOREN <= EN_FIFO_rd;
  
  
    Data_tristate_read: BidirPin
        generic map(n)
        port map (Dout => Dout, en => EN_DataRead, Din => Din, IOpin => Data);

    Dout <= (n-1 downto 8 => '0')& FIRCTL when (address_in = x"82C") else
            FIRIN  when (address_in = x"830")  else
            FIROUT when (address_in = x"834") else
            COEF(3) & COEF(2) & COEF(1) & COEF(0) when address_in = x"838" else
            COEF(7) & COEF(6) & COEF(5) & COEF(4) when address_in = x"83C" else
            (others => 'Z');

--------------------------------------------------------------
------hendeling with FIRFING ----------------------


    process(FIRCLK, rst_global)
    begin
      if rst_global = '1' then
        FIRST_RDY      <= '0';
        Firing_ON <= '0';
      elsif rising_edge(FIRCLK) then
        Firing_ON <= '0';
        if fire_EN = '1' then
            if FIRST_RDY = '1' then
                Firing_ON <= '1';
            end if;
            FIRST_RDY <= '1';
        end if;
      end if;
    end process;

    process(FIRCLK, rst_global) ----to save the short sample
    begin
      if rst_global = '1' then
        keep_new_sample_firclk <= '0';
      elsif rising_edge(FIRCLK) then
        if (Firing_ON = '1') then
            keep_new_sample_firclk <= not keep_new_sample_firclk;
        end if;
      end if;
    end process;

    process(FIFOCLK, rst_global) 
    begin
      if rst_global = '1' then
        sync1 <= '0';
        sync2 <= '0';
      elsif rising_edge(FIFOCLK) then
        sync1 <= keep_new_sample_firclk;
        sync2 <= sync1;
      end if;
    end process;

    process(FIFOCLK, rst_global)
    begin
      if rst_global = '1' then
        firifg_pulse_fifoclk <= '0';
      elsif rising_edge(FIFOCLK) then
        firifg_pulse_fifoclk <= sync1 xor sync2;
      end if;
    end process;

    FIRIFG <= firifg_pulse_fifoclk;
	


    EN_FIFO_WR <= '1' when (WR_Q = '1' and WR_Q1 = '0' and Din(5) = '1') else '0';
    FIFOWEN       <= EN_FIFO_WR;  -- drives FIRCTL(5) for readback and to FIFO


--------------------FIR out ---------------

	
	process(FIRCLK, rst_global)
	begin
		if rst_global = '1' then
			FIROUT <= (others => '0');
		elsif rising_edge(FIRCLK) then
			FIROUT <= (7 downto 0 => '0') & y_n(n-1 downto 8);
		end if;
	end process;
	
-------------building fifo ----------------

    FIFOEMPTY     <= FIFOEMPTY_w and fire_EN;
    FIFOEMPTY_IFG <= FIFOEMPTY_w and fire_EN and not(rst_global);

    FIFOIN <= FIRIN(W-1 downto 0);	
	rst_w <= rst_global or FIFORST; 

    -- Single-clock core (FIFOCLK)
    process(FIFOCLK, rst_w)
        variable next_count : std_logic_vector(pointer downto 0);
        variable r_ok, w_ok : boolean;
    begin
        if rst_w = '1' then
            WR_pointer   <= (others => '0');
            RD_pointer   <= (others => '0');
            dout_reg <= (others => '0');
            count    <= (others => '0');
            FULL   <= '0';
            EMPTY  <= '1';

        elsif rising_edge(FIFOCLK) then
            -- Decide actions from CURRENT state
            r_ok := (FIFOREN = '1') and (count /= ZERO_VEC);
            -- Allow write if not full, OR if full but a read also happens this cycle
            w_ok := (FIFOWEN = '1') and ( (count /= K_VEC) or r_ok );

            -- READ
            if r_ok then
                dout_reg <= mem(conv_integer(RD_pointer));
                RD_pointer   <= RD_pointer + 1;
            end if;

            -- WRITE
            if w_ok then
                mem(conv_integer(WR_pointer)) <= FIFOIN;
                WR_pointer <= WR_pointer + 1;
            end if;

            -- COUNT next-state
            next_count := count;
            if (w_ok and not r_ok) then
                next_count := count + 1;
            elsif (r_ok and not w_ok) then
                next_count := count - 1;
            else
                -- both or none => unchanged
                null;
            end if;

            -- Register updates
            count    <= next_count;
            if (next_count = ZERO_VEC) then
				EMPTY  <= '1';
			else
				EMPTY  <= '0';
			end if;
			if (next_count = K_VEC) then
				FULL   <= '1';
			else
				FULL   <= '0';
			end if;
		end if;
    end process;

    -- Outputs
    DATAOUT   <= dout_reg;
    FIFOEMPTY_w <= EMPTY;
    FIFOFULL  <= FULL;



end architecture;
