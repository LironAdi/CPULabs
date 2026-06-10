# 1) Primary 50 MHz clock on clk_i
create_clock -name clk_i -period 20.000 [get_ports clk_i]

# 2) Pin assignment for clk_i
set_location_assignment PIN_AF14 -to clk_i

# 3) Apply input delays only to ports ending in “_i”
set_input_delay  -clock clk_i -max 2.5 [get_ports *_i]

# 4) Apply output delays only to ports ending in “_o”
set_output_delay -clock clk_i -max 2.5 [get_ports *_o]

# 5) Recognize all PLL-generated clocks
derive_pll_clocks

# 6) Kill timing on unused/internal clocks
set_false_path -to [get_clocks altera_reserved_tck]
set_false_path -to [get_clocks G0:Mclk\|altpll_component\|auto_generated\|generic_pll1~PLL_OUTPUT_COUNTER\|divclk]
