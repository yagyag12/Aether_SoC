        /////////////////////////////////////////////////////////
        /////           ---     AETHER SOC      ---         /////
        /////   Designed by Yagiz Yagmur                    /////
        /////   Version:    v1.0.0                          /////
        /////////////////////////////////////////////////////////
`timescale 1ns/1ps

module aether_soc (
    input           clk,
    input           rstn,
    input   [3:0]   gpio_sw,
    output  [3:0]   gpio_led,
    input   [11:0]  gpio_in,
    output  [11:0]  gpio_out,
    output          pwm_out,
    input           uart_rx,
    output          uart_tx,
    inout           spi_clk,
    inout           spi_miso,
    inout           spi_mosi,
    input           spi_slave_csn,
    output  [3:0]   spi_master_cs
);

//////////////     ---     PARAMETERS     ---     //////////////

localparam  MEM_SIZE = 2048;
localparam  MEM_FILE = "firmware/firmware.hex";     

//////////////     ---     SIGNALS     ---     //////////////

// Data Memory (RAM) Signals
wire    [31:0]  ram_rdata;      // RAM Read Data  
wire            ram_wen;        // RAM Write Enable
wire            ram_ren;        // RAM Read Enable
wire            ram_rvalid;     // RAM Read Valid

// Device Select Signals
wire    [31:0]  dmem_rdata;     // Read Data
wire            dmem_rvalid;    // Read Data Valid
wire            sel_mem;        // Memory Select Flag
wire            sel_gpio;       // GPIO   Select Flag
wire            sel_uart;       // UART   Select Flag
wire            sel_timer;      // Timer  Select Flag
wire            sel_spi;        // SPI    Select Flag

// RV32 Core Signals
wire    [31:0]  dmem_addr;      // Memory Address
wire    [31:0]  dmem_wdata;     // Write Data
wire    [ 3:0]  dmem_wmask;     // Write Mask
wire            dmem_wen;       // Write Enable
wire            dmem_ren;       // Read  Enable

// UART IP Signals
wire            uart_wen;       // UART WRITE ENABLE
wire            uart_ren;       // UART READ ENABLE
wire            uart_wready;    // UART WRITE READY
wire    [31:0]  uart_rdata;     // UART READ DATA
wire            uart_rvalid;    // UART READ VALID

// GPIO IP Signals
wire            gpio_wen;       // GPIO WRITE ENABLE
wire            gpio_wready;    // GPIO WRITE READY
wire            gpio_ren;       // GPIO READ ENABLE
wire    [31:0]  gpio_rdata;     // GPIO READ DATA
wire            gpio_rvalid;    // GPIO READ VALID
wire    [11:0]  gpio_dir;       // GPIO DIRECTION

// Timer Signals
wire            timer_wen;      // TIMER WRITE ENABLE
wire            timer_wready;   // TIMER WRITE READY
wire            timer_ren;      // TIMER READ ENABLE
wire    [31:0]  timer_rdata;    // TIMER READ DATA
wire            timer_rvalid;   // TIMER READ VALID

// SPI Signals
wire            spi_wen;        // SPI WRITE ENABLE
wire            spi_ren;        // SPI READ EANBLE
wire            spi_wready;     // SPI WRITE READY
wire    [31:0]  spi_rdata;      // SPI READ DATA
wire            spi_rvalid;     // SPI READ VALID

// IO Pipeline Registers
// IOs of the chip are registered here.
reg     [3:0]   gpio_sw_reg;        // GPIO SWITCH
reg     [3:0]   gpio_led_reg;       // GPIO LED
reg     [11:0]  gpio_in_reg;        // GPIO INPUTS
reg     [11:0]  gpio_out_reg;       // GPIO OUTPUTS
reg             pwm_out_reg;        // PWM OUTPUT
reg             uart_rx_reg;        // UART RX
reg             uart_tx_reg;        // UART TX
reg             spi_slave_csn_reg;  // SPI SLAVE CHIP ENABLE
reg     [3:0]   spi_master_cs_reg;  // SPI MASTER CHIP SELECT

wire    [3:0]   gpio_led_int;       // GPIO LED INTERNAL
wire    [11:0]  gpio_out_int;       // GPIO OUT INTERNAL
wire            pwm_out_int;        // PWM OUTPUT INTERNAL
wire            uart_tx_int;        // UART TX INTERNAL
wire    [3:0]   spi_master_cs_int;  // SPI MASTER CHIP SELECT INTERNAL

//////////////     ---     IO PIPELINE     ---     //////////////

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        gpio_sw_reg         <= 0;
        gpio_in_reg         <= 0;
        uart_rx_reg         <= 0;
        spi_slave_csn_reg   <= 0;
        gpio_led_reg        <= 0;
        gpio_out_reg        <= 0;
        pwm_out_reg         <= 0;
        uart_tx_reg         <= 0;
        spi_master_cs_reg   <= 0;
    end
    else begin
        gpio_sw_reg         <= gpio_sw;
        gpio_in_reg         <= gpio_in;
        uart_rx_reg         <= uart_rx;
        spi_slave_csn_reg   <= spi_slave_csn;
        gpio_led_reg        <= gpio_led_int;
        gpio_out_reg        <= gpio_out_int;
        pwm_out_reg         <= pwm_out_int;
        uart_tx_reg         <= uart_tx_int;
        spi_master_cs_reg   <= spi_master_cs_int;
    end
end

assign gpio_led         = gpio_led_reg;
assign gpio_out         = gpio_out_reg;
assign pwm_out          = pwm_out_reg;
assign uart_tx          = uart_tx_reg;
assign spi_master_cs    = spi_master_cs_reg;


//////////////     ---     RISC-V CORE     ---     //////////////

rv32_core rv32_core (
    .clk        (clk),
    .rstn       (rstn),
    .dmem_rdata (dmem_rdata),
    .dmem_addr  (dmem_addr),
    .dmem_wdata (dmem_wdata),
    .dmem_wmask (dmem_wmask),
    .dmem_wen   (dmem_wen),
    .dmem_ren   (dmem_ren)
);

//////////////     ---     BUS CONTROL     ---     //////////////

device_sel dev_sel (
    .i_dev_addr         (dmem_addr[31:28]),
    .i_ram_rdata        (ram_rdata),
    .i_gpio_rdata       (gpio_rdata),
    .i_uart_rdata       (uart_rdata),
    .i_timer_rdata      (timer_rdata),
    .i_spi_rdata        (spi_rdata),
    .o_mem_rdata        (dmem_rdata),
    .o_sel_mem          (sel_mem),
    .o_sel_gpio         (sel_gpio),
    .o_sel_uart         (sel_uart),
    .o_sel_timer        (sel_timer),
    .o_sel_spi          (sel_spi)
);

//////////////     ---     DATA MEMORY (RAM)     ---     //////////////

assign ram_wen = sel_mem & dmem_wen;
assign ram_ren = sel_mem & dmem_ren;

data_mem #(
    .MEM_FILE   (MEM_FILE),
    .MEM_SIZE   (MEM_SIZE)
) data_mem (
    .clk        (clk),           
    .mem_ren    (ram_ren),
    .mem_wen    (ram_wen),
    .mem_addr   ({4'h0, dmem_addr[27:0]}),      
    .mem_rdata  (ram_rdata),    
    .mem_wdata  (dmem_wdata),      
    .mem_wmask  (dmem_wmask),
    .mem_rvalid (ram_rvalid)
);

//////////////     ---     UART CORE     ---     //////////////

assign uart_wen = sel_uart & dmem_wen;
assign uart_ren = sel_uart & dmem_ren;

uart_top uart_ip (
    .clk        (clk),
    .rst        (!rstn),
    .waddr      ({4'h0, dmem_addr[27:0]}),
    .wdata      (dmem_wdata),
    .wen        (uart_wen),
    .wstrb      (dmem_wmask),
    .wready     (uart_wready),
    .raddr      ({4'h0, dmem_addr[27:0]}),
    .ren        (uart_ren),
    .rdata      (uart_rdata),
    .rvalid     (uart_rvalid),
    .i_rx_bit   (uart_rx_reg),
    .o_tx_bit   (uart_tx_int)
);

//////////////     ---     SPI CORE     ---     //////////////

assign spi_wen = sel_spi & dmem_wen;
assign spi_ren = sel_spi & dmem_ren;

spi_top spi0 (
    .clk                (clk),
    .rst                (!rstn),
    .waddr              ({4'h0, dmem_addr[27:0]}),
    .wdata              (dmem_wdata),
    .wen                (spi_wen),
    .wstrb              (dmem_wmask),
    .wready             (spi_wready),
    .raddr              ({4'h0, dmem_addr[27:0]}),
    .ren                (spi_ren),
    .rdata              (spi_rdata),
    .rvalid             (spi_rvalid),
    .io_spi_clk         (spi_clk),
    .io_spi_miso_bit    (spi_miso),
    .i_spi_csn          (spi_slave_csn_reg),
    .io_spi_mosi_bit    (spi_mosi),
    .o_spi_cs           (spi_master_cs_int)
);

//////////////     ---     GPIO CORE     ---     //////////////

assign gpio_wen = sel_gpio & dmem_wen;
assign gpio_ren = sel_gpio & dmem_ren;

gpio_regs gpio0 (
    .clk                        (clk),
    .rst                        (!rstn),
    .csr_gpio_data_led_out      (gpio_led_int),
    .csr_gpio_data_sw_in        (gpio_sw_reg),
    .csr_gpio_data_gpio_out_out (gpio_out_int),
    .csr_gpio_data_gpio_in_in   (gpio_in_reg),
    .csr_gpio_ctrl_gpio_dir_out (gpio_dir),
    .waddr                      ({4'h0, dmem_addr[27:0]}),
    .wdata                      (dmem_wdata),
    .wen                        (gpio_wen),
    .wstrb                      (dmem_wmask),
    .wready                     (gpio_wready),
    .raddr                      ({4'h0, dmem_addr[27:0]}),
    .ren                        (gpio_ren),
    .rdata                      (gpio_rdata),
    .rvalid                     (gpio_rvalid)
);

//////////////     ---     TIMER CORE     ---     //////////////

assign timer_wen    = sel_timer & dmem_wen;
assign timer_ren    = dmem_ren;

timer_top timer0 (
    .clk                (clk),
    .rstn               (rstn),
    .waddr              ({4'h0, dmem_addr[27:0]}),
    .wdata              (dmem_wdata),
    .wen                (timer_wen),
    .wstrb              (dmem_wmask),
    .wready             (timer_wready),
    .raddr              ({4'h0, dmem_addr[27:0]}),
    .ren                (timer_ren),
    .rdata              (timer_rdata),
    .rvalid             (timer_rvalid),
    .pwm                (pwm_out_int)
);

endmodule
