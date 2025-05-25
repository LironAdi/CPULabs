library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;


entity tb_control is
constant bus_width: integer :=16;
end tb_control;



Architecture tb_control_behav of tb_control is
signal		clk,rst,En:  				std_logic;	
signal 		st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_i,or_i,xor_i,Cflag,Zflag,Nflag: std_logic;--status
signal		IRin,RFin,RFout,Imm1_in,Imm2_in,Ain,PCin,DTCM_out,
			DTCM_addr_sel,DTCM_addr_out,DTCM_addr_in,
			DTCM_wr: 					std_logic;--control
signal		RFaddr_rd,RFaddr_wr,PCsel:  std_logic_vector(1 downto 0);
signal		ALUFN:				 		std_logic_vector(3 downto 0);
signal		done:						std_logic;


begin
----------------------------------Ports configuration------------------------------------------------------
-- out ports: done' control 
control_Ports: control generic map (bus_width)
port map(clk,rst,En,	
		st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_i,or_i,
		xor_i,Cflag,Zflag,Nflag,IRin,RFin,RFout,Imm1_in,Imm2_in,
		Ain,PCin,DTCM_out,DTCM_addr_sel,DTCM_addr_out,DTCM_addr_in,
		DTCM_wr,RFaddr_rd,RFaddr_wr,PCsel,ALUFN,done);

en <= '1' when done = '0' else '0';



------------------------------------------clk simulation-----------------------------------------------------
gen_clk : process
	begin
	  clk <= '0';
	  wait for 50 ns;
	  clk <= not clk;
	  wait for 50 ns;
	end process;


------------------------------------------Rst simulation-----------------------------------------------------

gen_rst : process
        begin
		  rst <='1','0' after 600 ns;
		  wait;
        end process;	
		
------------------------------------------OPC tests----------------------------------------------------------------
ld_test : process
		begin
		ld <= '0', '1' after 600 ns , '0' after 1100 ns ;
		wait;
		end process ; 
		
mov_test : process
		begin
		mov <= '0', '1' after 1100 ns , '0' after 1600 ns ;
		wait;
		end process ;
		
add_test : process
		begin
		add <= '0', '1' after 1600 ns , '0' after 2100 ns ;
		wait;
		end process ;		
sub_test : process
		begin
		sub <= '0', '1' after 2100 ns , '0' after 2600 ns ;
		wait;
		end process ;

jmp_test : process
		begin
		jmp <= '0', '1' after 2600 ns , '0' after 3100 ns ;
		wait;
		end process ;

jc_test : process
		begin
		jc <= '0', '1' after 3100 ns , '0' after 3600 ns ;
		wait;
		end process ;

jnc_test : process
		begin
		jnc <= '0', '1' after 3600 ns , '0' after 4100 ns ;
		wait;
		end process ;		
		
and_i_test : process
		begin
		and_i <= '0', '1' after 4100 ns , '0' after 4600 ns ;
		wait;
		end process ;		
		
or_i_test : process
		begin
		or_i <= '0', '1' after 4600 ns , '0' after 5100 ns ;
		wait;
		end process ;
		
xor_i_test : process
		begin
		xor_i <= '0', '1' after 5100 ns , '0' after 5600 ns ;
		wait;
		end process ;					
		
done_test : process
		begin
		done_signal <= '0', '1' after 5600 ns , '0' after 6100 ns ;
		wait;
		end process ;
		
end tb_control_behav;