onerror {resume}
add list -width 11 /tb_sys/Y
add list /tb_sys/X
add list /tb_sys/ALUFN
add list /tb_sys/ALUout
add list /tb_sys/Nflag
add list /tb_sys/Cflag
add list /tb_sys/Zflag
add list /tb_sys/Vflag
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
