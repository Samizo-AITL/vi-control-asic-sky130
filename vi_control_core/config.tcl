# OpenLane config for vi_control_core (educational baseline)

set ::env(DESIGN_NAME) "top"
set ::env(VERILOG_FILES) [glob ../../rtl/*.v]
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "20.0"  ;# ns (50 MHz) conservative start

# Die / core settings (safe defaults)
set ::env(FP_CORE_UTIL) 50
set ::env(FP_ASPECT_RATIO) 1
set ::env(FP_PDN_MULTILAYER) 1

# IO placement (optional)
#set ::env(FP_PIN_ORDER_CFG) "./pin_order.cfg"

# Synthesis options
set ::env(SYNTH_STRATEGY) "DELAY 0"
set ::env(SYNTH_MAX_FANOUT) 8

# Routing options (safe defaults)
set ::env(ROUTING_CORES) 4

# If you have a specific top module name, keep DESIGN_NAME consistent.
