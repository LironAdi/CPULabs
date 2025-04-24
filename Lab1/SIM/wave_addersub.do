onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Yellow /tb_addersub/Y
add wave -noupdate -color Red /tb_addersub/X
add wave -noupdate -color Magenta /tb_addersub/ALUFN
add wave -noupdate /tb_addersub/ALUout
add wave -noupdate -color Cyan /tb_addersub/Nflag
add wave -noupdate -color Gray90 /tb_addersub/Cflag
add wave -noupdate -color {Slate Blue} /tb_addersub/Zflag
add wave -noupdate -color {Medium Sea Green} /tb_addersub/Vflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {778136 ps}
