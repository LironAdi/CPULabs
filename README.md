# CPULabs

CPULabs is a collection of VHDL laboratory assignments focused on CPU architecture, digital logic design, simulation, FPGA implementation, and system-level processor design.

The repository follows a gradual learning flow: it begins with basic arithmetic and logic hardware blocks, continues through counters and control logic, progresses into simple and pipelined processor architectures, and ends with a MIPS-based MCU/SoC that integrates memory-mapped peripherals and FPGA-based hardware execution.

---

## Project Goals

The main goals of this repository are:

- Design digital hardware modules using VHDL.
- Understand how arithmetic, logic, and shifting units are built and tested.
- Build control logic using finite state machines.
- Implement and verify CPU datapath and control components.
- Simulate digital systems using testbenches.
- Synthesize designs for FPGA hardware.
- Explore single-cycle, multi-cycle, and pipelined processor architectures.
- Integrate CPU logic with memory, GPIO, interrupts, and hardware accelerators.

---

## Repository Structure

```text
CPULabs/
│
├── Lab1/
│   ├── DOC/
│   ├── DUT/
│   ├── SIM/
│   └── TB/
│
├── Lab2/
│   ├── DOC/
│   ├── DUT/
│   ├── SIM/
│   └── TB/
│
├── Lab3/
│   ├── DOC/
│   ├── DUT/
│   ├── SIM/
│   └── TB/
│
├── Lab4/
│   ├── DOC/
│   ├── DUT/
│   ├── Quartus/
│   ├── SIM/
│   └── TB/
│
├── Lab5/
│   ├── CODE/
│   ├── DOC/
│   ├── Quartus/
│   ├── SIM/
│   ├── TB/
│   └── VHDL/
│
├── FinalProject/
│   ├── DOC/
│   ├── DUT/
│   ├── QUARTUS/
│   ├── SIM/
│   └── TB/
│
└── LICENSE
```

---

## General Lab Structure

Most labs are organized using the following folders:

- `DOC` – documentation, reports, design descriptions, or README files.
- `DUT` – Design Under Test: the main VHDL implementation files.
- `TB` – testbench files used to verify the design behavior.
- `SIM` – simulation-related files and outputs.
- `Quartus` / `QUARTUS` – FPGA project files used for synthesis, implementation, and hardware testing.

This structure separates the hardware design from its verification environment and documentation, which makes the repository easier to understand, simulate, and extend.

---

# Labs Description

---

## Lab 1 – ALU Micro-Architecture

Lab 1 implements the first major computational building block: an Arithmetic Logic Unit (ALU). The design is divided into three main submodules: an adder/subtractor unit, a shifter, and a Boolean logic unit.

The lab demonstrates how a function-select input can control different hardware operations. The `ALUFN` control signal selects whether the system performs arithmetic operations, shift operations, or bitwise logic operations.

Main implemented operations include:

- Addition and subtraction
- Negation
- Increment and decrement
- Shift left and shift right
- NOT, OR, AND, XOR, NOR, NAND, and XNOR
- Status flag generation: zero, carry, negative, and overflow

This lab is important because the ALU is a central component in almost every processor. It teaches how low-level combinational hardware blocks can be connected together and selected using control signals.

---

## Lab 2 – Counter-Based Synchronous Digital System

Lab 2 implements a synchronous digital system based on two counters: a fast counter and a slow counter. The counters are controlled by a combinational control unit and operate according to a clock, reset, repeat input, and upper-bound value.

The fast counter increments until it reaches the current slow-counter value. At that point, the fast counter resets and the slow counter increments. When the slow counter reaches the upper bound, the system either restarts or stops depending on the repeat input.

Main concepts covered in this lab:

- Synchronous sequential logic
- Counter design
- Reset behavior
- Control logic
- Busy/active indication
- Generic parameterization of bit width
- Interaction between datapath and control logic

This lab strengthens the connection between datapath elements and control decisions. It shows how digital systems can be designed as a set of registers, counters, and control signals operating together over multiple clock cycles.

---

## Lab 3 – Simple Multi-Cycle RISC Processor

Lab 3 implements a simple RISC multi-cycle processor in VHDL. The processor is controlled by an FSM and executes instructions over multiple clock cycles.

The design includes the main components of a basic CPU:

- Program Counter (PC)
- Instruction Memory
- Instruction Register (IR)
- Opcode Decoder
- Register File
- ALU
- Data Memory
- Datapath
- FSM-based Control Unit

The processor supports arithmetic, logical, memory, movement, and branch/jump-related operations. The ALU supports operations such as ADD, SUB, AND, OR, XOR, and PASS B. The opcode decoder identifies instructions such as load, store, move, arithmetic operations, and conditional or unconditional jumps.

The lab demonstrates the difference between a single combinational hardware block and a complete processor architecture. It shows how instruction fetch, decode, execute, memory access, and write-back behavior can be sequenced by a control unit across several clock cycles.

---

## Lab 4 – FPGA-Based ALU and PWM Digital System

Lab 4 takes the ALU concept from Lab 1 and expands it into an FPGA-oriented digital system. The design combines an ALU with a PWM module and prepares the system for synthesis and hardware testing on an FPGA board.

The `ALUFN` control signal is used to select between several functional blocks:

- PWM mode
- Arithmetic operations
- Shift operations
- Logic operations

The system includes hardware-oriented modules such as:

- Arithmetic unit
- Shifter
- Logic unit
- Full adder
- ALU top-level integration
- PWM module
- Top-level PWM selection
- Digital system top level
- GPIO interface for board testing

This lab focuses not only on functional correctness but also on FPGA implementation, timing, resource usage, and hardware verification. It demonstrates how a simulated VHDL design can be moved toward real hardware execution using switches, keys, LEDs, and 7-segment displays.

---

## Lab 5 – 5-Stage Pipelined MIPS Processor

Lab 5 implements a 5-stage pipelined MIPS processor in VHDL. The processor follows the classic pipeline structure:

1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Memory Access (MEM)
5. Write Back (WB)

The lab includes pipeline control mechanisms such as hazard detection, forwarding, stalls, and branch flushing. These mechanisms are required because multiple instructions are active at the same time in different pipeline stages.

Main modules include:

- `IFETCH.vhd` – instruction fetch stage
- `IDECODE.vhd` – instruction decode and register file stage
- `EXECUTE.vhd` – ALU and execution stage
- `DMEMORY.vhd` – data memory interface
- `CONTROL.vhd` – control signal generation
- `StallUnit.vhd` – hazard detection and stall logic
- `ForwardingUnit.vhd` – data forwarding logic
- `MIPS.vhd` – top-level processor integration

This lab is a major step forward from the multi-cycle processor. Instead of completing one instruction at a time, the pipelined processor improves throughput by overlapping the execution of multiple instructions. The lab highlights the architectural challenges that appear when pipelining is introduced.

---

# Final Project – MIPS-Based MCU / SoC with Memory-Mapped I/O

The final project integrates the CPU design concepts into a larger MIPS-based microcontroller system. The system is implemented as a single-clock SoC with a 32-bit address/data bus and memory-mapped I/O peripherals.

The project includes:

- MIPS-like CPU
- Memory-mapped I/O space
- GPIO interface
- LED and 7-segment display output
- Key/button input
- Interrupt controller
- FIR hardware accelerator
- Basic timer
- PWM output
- FPGA synthesis and hardware testing

The CPU communicates with peripherals through a shared address/data bus. Peripheral access is performed using memory-mapped addresses, meaning that hardware devices are controlled by reading from or writing to specific memory addresses.

The final project demonstrates how a CPU can be extended into a complete embedded processing system. It connects processor architecture, memory organization, peripheral control, interrupts, and FPGA deployment into one integrated design.

---

## Main Technical Concepts

This repository demonstrates the following technical topics:

- VHDL hardware description
- Combinational logic design
- Sequential logic design
- ALU design
- Counter-based systems
- Finite State Machines
- Datapath and control separation
- Multi-cycle CPU architecture
- MIPS architecture basics
- Pipeline stages
- Forwarding and stall logic
- Hazard detection
- Branch flushing
- Memory-mapped I/O
- Interrupt handling
- GPIO and external FPGA I/O
- FIR accelerator integration
- Testbench-based verification
- FPGA synthesis using Quartus

---

## Development Environment

The project was developed using:

- **Language:** VHDL
- **Simulation:** VHDL testbenches and simulation files
- **FPGA tools:** Quartus
- **Target hardware:** FPGA platform, including DE10-Standard style board interaction in the FPGA-based labs
- **Design focus:** CPU architecture, digital system design, simulation, and hardware implementation

---

## How to Use

1. Clone the repository:

```bash
git clone https://github.com/LironAdi/CPULabs.git
```

2. Open the relevant lab folder.

3. Review the `DOC` folder to understand the design goal.

4. Open the `DUT` or `VHDL` folder to inspect the implementation files.

5. Use the `TB` folder to run simulations and verify the design.

6. For FPGA-based labs, open the relevant `Quartus` or `QUARTUS` project folder and synthesize the design.

---

## Labs Summary

| Lab | Main Topic | Description |
|---|---|---|
| Lab 1 | ALU Micro-Architecture | Arithmetic, shifting, Boolean logic, and status flags |
| Lab 2 | Counter System | Fast/slow counters, upper-bound control, repeat behavior, and busy logic |
| Lab 3 | Multi-Cycle RISC Processor | CPU datapath, control FSM, instruction decoding, register file, memory, and ALU |
| Lab 4 | FPGA ALU + PWM System | FPGA implementation of ALU/PWM system with GPIO-based board testing |
| Lab 5 | Pipelined MIPS Processor | 5-stage pipeline with forwarding, stall logic, hazards, and branch handling |
| Final Project | MIPS-Based MCU / SoC | MIPS-like CPU with memory-mapped I/O, interrupts, GPIO, FIR accelerator, timer, and PWM |

---

## Summary

CPULabs documents a complete learning path in digital CPU design. The labs begin with fundamental building blocks such as ALUs, counters, and control logic, then progress into complete processor designs and finally into an FPGA-based MIPS microcontroller system with peripherals and hardware acceleration.

The repository is useful for understanding how digital hardware modules are built, verified, connected into a processor datapath, controlled by FSMs, and deployed to FPGA hardware.

---

## License

This repository is licensed under the MIT License.
