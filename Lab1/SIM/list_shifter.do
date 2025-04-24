onerror {resume}
add list -width 15 /tb_shifter/Y
add list /tb_shifter/X
add list /tb_shifter/ALUFN
add list /tb_shifter/ALUout
add list /tb_shifter/Nflag
add list /tb_shifter/Cflag
add list /tb_shifter/Zflag
add list /tb_shifter/Vflag
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
