library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use IEEE.std_logic_textio.all;
USE work.aux_package.all;

entity tb_DP is
constant	Dwidth:			integer:=16;
constant	Awidth:			integer:=6;
constant	offsetwidth:	integer:=8;
constant	dept :	  		integer:=64;
constant	OPC_size: 		integer:=4;
constant	Reg_size: 		integer:=4;
constant	two: 			integer:=2;
constant	Alufn_size: 	integer:=4;
constant	progMemLocation: 	string(1 to 50) :=
	"C:\Users\Yael\Downloads\Lab3\Lab3\DOC\ITCMinit.txt";
	constant dataMemLocationRead: 	string(1 to 50) :=
	"C:\Users\Yael\Downloads\Lab3\Lab3\DOC\DTCMinit.txt";
	constant dataMemLocationWrite: 	string(1 to 48) :=
	"C:\Users\Yael\Downloads\Lab3\Lab3\DOC\output.txt";
end tb_DP;



Architecture tb_DP_behav of tb_DP is
signal	clk,rst,PCin:					 std_logic;
signal	PCsel:					 	 std_logic_vector(1 downto 0);
signal	IRin:						 std_logic;
signal	RFadder_rd, RFadder_wr: 	 std_logic_vector(1 downto 0);
signal	st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o: std_logic;
signal	RFin, RFout:					std_logic; 
signal	Imm1_in, Imm2_in, DTCM_out:		std_logic; 
signal	Ain: 						    std_logic;
signal	ALUFN:						 	std_logic_vector(Alufn_size-1 downto 0);
signal	Cflag, Zflag, Nflag:			std_logic;
signal	DTCM_addr_sel:				    std_logic; 
signal	DTCM_addr_out,DTCM_addr_in:		std_logic;   
signal	DTCM_wr: 				std_logic;
signal doneProgMem,doneDataMem: std_logic;
signal ITCM_tb_wr: std_logic;--ProgITCM_tb_wrable
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
-- out ports: done' DP 
DP_Ports: datapath port map(clk,rst,PCin,PCsel,ITCM_tb_wr,ITCM_tb_in,ITCM_tb_addr_in,IRin,RFadder_rd, RFadder_wr,
	st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,RFin, RFout,Imm1_in, Imm2_in, DTCM_out,
	Ain,ALUFN,Cflag, Zflag, Nflag,DTCM_addr_sel,DTCM_addr_out,DTCM_addr_in,DTCM_tb_out, 		 
	DTCM_wr, TBactive,DTCM_tb_wr,DTCM_tb_in,DTCM_tb_addr_in,DTCM_tb_addr_out);



------------------------------------------clk simulation-----------------------------------------------------
clk_TB : process
	begin
	  clk <= '0';
	  wait for 50 ns;
	  clk <= not clk;
	  wait for 50 ns;
	end process;

------------------------------------------Rst simulation-----------------------------------------------------

RST_TB: process
        begin
		  rst <='1','0' after 100 ns;
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
		
	begin
		wait until End_test = '1';
		address := (others => '0');
		counter := 0;
		while counter < dept loop
			DTCM_tb_addr_out <= address;--load the number of the line to Write
			wait until rising_edge(clk);
			wait until rising_edge(clk);
			--line_entry := DTCM_tb_out;  --dataout
			hwrite(L,DTCM_tb_out);
			writeline(outfile_DTCMinit,L);
			wait until rising_edge(clk);
			address := address + 1; --increase address(move to the next line)
			counter := counter +1 ; 
		end loop;			   
		file_close(outfile_DTCMinit);
		wait; 
	end process;
		
------------------------------------------Data Path simulation-------------------------------------------------------

DP_TB: process
	begin
	wait for 100 ns;
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


------------------ TB --------------------------------------------------------------------------------------
Main_TB: process
		begin
		wait until doneProgMem='1' and doneDataMem='1';
		
		wait until clk'event and clk='1';
		---- reset ------				
		PCin			<= '1'	;					
		PCsel			<= "00"	;	--PC pointig 0 address			 	
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1010";						
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
	------------- load data to regisers: R1 R4, R2 -----------------
		wait until clk'event and clk='1';
	--- writing to Rb ---
	
	---mov r2,3 C203 ---- 
		PCin			<= '0'	;					
		PCsel			<= "11"	;	---uneffected			 					
		IRin			<= '1'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";	--uneffected					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
	
	wait until clk'event and clk='1'; 
		PCin			<= '0'	;					
		PCsel			<= "11"	;	---uneffected			 						
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "10"; --write reg a 
		RFin			<= '1';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '1' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";	--uneffected					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
	
	wait until clk'event and clk='1';	
	---mov r4,1 C401 ---- 
		PCin			<= '1'	;					
		PCsel			<= "10"	;				 						
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";	--uneffected					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
	wait until clk'event and clk='1';
	
		PCin			<= '0'	;					
		PCsel			<= "11"	;	---uneffected			 					
		IRin			<= '1'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "10"; --write reg a 
		RFin			<= '1';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '1' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";	--B = C					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		
	wait until clk'event and clk='1';	
	---mov r1,2 C102 ---- 
		PCin			<= '1'	;					
		PCsel			<= "10"	;				 					
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";	--uneffected					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
	wait until clk'event and clk='1';
	
		PCin			<= '0'	;					
		PCsel			<= "11"	;	---uneffected			 						
		IRin			<= '1'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "10"; --write reg a 
		RFin			<= '1';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '1' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";	--- B = C				
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';


		
----------- R[ra] <= R[rb] + R[rc] --- Data in: 2410 ----
		--------------PC+1-------
		wait until clk'event and clk='1';			
		PCin			<= '1'	;					
		PCsel			<= "10"	;				 				
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111"; --uneffected						
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		---Fetch --------
		wait until clk'event and clk='1';			
		PCin			<= '0';					
		PCsel			<= "11";					 					
		IRin			<= '1'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111";						
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		
		
		wait until clk'event and clk='1';			
		PCin			<= '0';					
		PCsel			<= "11";					 					
		IRin			<= '0'	;					
		RFadder_rd		<= "01" ; --read Reg(b)
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '1';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '1' 	;					
		ALUFN			<= "1111";						
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		------Decode -----------
		
		wait until clk'event and clk='1';			
		PCin			<= '0';						
		PCsel			<= "11";					 					
		IRin			<= '0'	;					
		RFadder_rd		<= "00" ; --read Reg(c)
		RFadder_wr		<= "10"; --write Reg(a) <-- Reg(c) + Reg(b)
		RFin			<= '1';
		RFout			<= '1'	;				
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	 ;
		Ain				<= '0' 	;					
		ALUFN			<= "0000"; ---add						
		DTCM_addr_sel	<= '0';				 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		
------------- I-type, jmp 2 address: 0702 hx ----------- 
-------PC --------------		
		wait until clk'event and clk='1';			
		PCin			<= '1'	;					
		PCsel			<= "10"	;				 				
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111"; --uneffected						
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		
		wait until clk'event and clk='1';			
		PCin			<= '0'	;					
		PCsel			<= "11"	;				 				
		IRin			<= '1'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111"; --uneffected					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		
		wait until clk'event and clk='1';			
		PCin			<= '1'	;					
		PCsel			<= "01"	;				 				
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "0111"; --offset adder					
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
		-------PC --------------		
		wait until clk'event and clk='1';			
		PCin			<= '1'	;					
		PCsel			<= "10"	;				 				
		IRin			<= '0'	;					
		RFadder_rd		<= "11" ;
		RFadder_wr		<= "11";
		RFin			<= '0';
		RFout			<= '0';					
		Imm1_in			<= '0' ;
		Imm2_in			<= '0' ;
		DTCM_out		<= '0'	; 
		Ain				<= '0' 	;					
		ALUFN			<= "1111"; --uneffected						
		DTCM_addr_sel	<= '0'	;			 
		DTCM_addr_out	<= '0';
		DTCM_addr_in	<= '0';	   
		DTCM_wr			<= '0';
		
	end process;

			
end tb_DP_behav;