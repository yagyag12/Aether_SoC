#set ::env(DESIGN_NAME) "aether_soc"
#
#set ::env(VERILOG_FILES) "\
#    $::env(DESIGN_DIR)/src/rv32_core.v \
#    $::env(DESIGN_DIR)/src/device_sel.v \
#    $::env(DESIGN_DIR)/src/uart_top.v \
#    $::env(DESIGN_DIR)/src/uart_tx.v \
#    $::env(DESIGN_DIR)/src/uart_rx.v \
#    $::env(DESIGN_DIR)/src/baud_rate_generator.v \
#    $::env(DESIGN_DIR)/src/uart_regs.v \
#    $::env(DESIGN_DIR)/src/spi_top.v \
#    $::env(DESIGN_DIR)/src/spi_master.v \
#    $::env(DESIGN_DIR)/src/spi_slave.v \
#    $::env(DESIGN_DIR)/src/spi_regs.v \
#    $::env(DESIGN_DIR)/src/spi_regs.vh \
#    $::env(DESIGN_DIR)/src/timer_top.v \
#    $::env(DESIGN_DIR)/src/timers.v \
#    $::env(DESIGN_DIR)/src/timer_regs.v \
#    $::env(DESIGN_DIR)/src/gpio_regs.v \
#    $::env(DESIGN_DIR)/src/alu.v \
#    $::env(DESIGN_DIR)/src/decoder.v \
#    $::env(DESIGN_DIR)/src/branch_unit.v \
#    $::env(DESIGN_DIR)/src/instr_mem.v \
#    $::env(DESIGN_DIR)/src/data_mem.v \
#    $::env(DESIGN_DIR)/src/regfile.v \
#    $::env(DESIGN_DIR)/src/aether_soc.v"
#
#
#set ::env(TOP_MODULE) "aether_soc"
#
#
#set ::env(CLOCK_PORT) "clk"
#set ::env(CLOCK_PERIOD) "20.0"
#
## --- Synthesis ---
#set ::env(SYNTH_MAX_FANOUT) 10
#set ::env(SYNTH_BUFFERING) 1
#set ::env(SYNTH_SIZING)    1
#set ::env(SYNTH_STRATEGY) "DELAY 1"
#set ::env(SYNTH_ADDER_TYPE) "YOSYS"
#set ::env(SYNTH_HFNS) 1
#set ::env(SYNTH_NO_FLAT) 1
#set ::env(SYNTH_SHARE_RESOURCES) 1
#
## --- Floorplan ---
#set ::env(FP_CORE_UTIL) 50
#set ::env(DIE_AREA) "0 0 5000 5000"
##set ::env(FP_SIZING) "absolute"
#set ::env(FP_IO_MODE) 0
#set ::env(FP_PIN_ORDER_CFG) "$::env(DESIGN_DIR)/pin_order.cfg"
#
## --- Placement ---
#set ::env(PL_TARGET_DENSITY) 0.55
#set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
#set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
#set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
##set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 10
##set ::env(PL_RESIZER_MAX_CAP_MARGIN)  10
#set ::env(PL_RESIZER_BUFFER_INPUT_PORTS)  1
#set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 1
#set ::env(PL_RESIZER_REPAIR_TIE_FANOUT) 1
#set ::env(PL_CELL_PADDING) 1
#set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
#set ::env(GLB_RESIZER_BUFFER_INPUT_PORTS) 1
#
#set ::env(PDN_CFG) "$::env(DESIGN_DIR)/pdn.tcl"
#
#
## Routing sonrası ekstra optimization yapmasın
#set ::env(DRT_OPT_ITERS) 1
#set ::env(GRT_ALLOW_CONGESTION) 1

#
## --- CORE --- #
#set ::env(DESIGN_NAME) "rv32_core"
#set ::env(VERILOG_FILES) "\
#   $::env(DESIGN_DIR)/src/regfile.v \
#   $::env(DESIGN_DIR)/src/alu.v \
#   $::env(DESIGN_DIR)/src/decoder.v \
#   $::env(DESIGN_DIR)/src/branch_unit.v \
#   $::env(DESIGN_DIR)/src/rv32_core.v"
#
##set ::env(VERILOG_FILES_BLACKBOX) "$::env(DESIGN_DIR)/runs/imem_macro/results/final/verilog/gl/instr_mem.v"
#
#set ::env(TOP_MODULE) "rv32_core"
#set ::env(CLOCK_PORT) "clk"
#set ::env(CLOCK_PERIOD) "20.0"
#
## --- Synthesis ---
#set ::env(SYNTH_MAX_FANOUT) 10
#set ::env(SYNTH_BUFFERING) 1
#set ::env(SYNTH_SIZING)    1
#set ::env(SYNTH_STRATEGY) "DELAY 2"
#set ::env(SYNTH_ADDER_TYPE) "YOSYS"
#set ::env(SYNTH_NO_FLAT) 0
#set ::env(SYNTH_SHARE_RESOURCES) 1
#
## --- Floorplan ---
#set ::env(FP_CORE_UTIL) 55
#set ::env(DIE_AREA) "0 0 800 800"
#set ::env(FP_SIZING) "absolute"
#set ::env(FP_IO_MODE) 0
##set ::env(FP_PIN_ORDER_CFG) "$::env(DESIGN_DIR)/pin_order.cfg"
#
## --- Placement ---
#set ::env(PL_TARGET_DENSITY) 0.60
#set ::env(PL_BASIC_PLACEMENT) 0
#set ::env(PL_RESIZER_BUFFER_INPUT_PORTS)  1
#set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 1
#
#set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
#set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
#set ::env(GRT_RESIZER_DESIGN_OPTIMIZATIONS) 1
#set ::env(GRT_RESIZER_TIMING_OPTIMIZATIONS) 1
#set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 1
#
#set ::env(RUN_FILL_INSERTION) 1
#set ::env(RUN_TAP_DECAP_INSERTION) 1
#
#set ::env(PL_RESIZER_REPAIR_TIE_FANOUT) 1
#set ::env(PL_CELL_PADDING) 1
#
## --- Blackbox macro (instr_mem) ayarları ---
##set ::env(EXTRA_LEFS) "$::env(DESIGN_DIR)/runs/imem_macro/results/final/lef/instr_mem.lef"
#
#set ::env(PDN_CFG) "$::env(DESIGN_DIR)/pdn.tcl"



# --- CORE --- #
set ::env(DESIGN_IS_CORE) 0
set ::env(DESIGN_NAME) "aether_soc"
set ::env(VERILOG_FILES) "\
   $::env(DESIGN_DIR)/src/gpio_regs.vh \
   $::env(DESIGN_DIR)/src/gpio_regs.v \
   $::env(DESIGN_DIR)/src/device_sel.v \
   $::env(DESIGN_DIR)/src/aether_soc.v"

set ::env(SYNTH_READ_BLACKBOX_LIB) 0
set ::env(SYNTH_USE_PG_PINS_DEFINES) 0
set ::env(VERILOG_FILES_BLACKBOX) "\
    $::env(DESIGN_DIR)/runs/uart_macro/results/final/verilog/gl/uart_top.v \
    $::env(DESIGN_DIR)/runs/core_macro2/results/final/verilog/gl/rv32_core.v \
    $::env(DESIGN_DIR)/runs/spi_macro/results/final/verilog/gl/spi_top.v \
    $::env(DESIGN_DIR)/runs/timer_macro/results/final/verilog/gl/timer_top.v"

set ::env(EXTRA_LEFS) "\
    $::env(DESIGN_DIR)/runs/uart_macro/results/final/lef/uart_top.lef \
    $::env(DESIGN_DIR)/runs/core_macro2/results/final/lef/rv32_core.lef \
    $::env(DESIGN_DIR)/runs/spi_macro/results/final/lef/spi_top.lef \
    $::env(DESIGN_DIR)/runs/timer_macro/results/final/lef/timer_top.lef"

set ::env(EXTRA_GDS_FILES) "\
    $::env(DESIGN_DIR)/runs/uart_macro/results/final/gds/uart_top.gds \
    $::env(DESIGN_DIR)/runs/core_macro2/results/final/gds/rv32_core.gds \
    $::env(DESIGN_DIR)/runs/spi_macro/results/final/gds/spi_top.gds \
    $::env(DESIGN_DIR)/runs/timer_macro/results/final/gds/timer_top.gds"

set ::env(TOP_MODULE) "aether_soc"
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "20.0"

# --- Synthesis ---
set ::env(SYNTH_MAX_FANOUT) 10
set ::env(SYNTH_BUFFERING) 1
set ::env(SYNTH_SIZING)    1
set ::env(SYNTH_STRATEGY) "DELAY 2"
set ::env(SYNTH_ADDER_TYPE) "YOSYS"
set ::env(SYNTH_NO_FLAT) 0
set ::env(SYNTH_SHARE_RESOURCES) 1

# --- Floorplan ---
set ::env(FP_CORE_UTIL) 50
set ::env(DIE_AREA) "0 0 1500 1200"
set ::env(FP_SIZING) "absolute"
set ::env(FP_IO_MODE) "manual"

# --- Placement ---
set ::env(PL_TARGET_DENSITY) 0.55
set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS)  1
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GRT_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(GRT_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 1

set ::env(RUN_FILL_INSERTION) 1
set ::env(RUN_TAP_DECAP_INSERTION) 1

set ::env(PL_RESIZER_REPAIR_TIE_FANOUT) 1
set ::env(PL_CELL_PADDING) 1

set ::env(MACRO_PLACEMENT_CFG) "$::env(DESIGN_DIR)/macro_placement.cfg"
set ::env(PDN_CFG) "$::env(DESIGN_DIR)/pdn.tcl"
set ::env(FP_PIN_ORDER_CFG) "$::env(DESIGN_DIR)/pin_order.cfg"

set ::env(FP_PDN_CHECK_NODES) 0
set ::env(FP_PDN_ENABLE_MACROS_GRID) 1

set ::env(FP_PDN_MACRO_HOOKS) "spi0 VPWR VGND VPWR VGND"

set ::env(QUIT_ON_LVS_ERROR)