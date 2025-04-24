onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gray75 /tb_shifter/Y
add wave -noupdate -color {Spring Green} /tb_shifter/X
add wave -noupdate -color {Orange Red} /tb_shifter/ALUFN
add wave -noupdate -color Yellow /tb_shifter/ALUout
add wave -noupdate -color Magenta /tb_shifter/Nflag
add wave -noupdate -color {Slate Blue} /tb_shifter/Cflag
add wave -noupdate -color Pink /tb_shifter/Zflag
add wave -noupdate -color Coral /tb_shifter/Vflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {300000 ps} 0}
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
WaveRestoreZoom {0 ps} {674912 ps}
