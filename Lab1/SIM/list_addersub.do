onerror {resume}
add list -width 16 /tb_addersub/Y
add list /tb_addersub/X
add list /tb_addersub/ALUFN
add list /tb_addersub/ALUout
add list /tb_addersub/Nflag
add list /tb_addersub/Cflag
add list /tb_addersub/Zflag
add list /tb_addersub/Vflag
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
