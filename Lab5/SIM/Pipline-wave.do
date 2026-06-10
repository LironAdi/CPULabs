onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB -radix hexadecimal /mips_tb/rst_tb_i
add wave -noupdate -group TB -radix hexadecimal /mips_tb/clk_tb_i
add wave -noupdate -group TB -radix hexadecimal /mips_tb/alu_result_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/Branch_ctrl_equal_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/Branch_ctrl_not_equal_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/instruction_top_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/MemWrite_ctrl_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/pc_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/RegWrite_ctrl_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/Zero_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/read_data1_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/read_data2_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/write_data_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/mclk_cnt_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/inst_cnt_tb_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/switches
add wave -noupdate -group TB -radix hexadecimal /mips_tb/STCNT_o
add wave -noupdate -group TB -radix hexadecimal /mips_tb/FHCNT_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/rst_i
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/clk_i
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/BPADDR_i
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/STCNT_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/FHCNT_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/pc_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_result_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/read_data1_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/read_data2_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/write_data_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/instruction_top_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Branch_ctrl_equal_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Branch_ctrl_not_equal_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Zero_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/MemWrite_ctrl_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/RegWrite_ctrl_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mclk_cnt_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/inst_cnt_o
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/pc_plus4_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/pc_plus4_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/instruction_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/instruction_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/instruction_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/read_data1_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/read_data1_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/read_data2_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/read_data2_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/sign_extend_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/sign_extend_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/ForwardA_EX
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/ForwardB_EX
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/ForwardA_ID
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/ForwardB_ID
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/WriteData_toMEM_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/WriteData_toMEM_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/addr_res_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/equal_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_result_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_result_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_result_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/write_reg_addr_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/write_reg_addr_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/write_reg_addr_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/dtcm_data_rd_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/dtcm_data_rd_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_op_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_op_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/reg_dst_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/reg_dst_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_src_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/alu_src_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/branch_BNE_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/branch_BEQ_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mem_write_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mem_write_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mem_write_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mem_read_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mem_read_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mem_read_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/jump_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/jump_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/MemtoReg_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/MemtoReg_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/MemtoReg_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/MemtoReg_w4
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/reg_write_w1
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/reg_write_w2
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/reg_write_w3
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/reg_write_w4
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Write_data_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Mclk_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/mclk_cnt_q
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/STCNT_q
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/FHCNT_q
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/inst_cnt_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Flush_IF_w
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Hazard
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/Branch_on
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/BPADDR_W
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/trigger
add wave -noupdate -group CORE -radix hexadecimal /mips_tb/CORE/pc_w
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/clk_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/rst_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/add_result_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/read_data1_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/Branch_ctrl_equal_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/Branch_ctrl_not_equal_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/Equal_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/PCWriteDisable
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/instruction_ID
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/JUMP_ctrl_i
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/Flush
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/Branch_on
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/pc_o
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/pc_plus4_o
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/instruction_o
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/inst_cnt_o
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/pc_q
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/pc_plus4_r
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/itcm_addr_w
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/next_pc_w
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/Mux_Branch
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/rst_flag_q
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/inst_cnt_q
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/pc_prev_q
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/jump_addr
add wave -noupdate -expand -group Ifetch -radix hexadecimal /mips_tb/CORE/IFE/instruction
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/wren_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/wren_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/rden_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/rden_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/data_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/data_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/address_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/address_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clock0
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clock1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken0
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken2
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken3
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/aclr0
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/aclr1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/addressstall_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/addressstall_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/byteena_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/byteena_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/q_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/q_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/eccstatus
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_reg_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_reg_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp2_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_wren_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp2_wren_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_wren_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp2_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_output_latch
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_ecc_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_ecc_tmp_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_current_written_data_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_original_data_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_original_data_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a_x
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b_x
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a_out
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b_out
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a_out_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b_out_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_reg_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wren_reg_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wren_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_rden_reg_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_rden_reg_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_read_flag_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_read_flag_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag2_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag2_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_write_flag_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_write_flag_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_nmram_write_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_nmram_write_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_indata_aclr_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_aclr_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wrcontrol_aclr_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_indata_aclr_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_aclr_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wrcontrol_aclr_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_aclr_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_aclr_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_rdcontrol_aclr_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_aclr_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_aclr_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/good_to_go_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/good_to_go_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b0
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_inclocken0
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_input_clocken_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_clken_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_clken_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outlatch_clken_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outlatch_clken_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_a_reg
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b_reg
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/default_val
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_zero_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_zero_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_ones_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_ones_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/same_clock_pulse0
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/same_clock_pulse1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_a1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_b1
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_signal_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_signal_b
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_good_to_write_a
add wave -noupdate -group {inst memory} -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_good_to_write_b
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/opcode_i
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/func_i
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/Branch_on
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/RegDst_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/JUMP_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/ALUSrc_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/MemtoReg_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/RegWrite_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/MemRead_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/MemWrite_ctrl_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/Branch_ctrl_equal_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/Branch_ctrl_not_equal_o
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/Flush_IF
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/ALUOp_ctrl
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/rtype_w
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/lw_w
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/sw_w
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/beq_w
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/bne_w
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/itype_imm_w
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/jump_J
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/jump_JAL
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/jump_R
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/Shift
add wave -noupdate -group control -radix hexadecimal /mips_tb/CORE/CTL/mul_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/read_data1_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/read_data2_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/sign_extend_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/ALUOp_ctrl_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/ALUSrc_ctrl_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/RegDst_ctrl_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/instruction_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/Write_data_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/alu_res_MEM_i
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/ForwardA
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/ForwardB
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/write_reg_addr_o
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/WriteData_toMEM
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/alu_res_o
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/a_input_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/b_input_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/shifter_res
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/alu_out_mux_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/alu_ctl_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/Shiftside
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/rt_register_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/shmat_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/rd_register_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/funct_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/opc_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/Temp_b_mux_w
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/do_shift/x
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/do_shift/y
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/do_shift/Shift_ctrl
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/do_shift/s
add wave -noupdate -group Execute -radix hexadecimal -childformat {{/mips_tb/CORE/EXE/do_shift/row(31) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(30) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(29) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(28) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(27) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(26) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(25) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(24) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(23) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(22) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(21) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(20) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(19) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(18) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(17) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(16) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(15) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(14) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(13) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(12) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(11) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(10) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(9) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(8) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(7) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(6) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(5) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(4) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(3) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(2) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(1) -radix hexadecimal} {/mips_tb/CORE/EXE/do_shift/row(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/EXE/do_shift/row(31) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(30) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(29) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(28) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(27) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(26) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(25) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(24) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(23) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(22) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(21) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(20) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(19) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(18) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(17) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(16) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(15) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(14) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(13) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(12) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(11) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(10) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/do_shift/row(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/EXE/do_shift/row
add wave -noupdate -group Execute -radix hexadecimal /mips_tb/CORE/EXE/do_shift/q
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/write_reg_addr_MEM
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/write_reg_addr_WB
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/RegWrite_MEM
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/RegWrite_WB
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/memwrite_EX
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/rt_register_EX
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/rt_register_ID
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/rs_register_EX
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/rs_register_ID
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/ForwardA_EX
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/ForwardB_EX
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/ForwardA_ID
add wave -noupdate -group Forwarding -radix hexadecimal /mips_tb/CORE/Forwarding/ForwardB_ID
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/instruction_ID
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/write_reg_addr_EX
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/write_reg_addr_MEM
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/MemRead_EX
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/MemRead_MEM
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/regwrite_EX
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/HAZARD
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/rs_register_ID
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/rt_register_ID
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/opcode_ID
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/func_ID
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/I_type
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/HAZARD1
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/HAZARD2
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/HAZARD3
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/HAZARD4
add wave -noupdate -group Stall -radix hexadecimal /mips_tb/CORE/Stall1/HAZARD5
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/clk_i
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/rst_i
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/dtcm_addr_i
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/dtcm_data_wr_i
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/MemRead_ctrl_i
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/MemWrite_ctrl_i
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/dtcm_data_rd_o
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/wrclk_w
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/wren_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/wren_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/rden_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/rden_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/data_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/data_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/address_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/address_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clock0
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clock1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken0
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken2
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken3
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/aclr0
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/aclr1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/addressstall_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/addressstall_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/byteena_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/byteena_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/q_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/q_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/eccstatus
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_reg_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_reg_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp2_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_wren_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp2_wren_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_wren_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp2_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_output_latch
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_ecc_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_ecc_tmp_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_current_written_data_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_original_data_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_original_data_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a_x
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b_x
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a_out
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b_out
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a_out_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b_out_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_reg_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wren_reg_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wren_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_rden_reg_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_rden_reg_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_read_flag_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_read_flag_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag2_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag2_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_write_flag_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_write_flag_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_nmram_write_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_nmram_write_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_indata_aclr_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_aclr_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wrcontrol_aclr_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_indata_aclr_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_aclr_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wrcontrol_aclr_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_aclr_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_aclr_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_rdcontrol_aclr_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_aclr_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_aclr_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/good_to_go_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/good_to_go_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b0
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_inclocken0
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_input_clocken_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_clken_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_clken_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outlatch_clken_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outlatch_clken_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_a_reg
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b_reg
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/default_val
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_zero_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_zero_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_ones_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_ones_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/same_clock_pulse0
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/same_clock_pulse1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_a1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_b1
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_signal_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_signal_b
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_good_to_write_a
add wave -noupdate -group MEM -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_good_to_write_b
add wave -noupdate -expand -group Idecode /mips_tb/CORE/ID/clk_i
add wave -noupdate -expand -group Idecode /mips_tb/CORE/ID/rst_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/instruction_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/dtcm_data_rd_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/alu_result_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/pc_plus4_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/RegWrite_ctrl_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/MemtoReg_ctrl_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/jump_ctrl_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/alu_res_MEM_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/ForwardA
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/ForwardB
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/write_reg_addr_i
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/read_data1_o
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/read_data2_o
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/addr_res_o
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/equal_o
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/write_reg_data_o
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/sign_extend_o
add wave -noupdate -expand -group Idecode -radix hexadecimal -childformat {{/mips_tb/CORE/ID/RF_q(0) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(1) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(2) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(3) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(4) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(5) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(6) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(7) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(8) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(9) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(10) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(11) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(12) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(13) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(14) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(15) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(16) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(17) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(18) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(19) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(20) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(21) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(22) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(23) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(24) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(25) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(26) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(27) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(28) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(29) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(30) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(31) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/ID/RF_q(0) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(10) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(11) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(12) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(13) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(14) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(15) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(16) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(17) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(18) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(19) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(20) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(21) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(22) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(23) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(24) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(25) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(26) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(27) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(28) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(29) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(30) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/RF_q(31) {-height 15 -radix hexadecimal}} /mips_tb/CORE/ID/RF_q
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/write_reg_data_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/write_reg_data_t
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/rs_register_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/rt_register_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/imm_value_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/write_reg_addr_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/sign_extend_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/branch_addr_r_w
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/read_data_mux1
add wave -noupdate -expand -group Idecode -radix hexadecimal /mips_tb/CORE/ID/read_data_mux2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30767531 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 349
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
WaveRestoreZoom {3990339 ps} {6105772 ps}
