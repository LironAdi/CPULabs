onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Inputs -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/clk
add wave -noupdate -expand -group Inputs -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/en
add wave -noupdate -expand -group Inputs -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/rst
add wave -noupdate -expand -group Inputs -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/ALUFN_i
add wave -noupdate -expand -group Inputs -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/Y_i
add wave -noupdate -expand -group Inputs -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/X_i
add wave -noupdate -expand -group Flags -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/X_i
add wave -noupdate -expand -group Flags -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/Nflag_o
add wave -noupdate -expand -group Flags -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/Cflag_o
add wave -noupdate -expand -group Flags -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/Zflag_o
add wave -noupdate -expand -group Flags -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/Vflag_o
add wave -noupdate -expand -group Outputs -color Turquoise -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/PWM_out
add wave -noupdate -expand -group Outputs -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/ALUout_o
add wave -noupdate -expand -group Outputs -color Gold -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/res_Arithmetic
add wave -noupdate -expand -group Outputs -color {Blue Violet} -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/res_shifter
add wave -noupdate -expand -group Outputs -color Firebrick -radix hexadecimal /tb_digital_system/Digital_System_ports/ALU_unit/res_logic
add wave -noupdate -expand -group {PWM Modes} -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/Mode0
add wave -noupdate -expand -group {PWM Modes} -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/Mode2
add wave -noupdate -expand -group {PWM Modes} -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/Mode1
add wave -noupdate -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/EQUY
add wave -noupdate -radix hexadecimal /tb_digital_system/Digital_System_ports/top_pwm_unit/PWM_ports/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {365 ps} 0}
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
WaveRestoreZoom {347280 ps} {2122970 ps}
