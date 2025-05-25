library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

--------------------------------------------------------------
entity control is
generic( bus_width: integer :=16
		
		);
port(	clk,rst,En: in std_logic;	
		st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_i,or_i,xor_i,jn,Cflag,Zflag,Nflag:in std_logic;--status
		IRin,RFin,RFout,Imm1_in,Imm2_in,Ain,PCin,DTCM_out,DTCM_addr_sel,DTCM_addr_out,DTCM_addr_in,DTCM_wr: out std_logic;--control
		RFaddr_rd,RFaddr_wr,PCsel: out std_logic_vector(1 downto 0);
		ALUFN : out std_logic_vector(3 downto 0);
		done: out std_logic
	);
end control;


--Status
--- 0-st,1-ld,2-mov,3-done ,4- add,5-sub,6-jmp,7-jc,8-jnc,9-and,10-or,11-xor,12-Cflag,13-Zflag,14-Nflag
architecture control_behav of control is
type state is (Reset,Fetch,Decode,Waste_time,Execute1R,Execute1I,Execute2I);
signal pr_state,nx_state:state;
signal cout,nout: std_logic;

begin	
---------------------------Lower Section------------------------------------
mealy_seq:process(rst,clk,En)
begin
	if(rst='1') then
		pr_state<=Reset;
	elsif (rising_edge(clk)) then
		if (En = '1') then
			pr_state<=nx_state;
		else
			pr_state<=pr_state;
		end if;
	end if;
end process;

mealy_comb:process(st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_i,or_i,xor_i,jn,Cflag,Zflag,Nflag,pr_state)
begin
	case pr_state is
-----------------------Reset------------------------------------------------
		when Reset=> 
			--reset all the control signals and push to the PC 0.
			IRin		              <='0';
			RFin	                  <='0';
			RFout	                  <='0';
			ALUFN                     <="1110";
			Imm1_in                   <='0';
			Imm2_in                   <='0';
			Ain                       <='0';
			PCin                      <='1';
			DTCM_out                  <='0';
			DTCM_addr_sel             <='0';
			DTCM_addr_out             <='0';
			DTCM_addr_in              <='0';
			DTCM_wr                   <='0';
			RFaddr_rd                 <="00";
			RFaddr_wr                 <="00";
			PCsel        			  <="00";--reset  
			done                      <='0';
			cout					  <='0';
			nout					  <='0';
			---- PCin='1'             
			nx_state<=Fetch;          
-----------------------level 0------------------------------------------------
		when Fetch=>
			--load the instruction from the program memory to the IR
			IRin		              <='1';--
			RFin	                  <='0';
			RFout	                  <='0';
			ALUFN                     <="1110";
			Imm1_in                   <='0';
			Imm2_in                   <='0';
			Ain                       <='0';
			PCin                      <='0';
			DTCM_out                  <='0';
			DTCM_addr_sel             <='0';
			DTCM_addr_out             <='0';
			DTCM_addr_in              <='0';
			DTCM_wr                   <='0';
			RFaddr_rd                 <="00";
			RFaddr_wr                 <="00";
			PCsel        			  <="10";--PC+1	
			done                      <='0';
			cout					  <=Cflag;
			nout					  <=Nflag;

			---- IRin = '1'
			nx_state<=Decode;
-----------------------level 1------------------------------------------------
		when Decode =>
			-- decode the instruction and check which type is it, and go to the suitable state
			if(add='1' or sub='1' or and_i = '1' or or_i = '1' or xor_i = '1') then
				IRin		              <='0';
				RFin	                  <='0';
				RFout	                  <='1';
				ALUFN                     <="1111";--B=C
				Imm1_in                   <='0';
				Imm2_in                   <='0';
				Ain                       <='1';
				PCin                      <='0';
				DTCM_out                  <='0';
				DTCM_addr_sel             <='0';
				DTCM_addr_out             <='0';
				DTCM_addr_in              <='0';
				DTCM_wr                   <='0';
				RFaddr_rd                 <="00";
				RFaddr_wr                 <="10";
				PCsel        			  <="10";--PC+1  	
				done                      <='0';
				--cout					  <='0';
				nx_state <=Execute1R;
			elsif(jmp= '1' or jc='1' or jnc='1' or jn='1') then
				DTCM_out                  <='0';
				DTCM_addr_sel             <='0';
				DTCM_addr_out             <='0';
				DTCM_addr_in              <='0';
				DTCM_wr                   <='0';
				IRin		              <='0';
				RFin	                  <='0';
				RFout	                  <='0';
				ALUFN                     <="1110";
				Ain                       <='0';				
				RFaddr_rd                 <="00";
				RFaddr_wr                 <="10";
				if (jmp = '1') or (jc = '1' and cout = '1') or (jn = '1' and Nout = '1') or (jnc = '1' and cout = '0') then
					PCsel        			  <="01";--JMP 
					cout					  <='0';
					nout					  <='0';
				else
					PCsel        			  <="10";--PC+1 
					cout					  <='0';
					nout					  <='0';
				end if;
				PCin                      <='1';				
				Imm1_in                   <='0';
				Imm2_in                   <='0';
				done                      <='0';
				nx_state <=Fetch;
			elsif(ld= '1' or st='1' or mov='1') then
				DTCM_out                  <='0';
				DTCM_addr_sel             <='0';--bus A
				DTCM_addr_out             <='0';
				DTCM_addr_in              <='0';
				DTCM_wr                   <='0';				
				ALUFN                     <="1111";	--B=C		
				IRin		              <='0';				
				Imm2_in                   <='0';				
				PCsel        			  <="10";--PC+1  				
				done                      <='0';
				--cout					  <='0';				
				if (mov = '1') then
					RFin	                  <='1';
					RFout	                  <='0';
					Ain                       <='0';
					Imm1_in                   <='1';
					RFaddr_rd                 <="00";
					RFaddr_wr                 <="10";
					PCin                      <='1';
					nx_state <=Fetch;
				elsif (ld = '1' or st = '1') then
					RFin	                  <='0';
					RFout	                  <='1';
					Ain                       <='1';
					Imm1_in                   <='0';
					RFaddr_rd                 <="01";
					RFaddr_wr                 <="00";
					PCin                      <='0';
					nx_state <=Execute1I;
				end if;
				
			elsif(done_signal= '1') then
				PCsel        			  <="10";--PC+1 				
				done                      <='1';				
				PCin                      <='1';				
				nx_state <=Fetch;
			else 
				nx_state <=Fetch;	
			end if;
-----------------------level 2------------------------------------------------
			
		when Execute1R =>
			DTCM_out                     <='0';
			DTCM_wr                      <='0';	
			DTCM_addr_out                <='0';
			DTCM_addr_in                 <='0';		
			if(add='1') then
				ALUFN                    <= "0000";
			elsif(sub='1') then
				ALUFN                    <= "0001";
			elsif(and_i='1') then
				ALUFN                    <= "0010";
			elsif(or_i='1') then
				ALUFN                    <= "0011";
			elsif(Xor_i='1') then
				ALUFN      				 <= "0100";	
			end if;
			IRin		              <='0';
			RFin	                  <='1';
			RFout	                  <='1';
			Imm1_in                   <='0';
			Imm2_in                   <='0';
			Ain                       <='0';
			PCin                      <='1';
			RFaddr_rd                 <="01";--Rb
			RFaddr_wr                 <="10";--Ra
			PCsel        			  <="10";--PC+1  	
			done                      <='0';
			nx_state <=Fetch;
		
  		when Waste_time =>
			--if (ld= '1' or st='1' or mov='1') then
			nx_state <=Execute2I;
			--elsif (add='1' or sub='1' or and_i = '1' or or_i = '1' or xor_i = '1') then
			--	nx_state <=Fetch;
			--end if;
		
		when Execute1I=> 
			DTCM_out                     <='0';
			DTCM_wr                      <='0';	
			ALUFN                        <="0000";--add
			Ain                          <='0';
			if ld = '1' then 
				DTCM_addr_out            <='1';
				DTCM_addr_in             <='0';
			else
				DTCM_addr_out            <='0';
				DTCM_addr_in             <='1';
			end if;	
			IRin		              <='0';
			RFin	                  <='0';
			RFout	                  <='0';
			Imm1_in                   <='0';
			Imm2_in                   <='1';
			PCin                      <='0';
			RFaddr_rd                 <="00";
			RFaddr_wr                 <="10";
			PCsel        			  <="10";--PC+1  	
			done                      <='0';
			nx_state                  <= Waste_time;
		when Execute2I=> -- st,ld,mov
			if (ld = '1') then
				DTCM_out                  <='1';
				DTCM_wr                   <='0';
				ALUFN                     <="1111";
				RFin	                  <='1';
				RFout	                  <='0';
				PCin                      <='1';
				nx_state                  <= Fetch;
				RFaddr_rd                 <="00";
				RFaddr_wr                 <="10";				
			else
				DTCM_out                  <='0';
				DTCM_wr                   <='1';
				ALUFN                     <="1110";
				RFin	                  <='0';
				RFout	                  <='1';
				PCin                      <='1';
				nx_state                  <= Fetch;	
			end if;
			DTCM_addr_out            <='0';
			DTCM_addr_in             <='0';
			IRin		              <='0';
			Imm1_in                   <='0';
			Imm2_in                   <='0';
			Ain                       <='0';
			RFaddr_rd                 <="10";
			RFaddr_wr                 <="10";
			done                      <='0';
			PCsel        			  <="10";--PC+1  	
		when others =>
			nx_state <= Reset;
		end case;
end process;

end control_behav;