library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component top is
		generic( Dwidth:		integer:=16;
				 Awidth:		integer:=4;
				 n:				integer:=16;
				 m:				integer:=16;
				 offsetwidth:	integer:=8;
				dept :	  		integer:=64;
				OPC_size: 		integer:=4;
				Reg_size: 		integer:=4;
				two: 			integer:=2;
				Alufn_size: 	integer:=4 
				 );
		port(	rst, En, clk:				in std_logic; ----control unit + clk for datapath
				done: 						out std_logic; 
				--control:					in std_logic_vector;
				memEn: 						in std_logic;	
				ITCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0);
				ITCM_tb_addr_in:			in std_logic_vector(Awidth-1 downto 0);
				DTCM_tb_out: 				out std_logic_vector(Dwidth-1 downto 0); ------data_out <=> DM_out 
				TBactive: 					in std_logic;
				DTCM_tb_wr: 				in std_logic;
				DTCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0); 
				DTCM_tb_addr_in,DTCM_tb_addr_out: in std_logic_vector(Awidth-1 downto 0)	
		);
	end component;
--------------------------------------------------------- 
	component control is
		generic( bus_width: integer :=16
				);
		port(	clk,rst,En: in std_logic;	
				st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_i,or_i,xor_i,jn,Cflag,Zflag,Nflag:in std_logic;
				IRin,RFin,RFout,Imm1_in,Imm2_in,Ain,PCin,DTCM_out,DTCM_addr_sel,DTCM_addr_out,DTCM_addr_in,DTCM_wr: out std_logic;
				RFaddr_rd,RFaddr_wr,PCsel: out std_logic_vector(1 downto 0);
				ALUFN : out std_logic_vector(3 downto 0);
				done: out std_logic
		);
	end component;
---------------------------------------------------------  
	component datapath is
		generic(Dwidth:			integer:=16;
				Awidth:			integer:=6;
				offsetwidth:	integer:=8;
				dept :	  		integer:=64;
				OPC_size: 		integer:=4;
				Reg_size: 		integer:=4;
				two: 			integer:=2;
				Alufn_size: 	integer:=4
				);		 
				 
				 
		port(clk,rst:					in std_logic;	
			---- PC ------				
			PCin:						in std_logic;
			PCsel:					 	in std_logic_vector(1 downto 0);
			---- program memory ---
			memEn: 						in std_logic;	
			ITCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0);
			ITCM_tb_addr_in:			in std_logic_vector(Awidth-1 downto 0);
			------ IR --------
			IRin:						in std_logic;
			RFadder_rd, RFadder_wr: 	in std_logic_vector(1 downto 0);
			----- OPC ------
			 st,ld,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,jn: out std_logic;
			---- RF -------
			RFin, RFout:					in std_logic; 
			----BIDIR-----
			Imm1_in, Imm2_in, DTCM_out:	in std_logic; 
			----- ALU ----------
			Ain: 						in std_logic;
			ALUFN:						in std_logic_vector(Alufn_size-1 downto 0);
			Cflag, Zflag, Nflag:		out std_logic;
			------- MUX -----
			DTCM_addr_sel:				 in std_logic; 
			DTCM_addr_out,DTCM_addr_in:	 in std_logic;   
			-------Data memory --------
			DTCM_tb_out: 				out std_logic_vector(Dwidth-1 downto 0); ------data_out <=> DM_out 
			DTCM_wr, TBactive: 			in std_logic;
			DTCM_tb_wr: 					in std_logic;
			DTCM_tb_in:					in std_logic_vector(Dwidth-1 downto 0); 
			DTCM_tb_addr_in,DTCM_tb_addr_out: in std_logic_vector(Awidth-1 downto 0)
			);

	end component;
---------------------------------------------------------    
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------	
	component ALU is
		generic( 	ALUFN_width: integer:=4;
			Bus_width: integer:=16
		
			);
		port(
			A,B: in std_logic_vector(Bus_width-1 downto 0);
			AlUFN: in std_logic_vector(ALUFN_width-1 downto 0);
			Cflag, Zflag, Nflag: out std_logic;
			C: out std_logic_vector(Bus_width-1 downto 0)
		
	);
	end component;
	
---------------------------------------------------------
	component IR IS
		generic( RFaddr_width: integer:=2;
					IRwidth: integer:=16;
					Reg_width: integer:=4;
					imm4_width: integer:=4;
					imm8_width: integer:=8
					);
			port(IRin: in std_logic;
				R_RFaddr: in std_logic_vector(RFaddr_width-1 downto 0);
				W_RFaddr: in std_logic_vector(RFaddr_width-1 downto 0);
				dataOut: in std_logic_vector(IRwidth-1 downto 0);
				writeAddr: out std_logic_vector(Reg_width-1 downto 0);
				readAddr: out std_logic_vector(Reg_width-1 downto 0);
				OPC_o: out std_logic_vector(Reg_width-1 downto 0);
				imm4_o: out std_logic_vector(imm4_width-1 downto 0);
				imm8_o: out std_logic_vector(imm8_width-1 downto 0)
			);
	end component;	
---------------------------------------------------------
	component PCunit IS
	  generic( PCsel_width: integer:=2;
			Awidth: integer:=6;
			offsetwidth: integer:=8);
		port( clk: in std_logic;
			PCin: in std_logic;
			PCsel: in std_logic_vector(PCsel_width-1 downto 0);
			offsetAddr: in std_logic_vector(offsetwidth-1 downto 0);
			ReadAddr : out std_logic_vector(Awidth-1 downto 0)
		);
	END component;

---------------------------------------------------------	
	
	component OPCdec is 
		generic( OPCwidth: integer:=4
		);
		port( OPC: in std_logic_vector(OPCwidth-1 downto 0);
		 st,Id,mov,done_signal,add,sub,jmp,jc,jnc,and_o,or_o,xor_o,jn: out std_logic
		);
	end component;
	
---------------------------------------------------------	
	component RF is
		generic( Dwidth: integer:=16;
				 Awidth: integer:=4);
		port(	clk,rst,WregEn: in std_logic;	
				WregData:	in std_logic_vector(Dwidth-1 downto 0);
				WregAddr,RregAddr:	
							in std_logic_vector(Awidth-1 downto 0);
				RregData: 	out std_logic_vector(Dwidth-1 downto 0)
		);
	end component;

----------------------------------------------------------------	
	
	component ProgMem is
		generic( Dwidth: integer:=16;
				 Awidth: integer:=6;
				 dept:   integer:=64);
		port(	clk,memEn: in std_logic;	
				WmemData:	in std_logic_vector(Dwidth-1 downto 0);
				WmemAddr,RmemAddr:	
							in std_logic_vector(Awidth-1 downto 0);
				RmemData: 	out std_logic_vector(Dwidth-1 downto 0)
		);
	end component;
	
----------------------------------------------------------------	
	component dataMem is
		generic( Dwidth: integer:=16;
				 Awidth: integer:=6;
				 dept:   integer:=64);
		port(	clk,memEn: in std_logic;	
				WmemData:	in std_logic_vector(Dwidth-1 downto 0);
				WmemAddr,RmemAddr:	
							in std_logic_vector(Awidth-1 downto 0);
				RmemData: 	out std_logic_vector(Dwidth-1 downto 0)
		);
	end component;

----------------------------------------------------------------	
	component BidirPinBasic is
		port(   writePin: in 	std_logic;
				readPin:  out 	std_logic;
				bidirPin: inout std_logic
		);
	end component;

----------------------------------------------------------------	
	component BidirPin is
		generic( width: integer:=16 );
		port(   Dout: 	in 		std_logic_vector(width-1 downto 0);
				en:		in 		std_logic;
				Din:	out		std_logic_vector(width-1 downto 0);
				IOpin: 	inout 	std_logic_vector(width-1 downto 0)
		);
	end component;	
	
-----------------------------------------------------------------------
	component DFF is
		generic( Awidth: integer:=6 );
		port(   clk,en,rst:			in 		std_logic;
				D: 					in 		std_logic_vector(Awidth-1 downto 0);
				Q:					out		std_logic_vector(Awidth-1 downto 0)
				);
	end component;
-------------------------------------------------------------------------
	component RegA is
		generic( Dwidth: integer:=16 );
		port(   clk,Ain:			in 		std_logic;
				D: 					in 		std_logic_vector(Dwidth-1 downto 0);
				Q:					out		std_logic_vector(Dwidth-1 downto 0)
				);
	end component;																	   
end aux_package;

