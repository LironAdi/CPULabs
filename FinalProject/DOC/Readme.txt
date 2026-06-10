in the work we built a MIPS-based MCU that runs as a single-cycle system. Put the peripherals on a memory-mapped I/O space (use the lower 12 address bits). Add a GPIO so the CPU can read the switches and show values on the LEDs and 7-segment displays. In the end, compile, simulate, load to the FPGA, and check timing and behavior.

---
# MIPS + FIR SoC – Quick README (Short)

## System (one paragraph)

Single‑clock SoC: MIPS‑like CPU on a 32‑bit `Address_Bus`/`Data_Bus` with `memRead`/`memWrite`. I/O is memory‑mapped. FIR accelerator + GPIO + interrupt controller live in the same I/O space. External reset is **active‑low** (`reset`), internally used as active‑high (`reset_i`). Keys are **active‑low**; HEX segments are **active‑low**.


----------------Keys&HEX----------------------

Keys -buttons:

KEY0 =system reset, external active
KEY1, KEY2, KEY3= user buttons
KEY1 => irq(3)
KEY2 → irq(4)
KEY3 → irq(5)

HEX:

6 HEX: HEX5 HEX4 HEX3 HEX2 HEX1 HEX0.
Each digit has 7 segments 
the following data will active the hex:
HEX0 — write to 0x804: loads Data_in(3 downto 0) (low nibble).
HEX1 — write to 0x805: loads Data_in(7 downto 4) (high nibble).
HEX2 — write to 0x808: loads Data_in(3 downto 0).
HEX3 — write to 0x809: loads Data_in(7 downto 4).
HEX4 — write to 0x80C: loads Data_in(3 downto 0).
HEX5 — write to 0x80D: loads Data_in(7 downto 4).
---
FIR:
A memory‑mapped FIR filter with an internal FIFO. The CPU writes coefficients and input samples,
the FIR multiplies and sums the last M samples, and the result is available to read. 
The block can also raise an interrupt when a new result is ready.

Clocks/Reset/Enable: clk_FIR, rst_FIR, en_FIR, rst_global.
CPU bus: Data bus-inout, address_in, MemWrite_DM_i, MemRead_DM_i.
App I/O:FIROUT-result, FIR_FIG-simple-enable flag
Interrupt/Status: FIRIFG-result‑ready pulse, FIFOEMPTY_IFGFIFO status

--------------------------------------------

Peripherals Block- 
connects the CPU bus to simple devices
irq(N-1:0) – vector of interrupt requests from devices (e.g., keys, FIR, UART)
GIE – Global Interrupt Enable from CPU
INTA – CPU interrupt acknowledge (used to clear/latch the served flag)
INTR – final interrupt line to CPU
PWM_out – pulse‑width modulation output


-----------------------------------------------








