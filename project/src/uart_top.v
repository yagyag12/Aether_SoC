/*******************************************************************/
//                             UART CORE                           //
/*******************************************************************/
`timescale 1ns/1ps 

module uart_top (
    input               clk,
    input               rst,
    input   [31:0]      waddr,
    input   [31:0]      wdata,
    input               wen,
    input   [ 3:0]      wstrb,
    output              wready,
    input   [31:0]      raddr,
    input               ren,
    output  [31:0]      rdata,
    output              rvalid,
    input               i_rx_bit,
    output              o_tx_bit
);

//////////////     ---     SIGNALS     ---     //////////////

wire            uart_en;   
wire            tx_en;     
wire            rx_en;     
wire            tx_irq_en; 
wire            rx_irq_en; 
wire    [1:0]   baud_sel;  
wire            tx_ready;  
wire            rx_ready;         
wire            tx_done;   
wire            rx_done;   
wire            rx_full;   
wire    [7:0]   tx_data;   
wire    [7:0]   rx_data;   
wire            tx_tick;
wire            rx_tick;
wire            tx_en_logic;
wire            tx_i_valid;
wire            rx_en_logic;

//////////////     ---     CONTROL     ---     //////////////

assign tx_en_logic = uart_en & (tx_en | tx_irq_en);
assign tx_i_valid  = wen & (waddr == 'h8);
assign rx_en_logic = uart_en & (rx_en | rx_irq_en);

//////////////     ---     MODULE INSTANCES     ---     //////////////

baud_rate_generator baud_rate_generator0 (
    .clk        (clk),
    .rst        (rst),
    .uart_en    (uart_en),
    .baud_sel   (baud_sel),
    .tx_tick    (tx_tick),
    .rx_tick    (rx_tick)
);

// TRANSMITTER
uart_tx uart_tx0 (
    .clk        (clk),
    .rst        (rst),
    .tick       (tx_tick),
    .i_tx_en    (tx_en_logic),
    .i_data     (tx_data),
    .i_valid    (tx_i_valid),
    .o_ready    (tx_ready),
    .o_done     (tx_done),
    .o_tx       (o_tx_bit)
);

// RECEIVER
uart_rx uart_rx0 (
    .clk        (clk),
    .rst        (rst),
    .tick       (rx_tick),
    .i_rx_en    (rx_en_logic),
    .i_rx       (i_rx_bit),
    .o_ready    (rx_ready),
    .o_done     (rx_done),
    .o_full     (rx_full),
    .o_rx_data  (rx_data)
);

// REGISTERS
uart_regs uart_regs (
    .clk                        (clk),
    .rst                        (rst),
    .csr_uart_ctrl_uart_en_out  (uart_en),    // UART_CTRL.UART_EN
    .csr_uart_ctrl_tx_en_out    (tx_en),      // UART_CTRL.TX_EN
    .csr_uart_ctrl_rx_en_out    (rx_en),      // UART_CTRL.RX_EN
    .csr_uart_ctrl_tx_irq_en_out(tx_irq_en),  // UART_CTRL.TX_IRQ_EN
    .csr_uart_ctrl_rx_irq_en_out(rx_irq_en),  // UART_CTRL.RX_IRQ_EN
    .csr_uart_ctrl_baud_sel_out (baud_sel),   // UART_CTRL.BAUD_SEL
    .csr_uart_stat_tx_rdy_in    (tx_ready),   // UART_STAT.TX_RDY
    .csr_uart_stat_tx_done_in   (tx_done),    // UART_STAT.TX_DONE
    .csr_uart_stat_rx_rdy_in    (rx_ready),   // UART_STAT.RX_RDY
    .csr_uart_stat_rx_done_in   (rx_done),    // UART_STAT.RX_DONE
    .csr_uart_stat_rx_full_in   (rx_full),    // UART_STAT.RX_FULL
    .csr_uart_data_tx_data_out  (tx_data),    // UART_DATA.TX_DATA
    .csr_uart_data_rx_data_in   (rx_data),    // UART_DATA.RX_DATA
    .waddr                      (waddr),
    .wdata                      (wdata),
    .wen                        (wen),
    .wstrb                      (wstrb),
    .wready                     (wready),
    .raddr                      (raddr),
    .ren                        (ren),
    .rdata                      (rdata),
    .rvalid                     (rvalid)
);

endmodule
