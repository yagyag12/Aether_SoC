// Created with Corsair v1.0.4
`timescale 1ns/1ps

module spi_regs (
    // System
    input clk,
    input rst,
    // SPI_CTRL.SPI_EN
    output  csr_spi_ctrl_spi_en_out,
    // SPI_CTRL.MASTER_EN
    output  csr_spi_ctrl_master_en_out,
    // SPI_CTRL.CPOL
    output  csr_spi_ctrl_cpol_out,
    // SPI_CTRL.CPHA
    output  csr_spi_ctrl_cpha_out,
    // SPI_CTRL.CS
    output [1:0] csr_spi_ctrl_cs_out,

    // SPI_STAT.TX_RDY
    input  csr_spi_stat_tx_rdy_in,
    // SPI_STAT.TX_DONE
    input  csr_spi_stat_tx_done_in,
    // SPI_STAT.RX_RDY
    input  csr_spi_stat_rx_rdy_in,
    // SPI_STAT.RX_DONE
    input  csr_spi_stat_rx_done_in,
    // SPI_STAT.BUSY
    input  csr_spi_stat_busy_in,

    // SPI_DATA.TX_DATA
    output [7:0] csr_spi_data_tx_data_out,
    // SPI_DATA.RX_DATA
    input [7:0] csr_spi_data_rx_data_in,

    // Local Bus
    input  [31:0] waddr,
    input  [31:0] wdata,
    input         wen,
    input  [ 3:0] wstrb,
    output        wready,
    input  [31:0] raddr,
    input         ren,
    output [31:0] rdata,
    output        rvalid
);
//------------------------------------------------------------------------------
// CSR:
// [0x0] - SPI_CTRL - SPI CONTROL REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_spi_ctrl_rdata;
assign csr_spi_ctrl_rdata[31:14] = 18'h0;


wire csr_spi_ctrl_wen;
assign csr_spi_ctrl_wen = wen && (waddr == 32'h0);

//---------------------
// Bit field:
// SPI_CTRL[0] - SPI_EN - Enable SPI
// access: rw, hardware: o
//---------------------
reg  csr_spi_ctrl_spi_en_ff;

assign csr_spi_ctrl_rdata[0] = csr_spi_ctrl_spi_en_ff;

assign csr_spi_ctrl_spi_en_out = csr_spi_ctrl_spi_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_ctrl_spi_en_ff <= 1'b0;
    end 
    else if (csr_spi_ctrl_wen & wstrb[0]) begin
        csr_spi_ctrl_spi_en_ff <= wdata[0];
    end 
end

//---------------------
// Bit field:
// SPI_CTRL[1] - MASTER_EN - Enable SPI as Master (0 -> Slave / 1 -> Master)
// access: rw, hardware: o
//---------------------
reg  csr_spi_ctrl_master_en_ff;

assign csr_spi_ctrl_rdata[1] = csr_spi_ctrl_master_en_ff;

assign csr_spi_ctrl_master_en_out = csr_spi_ctrl_master_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_ctrl_master_en_ff <= 1'b0;
    end 
    else if (csr_spi_ctrl_wen & wstrb[0]) begin
        csr_spi_ctrl_master_en_ff <= wdata[1];
    end
end

//---------------------
// Bit field:
// SPI_CTRL[2] - CPOL - Clock Polarity
// access: rw, hardware: o
//---------------------
reg  csr_spi_ctrl_cpol_ff;

assign csr_spi_ctrl_rdata[2] = csr_spi_ctrl_cpol_ff;

assign csr_spi_ctrl_cpol_out = csr_spi_ctrl_cpol_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_ctrl_cpol_ff <= 1'b0;
    end 
    else if (csr_spi_ctrl_wen & wstrb[0]) begin
        csr_spi_ctrl_cpol_ff <= wdata[2];
    end
end


//---------------------
// Bit field:
// SPI_CTRL[3] - CPHA - Clock Phase
// access: rw, hardware: o
//---------------------
reg  csr_spi_ctrl_cpha_ff;

assign csr_spi_ctrl_rdata[3] = csr_spi_ctrl_cpha_ff;

assign csr_spi_ctrl_cpha_out = csr_spi_ctrl_cpha_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_ctrl_cpha_ff <= 1'b0;
    end 
    else if (csr_spi_ctrl_wen & wstrb[0]) begin
        csr_spi_ctrl_cpha_ff <= wdata[3];
    end
end

//---------------------
// Bit field:
// SPI_CTRL[11:4] - CLK_DIV - Clock Divider for SPI Clock Generation
// access: rw, hardware: o
//---------------------
assign csr_spi_ctrl_rdata[11:4] = 8'd0;

//---------------------
// Bit field:
// SPI_CTRL[13:12] - CS - Chip Select
// access: rw, hardware: o
//---------------------
reg [1:0] csr_spi_ctrl_cs_ff;

assign csr_spi_ctrl_rdata[13:12] = csr_spi_ctrl_cs_ff;

assign csr_spi_ctrl_cs_out = csr_spi_ctrl_cs_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_ctrl_cs_ff <= 2'h0;
    end 
    else if (csr_spi_ctrl_wen & wstrb[1]) begin
        csr_spi_ctrl_cs_ff[1:0] <= wdata[13:12];
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x4] - SPI_STAT - SPI STATUS REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_spi_stat_rdata;
assign csr_spi_stat_rdata[31:5] = 27'h0;

wire csr_spi_stat_ren;
assign csr_spi_stat_ren = ren && (raddr == 32'h4);
reg csr_spi_stat_ren_ff;
always @(posedge clk) begin
    if (rst) begin
        csr_spi_stat_ren_ff <= 1'b0;
    end else begin
        csr_spi_stat_ren_ff <= csr_spi_stat_ren;
    end
end
//---------------------
// Bit field:
// SPI_STAT[0] - TX_RDY - Transmitter Ready
// access: ro, hardware: i
//---------------------
reg  csr_spi_stat_tx_rdy_ff;

assign csr_spi_stat_rdata[0] = csr_spi_stat_tx_rdy_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_spi_stat_tx_rdy_ff <= 1'b1;
    end 
    else  begin
        csr_spi_stat_tx_rdy_ff <= csr_spi_stat_tx_rdy_in;
    end
end


//---------------------
// Bit field:
// SPI_STAT[1] - TX_DONE - Transmitter Done
// access: roc, hardware: i
//---------------------
reg  csr_spi_stat_tx_done_ff;

assign csr_spi_stat_rdata[1] = csr_spi_stat_tx_done_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_spi_stat_tx_done_ff <= 1'b0;
    end 
    else begin
        if (csr_spi_stat_ren && !csr_spi_stat_ren_ff) begin
            csr_spi_stat_tx_done_ff <= 1'b0;
        end 
        else begin
            csr_spi_stat_tx_done_ff <= csr_spi_stat_tx_done_in;
        end
    end
end


//---------------------
// Bit field:
// SPI_STAT[2] - RX_RDY - Receiver Ready
// access: ro, hardware: i
//---------------------
reg  csr_spi_stat_rx_rdy_ff;

assign csr_spi_stat_rdata[2] = csr_spi_stat_rx_rdy_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_spi_stat_rx_rdy_ff <= 1'b1;
    end 
    else  begin
        csr_spi_stat_rx_rdy_ff <= csr_spi_stat_rx_rdy_in;
    end
end


//---------------------
// Bit field:
// SPI_STAT[3] - RX_DONE - Receiver Done
// access: roc, hardware: i
//---------------------
reg  csr_spi_stat_rx_done_ff;

assign csr_spi_stat_rdata[3] = csr_spi_stat_rx_done_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_stat_rx_done_ff <= 1'b0;
    end 
    else begin
        if (csr_spi_stat_ren && !csr_spi_stat_ren_ff) begin
            csr_spi_stat_rx_done_ff <= 1'b0;
        end 
        else begin
            csr_spi_stat_rx_done_ff <= csr_spi_stat_rx_done_in;
        end
    end
end

//---------------------
// Bit field:
// SPI_STAT[4] - BUSY - SPI is busy
// access: ro, hardware: i
//---------------------
reg  csr_spi_stat_busy_ff;

assign csr_spi_stat_rdata[4] = csr_spi_stat_busy_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_spi_stat_busy_ff <= 1'b0;
    end 
    else begin
        csr_spi_stat_busy_ff <= csr_spi_stat_busy_in;
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x8] - SPI_DATA - SPI DATA REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_spi_data_rdata;
assign csr_spi_data_rdata[31:16] = 16'h0;

wire csr_spi_data_wen;
assign csr_spi_data_wen = wen && (waddr == 32'h8);

//---------------------
// Bit field:
// SPI_DATA[7:0] - TX_DATA - SPI TX Data
// access: wo, hardware: o
//---------------------
reg [7:0] csr_spi_data_tx_data_ff;

assign csr_spi_data_rdata[7:0] = 8'h0;

assign csr_spi_data_tx_data_out = csr_spi_data_tx_data_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_spi_data_tx_data_ff <= 8'h0;
    end 
    else  begin
        if (csr_spi_data_wen) begin
            if (wstrb[0]) begin
                csr_spi_data_tx_data_ff[7:0] <= wdata[7:0];
            end
        end 
        else begin
            csr_spi_data_tx_data_ff <= csr_spi_data_tx_data_ff;
        end
    end
end


//---------------------
// Bit field:
// SPI_DATA[15:8] - RX_DATA - SPI RX Data
// access: ro, hardware: i
//---------------------
reg [7:0] csr_spi_data_rx_data_ff;

assign csr_spi_data_rdata[15:8] = csr_spi_data_rx_data_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_spi_data_rx_data_ff <= 8'h0;
    end 
    else begin
        csr_spi_data_rx_data_ff <= csr_spi_data_rx_data_in;
    end
end


//------------------------------------------------------------------------------
// Write ready
//------------------------------------------------------------------------------
assign wready = 1'b1;

//------------------------------------------------------------------------------
// Read address decoder
//------------------------------------------------------------------------------
assign rdata =  (raddr == 32'h0) ? csr_spi_ctrl_rdata :
                (raddr == 32'h4) ? csr_spi_stat_rdata :
                (raddr == 32'h8) ? csr_spi_data_rdata :
                32'h0;

//------------------------------------------------------------------------------
// Read data valid
//------------------------------------------------------------------------------
assign rvalid = ren;

endmodule
