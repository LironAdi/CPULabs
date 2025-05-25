in this project we implemented a simple RISC multi-cycle, decoded by an FSM-controlled unit and executed by multiple clock cycles. 
------------------------------------------------------
-----------------ALU-----------------------------------
Arithmetic Logic Unit (ALU) capable of performing arithmetic and 
logic operations on two operands (A and B)
inputs:
A,B,ALFUN
Outputs
C, Cflag, Zflag, Nflag
Supported Operations (via ALUFN code):
0000: ADD
0001: SUB
0010: AND
0011: OR
0100: XOR
1111: PASS B
Status Flags:
Cflag:Carry-out
Zflag: Zero result
Nflag: Negative result (MSB = 1)

------------------------------------------------------
--------------------OPC decoder-----------------------

Input:
OPC
Outputs:
st:(OPC = "1110")
Id:(OPC = "1101")
mov:(OPC = "1100")
done_signal:(OPC = "1111")
add:(OPC = "0000")
sub:(OPC = "0001")
jmp:(OPC = "0111")
jc:(OPC = "1000")
jnc: Jump if no carry (OPC = "1001")
and_o:(OPC = "0010")
or_o:(OPC = "0011")
xor_o:(OPC = "0100")




------------------------------------------------
--------Data path-------------------------------
integrates all the components/ 

Program Counter (PCunit)
- Purpose: Holds the address of the next instruction.
- Inputs: `clk`, `PCin`, `PCsel`, `IR_Imm8`
- Output: `PC_out`

Instruction Memory (progMem)
- Purpose: Stores program instructions.
- Inputs: `clk`, `memEn`, `ITCM_tb_in`, `ITCM_tb_addr_in`, `PC_out`
- Output: `RmemData` (fetched instruction)

Instruction Register (IR)
- Purpose: Stores the current instruction and extracts fields.
- Inputs: `IRin`, `RFadder_rd`, `RFadder_wr`, `RmemData`
- Outputs: `writeAddr`, `readAddr`, `OPCin`, `IR_Imm4`, `IR_Imm8`

Opcode Decoder (OPCdec)
- Purpose: Decodes the opcode and generates control signals.
- Input: `OPCin`
- Outputs: `st`, `ld`, `mov`, `done_signal`, `add`, `sub`, `jmp`, `jc`, `jnc`, `and_o`, `or_o`, `xor_o`

Register File (RF)
- Inputs: `clk`, `rst`, `RFin`, `writeAddr`, `readAddr`
- Outputs: `RF_dataout`, `BUS_A`

Bidirectional Buffers
- Bidir_RF: Connects `RF_dataout` to `BUS_B` when `RFout` is high.
- Bidir_IM1, Bidir_IM2: Used for sign-extended immediate values.
- Bidir_DM: Connects data memory output to `BUS_B`.


-----------------------------------------------------------
------------Control----------------------------------------
responsible for orchestrating the data flow and sequencing operations 
through a Finite State Machine (FSM).

 Inputs
- `clk`, `rst`, `En`: Clock, reset, and enable signals 
- `st`, `ld`, `mov`, `done_signal`, `add`, `sub`, `jmp`, `jc`, `jnc`, `and_i`, `or_i`, `xor_i`
- `Cflag`, `Zflag`, `Nflag`: status flags 

 Outputs
 `IRin`, `RFin`, `RFout`, `Imm1_in`, `Imm2_in`, `Ain`, `PCin`, `DTCM_out`, `DTCM_addr_sel`, `DTCM_addr_out`, `DTCM_addr_in`, `DTCM_wr`.
 `RFaddr_rd`, `RFaddr_wr`.
 `PCsel`.
 `ALUFN`.
 `done`.
 states:
- `Reset`: Initializes system and sets PC to zero.
- `Fetch`: Loads the next instruction into the Instruction Register (IR).
- `Decode`: Determines instruction type and selects the execution path.
- `Execute1R`: Executes arithmetic or logic instructions using registers.
- `Execute1I`: Handles first stage of immediate-based operations (e.g., `ld`, `st`).
- `Execute2I`: immediate-based operations.
