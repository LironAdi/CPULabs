onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB_TOP -color Firebrick /tb_top/rst
add wave -noupdate -expand -group TB_TOP -color Yellow /tb_top/clk
add wave -noupdate -expand -group TB_TOP -color Magenta /tb_top/doneProgMem
add wave -noupdate -expand -group TB_TOP -color Blue /tb_top/doneDataMem
add wave -noupdate -expand -group TB_TOP /tb_top/ITCM_tb_wr
add wave -noupdate -expand -group TB_TOP -color Magenta /tb_top/ITCM_tb_in
add wave -noupdate -expand -group TB_TOP -color {Medium Spring Green} /tb_top/ITCM_tb_addr_in
add wave -noupdate -expand -group TB_TOP -color Firebrick /tb_top/TBactive
add wave -noupdate -expand -group TB_TOP /tb_top/End_test
add wave -noupdate -expand -group TB_TOP -color Cyan /tb_top/En_control
add wave -noupdate -expand -group TB_TOP -color White /tb_top/DTCM_tb_wr
add wave -noupdate -expand -group TB_TOP -color {Cornflower Blue} /tb_top/DTCM_tb_in
add wave -noupdate -expand -group TB_TOP -color Pink /tb_top/DTCM_tb_addr_in
add wave -noupdate -expand -group TB_TOP -color Navy /tb_top/DTCM_tb_addr_out
add wave -noupdate -expand -group TB_TOP -color Salmon /tb_top/done
add wave -noupdate -expand -group TB_TOP -color {Cornflower Blue} /tb_top/DTCM_tb_out
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/clk
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/rst
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/En
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/st
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/ld
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/mov
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/done_signal
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/add
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/sub
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/jmp
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/jc
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/jnc
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/and_i
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/or_i
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/xor_i
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/Cflag
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/Zflag
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/Nflag
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/IRin
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/RFin
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/RFout
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/Imm1_in
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/Imm2_in
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/Ain
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/PCin
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/DTCM_out
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/DTCM_addr_sel
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/DTCM_addr_out
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/DTCM_addr_in
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/DTCM_wr
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/RFaddr_rd
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/RFaddr_wr
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/PCsel
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/ALUFN
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/done
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/pr_state
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/nx_state
add wave -noupdate -expand -group Control /tb_top/Top_Ports/Control_ports/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {68709439 ps}
