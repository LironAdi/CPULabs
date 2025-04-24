onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold /tb_logic/Y
add wave -noupdate -color Red /tb_logic/X
add wave -noupdate /tb_logic/ALUFN
add wave -noupdate -color Cyan /tb_logic/ALUout
add wave -noupdate -color {Spring Green} /tb_logic/Nflag
add wave -noupdate -color Magenta /tb_logic/Cflag
add wave -noupdate -color Gray60 /tb_logic/Zflag
add wave -noupdate -color Wheat /tb_logic/Vflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {140271 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {419295 ps}
