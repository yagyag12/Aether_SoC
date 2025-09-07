/*******************************************************************/
//                             SPI CORE                            //
/*******************************************************************/
`timescale 1ns/1ps

module spi_top (
    input              clk,
    input              rst,
    // Local Bus
    input  [31:0]      waddr,
    input  [31:0]      wdata,
    input              wen,
    input  [3:0]       wstrb,
    output             wready,
    input  [31:0]      raddr,
    input              ren,
    output [31:0]      rdata,
    output             rvalid,
    // SPI physical interface
    inout              io_spi_clk,      // SPI_CLK
    inout              io_spi_miso_bit, // MISO
    input              i_spi_csn,       // Slave Chip Enable
    inout              io_spi_mosi_bit, // MOSI
    output [3:0]       o_spi_cs         // Master Chip Select
);

//////////////     ---     SIGNALS     ---     //////////////

wire        spi_en;
wire        master_en;
wire        cpol;
wire        cpha;
wire [1:0]  cs;
wire [7:0]  tx_data;
wire [7:0]  rx_data;
wire        tx_rdy;
wire        tx_done;
wire        rx_rdy;
wire        rx_done;
wire        busy;
wire        spi_master_ready;
wire        i_spi_miso_bit;
wire        o_spi_clk;
wire        o_spi_mosi_bit;
wire        o_spi_miso_bit;
wire        i_spi_clk;
wire        i_spi_mosi_bit;  
wire        spi_slave_en;
wire        spi_master_en;
wire [7:0]  spi_master_rx_data;
wire        spi_master_rx_valid;
wire [7:0]  spi_slave_rx_data;
wire        spi_slave_rx_valid;

//////////////     ---     CONTROL     ---     //////////////

assign rx_data = master_en ? spi_master_rx_data : spi_slave_rx_data;
assign rx_done = master_en ? spi_master_rx_valid : spi_slave_rx_valid;
assign tx_rdy  = master_en ? spi_master_ready    : 1'b1;
assign tx_done = master_en ? ~spi_master_ready   : 1'b1;
assign rx_rdy  = rx_done;
assign busy    = master_en ? ~spi_master_ready   : 1'b0;

assign io_spi_mosi_bit = (master_en) ? o_spi_mosi_bit : 1'bz;
assign i_spi_mosi_bit = (master_en) ? 1'b0 : io_spi_mosi_bit;

assign io_spi_miso_bit = (master_en) ? 1'bz : o_spi_miso_bit;
assign i_spi_miso_bit = (master_en) ? io_spi_miso_bit : 1'b0;

assign io_spi_clk = (master_en) ? o_spi_clk : 1'bz;
assign i_spi_clk = (master_en) ? 1'b0 : io_spi_clk;

assign spi_slave_en = ~master_en & ~i_spi_csn & spi_en;
assign spi_master_en = spi_en & master_en & wen & (waddr == 32'h8);


//////////////     ---     MODULE INSTANCES     ---     //////////////

// REGISTER MODULE
spi_regs spi_regs_i (
    .clk                        (clk),
    .rst                        (rst),
    .csr_spi_ctrl_spi_en_out    (spi_en),
    .csr_spi_ctrl_master_en_out (master_en),
    .csr_spi_ctrl_cpol_out      (cpol),
    .csr_spi_ctrl_cpha_out      (cpha),
    .csr_spi_ctrl_cs_out        (cs),
    .csr_spi_stat_tx_rdy_in     (tx_rdy),
    .csr_spi_stat_tx_done_in    (tx_done),
    .csr_spi_stat_rx_rdy_in     (rx_rdy),
    .csr_spi_stat_rx_done_in    (rx_done),
    .csr_spi_stat_busy_in       (busy),
    .csr_spi_data_tx_data_out   (tx_data),
    .csr_spi_data_rx_data_in    (rx_data),
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

// MASTER
spi_master #(
    .CLKS_PER_HALF_BIT(4)
) spi_master_i (
    .i_clk            (clk),
    .i_rstn           (~rst),
    .i_mosi_data      (tx_data),
    .i_mosi_valid     (spi_master_en),
    .o_mosi_ready     (spi_master_ready),
    .o_miso_valid     (spi_master_rx_valid),
    .o_miso_data      (spi_master_rx_data),
    .i_cpol           (cpol),
    .i_cpha           (cpha),
    .i_cs             (cs),
    .i_spi_miso_bit   (i_spi_miso_bit),
    .o_spi_clk        (o_spi_clk),
    .o_spi_mosi_bit   (o_spi_mosi_bit),
    .o_spi_cs         (o_spi_cs)
);

// SLAVE
spi_slave spi_slave_i (
    .i_clk            (clk),
    .i_spi_clk        (i_spi_clk),
    .i_rstn           (~rst),
    .i_spi_csn        (~spi_slave_en),
    .i_cpha           (cpha),
    .i_spi_mosi_bit   (i_spi_mosi_bit),
    .i_miso_valid     (spi_slave_en), 
    .i_miso_data      (tx_data),
    .o_spi_miso_bit   (o_spi_miso_bit),
    .o_mosi_valid     (spi_slave_rx_valid),
    .o_mosi_data      (spi_slave_rx_data)
);

endmodule
