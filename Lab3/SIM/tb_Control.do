onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Yellow /tb_control/clk
add wave -noupdate -expand -group Status -color Firebrick /tb_control/rst
add wave -noupdate -expand -group Status -color Cyan /tb_control/En
add wave -noupdate -expand -group Status /tb_control/st
add wave -noupdate -expand -group Status -color Magenta /tb_control/ld
add wave -noupdate -expand -group Status -color {Slate Blue} /tb_control/mov
add wave -noupdate -expand -group Status -color Blue /tb_control/done_signal
add wave -noupdate -expand -group Status -color Cyan /tb_control/add
add wave -noupdate -expand -group Status -color {Blue Violet} /tb_control/sub
add wave -noupdate -expand -group Status /tb_control/jmp
add wave -noupdate -expand -group Status -color {Dark Green} /tb_control/jc
add wave -noupdate -expand -group Status -color Thistle /tb_control/jnc
add wave -noupdate -expand -group Status -color Coral /tb_control/and_i
add wave -noupdate -expand -group Status -color Magenta /tb_control/or_i
add wave -noupdate -expand -group Status -color Goldenrod /tb_control/xor_i
add wave -noupdate -expand -group Status /tb_control/Cflag
add wave -noupdate -expand -group Status /tb_control/Zflag
add wave -noupdate -expand -group Status /tb_control/Nflag
add wave -noupdate /tb_control/IRin
add wave -noupdate /tb_control/RFin
add wave -noupdate /tb_control/RFout
add wave -noupdate /tb_control/Imm1_in
add wave -noupdate /tb_control/Imm2_in
add wave -noupdate /tb_control/Ain
add wave -noupdate /tb_control/PCin
add wave -noupdate /tb_control/DTCM_out
add wave -noupdate /tb_control/DTCM_addr_sel
add wave -noupdate /tb_control/DTCM_addr_out
add wave -noupdate /tb_control/DTCM_addr_in
add wave -noupdate /tb_control/DTCM_wr
add wave -noupdate /tb_control/RFaddr_rd
add wave -noupdate /tb_control/RFaddr_wr
add wave -noupdate /tb_control/PCsel
add wave -noupdate /tb_control/ALUFN
add wave -noupdate /tb_control/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1208058 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {43375039 ps}
