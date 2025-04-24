library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aux_package.all; 

entity tb is
end entity;

architecture behavior of tb is

    constant n : integer := 8;
    signal rst    : std_logic := '0';
    signal clk    : std_logic := '0';
    signal repeat : std_logic := '0';
    signal upperBound : std_logic_vector(n-1 downto 0) := (others => '0');
    signal count   : std_logic_vector(n-1 downto 0);
    signal busy    : std_logic;

begin

    UUT: top
        generic map ( n => n )
        port map (
            rst_i => rst,
            clk_i => clk,
            repeat_i => repeat,
            upperBound_i => upperBound,
            count_o => count,
            busy_o => busy
        );

    -- clock generation
    clk_process : process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- stimulus process
    stim_proc: process
    begin
        -- reset
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- set upper bound
        upperBound <= "00000101"; -- 5

        -- first: no repeat
        repeat <= '0';
        wait for 150 ns;

        -- then: repeat enabled
        repeat <= '1';
        wait for 100 ns;

        wait;
    end process;

end architecture;
