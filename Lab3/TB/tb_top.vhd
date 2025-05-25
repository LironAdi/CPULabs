library IEEE;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use IEEE.std_logic_textio.all;
USE work.aux_package.all;


entity tb_top is
generic(
	Dwidth:         integer :=16;
	Awidth:         integer :=6;
	n:				integer:=16;
	m:				integer:=16;
	dept:           integer:=64;
	Reg_size: 		integer:=4;
	mux_width:      integer:=2;
	offsetwidth:    integer:=8);
	constant progMemLocation: 	string(1 to 52) :=
	"C:\Users\liron\Desktop\CPUlabs\Lab3\DOC\ITCMinit.txt";
	constant dataMemLocationRead: 	string(1 to 52) :=
	"C:\Users\liron\Desktop\CPUlabs\Lab3\DOC\DTCMinit.txt";
	constant dataMemLocationWrite: 	string(1 to 50) :=
	"C:\Users\liron\Desktop\CPUlabs\Lab3\DOC\output.txt";
end tb_top;



Architecture tb_top_behav of tb_top is


signal rst,clk: std_logic;
signal doneProgMem,doneDataMem: std_logic;
signal ITCM_tb_wr: std_logic;--ProgmemEnable
signal ITCM_tb_in: std_logic_vector(Dwidth-1 downto 0);--ProgmemdataIn
signal ITCM_tb_addr_in: std_logic_vector(Awidth-1 downto 0);--WProgmemaddr
signal TBactive,End_test,En_control: std_logic:='0';
signal DTCM_tb_wr: std_logic;--in of the mux with control signal DTCM_wr
signal DTCM_tb_in: std_logic_vector(Dwidth-1 downto 0); --in of the mux with Bus B
signal DTCM_tb_addr_in,DTCM_tb_addr_out: std_logic_vector(Awidth-1 downto 0);
signal done: std_logic;
signal DTCM_tb_out: std_logic_vector(Dwidth-1 downto 0);

begin


----------------------------------Ports configuration------------------------------------------------------
--Top Out ports - done, DTCM_tb_out
Top_Ports: Top generic map (Dwidth,Awidth,n,m,offsetwidth,dept,Reg_size,Reg_size,mux_width,Reg_size)
port map(rst,En_control,clk,done,ITCM_tb_wr,ITCM_tb_in,ITCM_tb_addr_in,DTCM_tb_out,TBactive,
DTCM_tb_wr,DTCM_tb_in,DTCM_tb_addr_in,DTCM_tb_addr_out);




------------------------------------------clk simulation-----------------------------------------------------
gen_clk : process
	begin
	  clk <= '0';
	  wait for 50 ns;
	  clk <= not clk;
	  wait for 50 ns;
	end process;


------------------------------------------Rst simulation-----------------------------------------------------

genRST: process
        begin
		  rst <='1','0' after 100 ns;
		  wait;
        end process;	
		
		
------------------------------------------Top simulation-------------------------------------------------------

TopTB:process
	begin
	--wait for 100 ns;
	End_test <= '0';
	TBactive <= '0';
	En_control <= '0';
    wait until doneProgMem = '1' and doneDataMem = '1';
	TBactive <= '1';
	En_control <= '1';
	wait until done = '1';
	TBactive <= '0';
	En_control<='0';
	End_test <= '1';
    wait; 
end process;
	



------------------------------------- Read from file to Program memory ------------------------------------------------------
LoadFileToProgMem: process
		file infile_ITCM : text open read_mode is progMemLocation;

		variable address: std_logic_vector(Awidth-1 downto 0):= (others=>'0');
		variable L: line;
		variable line_entry: std_logic_vector(Dwidth-1 downto 0);	
		variable good: boolean;
	begin
		doneProgMem <= '0';
		address := (others => '0');
		while not endfile (infile_ITCM) loop
			readline(infile_ITCM,L);
			hread(L,line_entry,good);
			next when not good;
			ITCM_tb_wr <= '1';--Enable read for file and write to program memory
			ITCM_tb_addr_in<=address;--load the number of the line to read
			ITCM_tb_in<=line_entry;--load the data from the line
			wait until rising_edge(clk);
			address := address + 1;--move for the next line
		end loop;
		ITCM_tb_wr <= '0';--disable read for file and write to program memory
		doneProgMem <= '1';
		file_close(infile_ITCM);
		wait;
	end process;

------------------------------------- Read from file to Data memory ------------------------------------------------------
			
LoadFileToDataMem:process
		file infile_DTCMinit : text open read_mode is dataMemLocationRead;
		variable address: std_logic_vector(Awidth-1 downto 0):= (others=>'0');
		variable L: line;
		variable line_entry: std_logic_vector(Dwidth-1 downto 0);		
		variable good: boolean;
	begin
		doneDataMem <= '0';
		address := (others => '0');
		while not endfile (infile_DTCMinit) loop
			readline(infile_DTCMinit,L);
			hread(L,line_entry,good);
			next when not good;
			DTCM_tb_wr <= '1';--Enable read for file and write to Data memory
			DTCM_tb_addr_in<=address;--load the number of the line to read
			DTCM_tb_in<=line_entry;--load the data from the line
			wait until rising_edge(clk);
			address := address + 1;
		end loop;
		DTCM_tb_wr <= '0';--disable read for file and write to Data memory
		doneDataMem <= '1';
		file_close(infile_DTCMinit);
		wait;
	end process;


------------------------ Write from Data Memory to file ------------------------------------------------------------------

StoreToFileFromDataMem:process
		file outfile_DTCMinit : text open write_mode is dataMemLocationWrite;
		variable address: std_logic_vector(Awidth-1 downto 0):= (others=>'0');
		variable L: line;
		variable line_entry: std_logic_vector(Dwidth-1 downto 0);
		variable good: boolean;
		variable counter: integer;
		variable unknown:std_logic_vector(Dwidth-1 downto 0):=(others =>'X') ;

		
	begin
		wait until End_test = '1';
		address := (others => '0');
		counter := 0;
		while counter < dept loop
			DTCM_tb_addr_out <= address;--load the number of the line to Write
			wait until rising_edge(clk);
			wait until rising_edge(clk);
			--line_entry := DTCM_tb_out;  --dataout
			if DTCM_tb_out = unknown then
				exit ;
			end if;
			hwrite(L,DTCM_tb_out);
			writeline(outfile_DTCMinit,L);
			wait until rising_edge(clk);
			address := address + 1; --increase address(move to the next line)
			counter := counter +1 ; 
		end loop;			   
		file_close(outfile_DTCMinit);
		wait; 
	end process;

end tb_top_behav;