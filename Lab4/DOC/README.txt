LAB4 – FPGA Based Digital Design
By: Shahar Golombek and Liron Adi


This lab implements a synchronous digital system (ALU+PWM) based on LAB1, synthesized for the FPGA. 
The design focuses on performance and logic utilization.

ALU+PWM Description:
Inputs:
- X, Y: data inputs
- ALUFN[4:0]: Function code
- ALUFN[4:3]: module selector (PWM, Arithmetic, Shifter, Logic)
- 00: PWM 
- 01: Adder/Subtractor
- 10: Shifter
- 11: Logic

Outputs:
- ALUout: operation result
- PWM signal
- Flags: Z (Zero), C (Carry), N (Negative), V(overflow)

Modules
- Arithmetic.vhd: Adds, subtracts, or negates input using full adders
- Shifter.vhd: Barrel shifter, left/right shift based on ALUFN
- Logic.vhd: Bitwise logic operations (e.g., AND, OR, XOR)
- FA.vhd: Full Adder unit
- ALU: Connect between the ALU models:  Arithmetic, Shifter, Logic. Use to select the function
- PWM: 3 Modes of PWM signal
- top_PWM: Higher level of the PWM - use to select the mode
- Digital_System.vhd: Top-level Connect between the two Models : Top_PWM and ALU
- GPIO.vhd: For hardware test with board I/O

 Test Cases
- Performance Test: (TB) ALU placed between two DFFs for timing analysis - check several functions
- Hardware Test: Implemented on DE10-Standard FPGA using switches, keys, LEDs, and 7-segment displays
