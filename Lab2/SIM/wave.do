onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Orange Red} /tb/rst
add wave -noupdate -color Gold /tb/clk
add wave -noupdate -color Magenta /tb/repeat
add wave -noupdate -color {Lime Green} -radix decimal -radixshowbase 0 /tb/upperBound
add wave -noupdate -color Cyan -radix decimal -radixshowbase 0 /tb/count
add wave -noupdate -color Yellow /tb/busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42094 ps} 0}
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
WaveRestoreZoom {0 ps} {1813950 ps}
