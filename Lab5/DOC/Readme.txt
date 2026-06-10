MIPS Pipelined Processor Project

This repository contains a VHDL implementation of a 5-stage pipelined MIPS processor. The design follows the standard stages (IF, ID, EX, MEM, WB) and includes hazard detection, forwarding, and branch/flush mechanisms.


This project implements a 5-stage pipelined MIPS CPU in VHDL, targeting an FPGA platform. It supports the following features:

	-Instruction Fetch (IF)

	-Instruction Decode and Register File (ID)

	-Execute (ALU control and ALU operations) (EX)

	-Memory Access (MEM)

	-Write Back (WB)


HAZARD:

	-Forwarding unit

	-Stall unit


IFETCH.vhd                                    - Instruction Fetch stage
IDECODE.vhd                                - Instruction Decode stage
EXECUTE.vhd                                - Execute stage (ALU, branch adder, shifter)
DMEMORY.vhd                             - Data memory interface
StallUnit.vhd                                 - Hazard detection and stall logic
ForwardingUnit.vhd                      - Forwarding logic
CONTROL.vhd                               - Control signals generator
MIPS.vhd                                       - Top-level structural integration of all stages
aux_package.vhd                          - Auxiliary package definitions
cond_comilation_package.vhd     - Conditional compilation package
const_package.vhd                        - Constant definitions package
PLL.vhd                                           - Phase-Locked Loop component
Shifter.vhd                                      - Barrel shifter logic
