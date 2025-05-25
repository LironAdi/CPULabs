onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dp/DP_Ports/clk
add wave -noupdate /tb_dp/DP_Ports/rst
add wave -noupdate /tb_dp/DP_Ports/TBactive
add wave -noupdate -group PC /tb_dp/DP_Ports/PCin
add wave -noupdate -group PC /tb_dp/DP_Ports/PCsel
add wave -noupdate -group PC /tb_dp/DP_Ports/PC_out
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/ITCM_tb_in
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/ITCM_tb_addr_in
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_out
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_addr_sel
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_addr_out
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_addr_in
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_tb_out
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_wr
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_tb_wr
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_tb_in
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_tb_addr_in
add wave -noupdate -group {ITCM DTCM} /tb_dp/DP_Ports/DTCM_tb_addr_out
add wave -noupdate -expand -group RF /tb_dp/DP_Ports/RFadder_rd
add wave -noupdate -expand -group RF /tb_dp/DP_Ports/RFadder_wr
add wave -noupdate -expand -group RF /tb_dp/DP_Ports/RFin
add wave -noupdate -expand -group RF /tb_dp/DP_Ports/RFout
add wave -noupdate -expand -group RF /tb_dp/DP_Ports/RF_dataout
add wave -noupdate /tb_dp/DP_Ports/OPCin
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/st
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/ld
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/mov
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/done_signal
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/add
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/sub
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/jmp
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/jc
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/jnc
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/and_o
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/or_o
add wave -noupdate -group {OPC signals} /tb_dp/DP_Ports/xor_o
add wave -noupdate /tb_dp/DP_Ports/Imm1_in
add wave -noupdate /tb_dp/DP_Ports/Imm2_in
add wave -noupdate -group ALU /tb_dp/DP_Ports/Ain
add wave -noupdate -group ALU /tb_dp/DP_Ports/ALUFN
add wave -noupdate -group ALU /tb_dp/DP_Ports/A
add wave -noupdate -group FLAGS /tb_dp/DP_Ports/Cflag
add wave -noupdate -group FLAGS /tb_dp/DP_Ports/Zflag
add wave -noupdate -group FLAGS /tb_dp/DP_Ports/Nflag
add wave -noupdate /tb_dp/DP_Ports/memEn
add wave -noupdate /tb_dp/DP_Ports/writeAddr
add wave -noupdate /tb_dp/DP_Ports/readAddr
add wave -noupdate -group {BUS A+B} /tb_dp/DP_Ports/BUS_B
add wave -noupdate -group {BUS A+B} /tb_dp/DP_Ports/BUS_A
add wave -noupdate /tb_dp/DP_Ports/F1_in
add wave -noupdate /tb_dp/DP_Ports/F2_in
add wave -noupdate /tb_dp/DP_Ports/F1_out
add wave -noupdate /tb_dp/DP_Ports/F2_out
add wave -noupdate /tb_dp/DP_Ports/DM_out
add wave -noupdate /tb_dp/DP_Ports/DmemEn
add wave -noupdate /tb_dp/DP_Ports/WmemData
add wave -noupdate /tb_dp/DP_Ports/WmemAddr
add wave -noupdate /tb_dp/DP_Ports/RmemAddr
add wave -noupdate -expand -group IR /tb_dp/DP_Ports/IRin
add wave -noupdate -expand -group IR /tb_dp/DP_Ports/IR_Imm8
add wave -noupdate -expand -group IR /tb_dp/DP_Ports/IR_Imm4
add wave -noupdate -childformat {{/tb_dp/DP_Ports/RF_1/sysRF(1) -radix decimal} {/tb_dp/DP_Ports/RF_1/sysRF(2) -radix decimal} {/tb_dp/DP_Ports/RF_1/sysRF(3) -radix decimal} {/tb_dp/DP_Ports/RF_1/sysRF(4) -radix decimal}} -subitemconfig {/tb_dp/DP_Ports/RF_1/sysRF(1) {-height 15 -radix decimal -radixshowbase 0} /tb_dp/DP_Ports/RF_1/sysRF(2) {-height 15 -radix decimal -radixshowbase 0} /tb_dp/DP_Ports/RF_1/sysRF(3) {-height 15 -radix decimal -radixshowbase 0} /tb_dp/DP_Ports/RF_1/sysRF(4) {-height 15 -radix decimal -radixshowbase 0}} /tb_dp/DP_Ports/RF_1/sysRF
add wave -noupdate -radix hexadecimal -radixshowbase 0 /tb_dp/DP_Ports/Prog_mem/RmemData
add wave -noupdate /tb_dp/DP_Ports/Prog_mem/sysRAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4850000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
configure wave -valuecolwidth 122
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2454655 ps} {10237386 ps}
