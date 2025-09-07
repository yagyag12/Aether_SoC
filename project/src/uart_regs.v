// Created with Corsair v1.0.4
`timescale 1ns/1ps

module uart_regs (
    // System
    input clk,
    input rst,
    // UART_CTRL.UART_EN
    output  csr_uart_ctrl_uart_en_out,
    // UART_CTRL.TX_EN
    output  csr_uart_ctrl_tx_en_out,
    // UART_CTRL.RX_EN
    output  csr_uart_ctrl_rx_en_out,
    // UART_CTRL.TX_IRQ_EN
    output  csr_uart_ctrl_tx_irq_en_out,
    // UART_CTRL.RX_IRQ_EN
    output  csr_uart_ctrl_rx_irq_en_out,
    // UART_CTRL.BAUD_SEL
    output [1:0] csr_uart_ctrl_baud_sel_out,

    // UART_STAT.TX_RDY
    input  csr_uart_stat_tx_rdy_in,
    // UART_STAT.TX_DONE
    input  csr_uart_stat_tx_done_in,
    // UART_STAT.RX_RDY
    input  csr_uart_stat_rx_rdy_in,
    // UART_STAT.RX_DONE
    input  csr_uart_stat_rx_done_in,
    // UART_STAT.RX_FULL
    input  csr_uart_stat_rx_full_in,

    // UART_DATA.TX_DATA
    output [7:0] csr_uart_data_tx_data_out,
    // UART_DATA.RX_DATA
    input [7:0] csr_uart_data_rx_data_in,

    // Local Bus
    input  [31:0] waddr,
    input  [31:0] wdata,
    input               wen,
    input  [3:0] wstrb,
    output              wready,
    input  [31:0] raddr,
    input               ren,
    output [31:0] rdata,
    output              rvalid
);
//------------------------------------------------------------------------------
// CSR:
// [0x0] - UART_CTRL - UART CONTROL REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_uart_ctrl_rdata;
assign csr_uart_ctrl_rdata[31:7] = 25'h0;

wire csr_uart_ctrl_wen;
assign csr_uart_ctrl_wen = wen && (waddr == 32'h0);

wire csr_uart_ctrl_ren;
assign csr_uart_ctrl_ren = ren && (raddr == 32'h0);
reg csr_uart_ctrl_ren_ff;
always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_ren_ff <= 1'b0;
    end else begin
        csr_uart_ctrl_ren_ff <= csr_uart_ctrl_ren;
    end
end
//---------------------
// Bit field:
// UART_CTRL[0] - UART_EN - Enable Uart
// access: rw, hardware: o
//---------------------
reg  csr_uart_ctrl_uart_en_ff;

assign csr_uart_ctrl_rdata[0] = csr_uart_ctrl_uart_en_ff;

assign csr_uart_ctrl_uart_en_out = csr_uart_ctrl_uart_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_uart_en_ff <= 1'b0;
    end else  begin
     if (csr_uart_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_uart_ctrl_uart_en_ff <= wdata[0];
            end
        end else begin
            csr_uart_ctrl_uart_en_ff <= csr_uart_ctrl_uart_en_ff;
        end
    end
end


//---------------------
// Bit field:
// UART_CTRL[1] - TX_EN - Enable Transmitter
// access: rw, hardware: o
//---------------------
reg  csr_uart_ctrl_tx_en_ff;

assign csr_uart_ctrl_rdata[1] = csr_uart_ctrl_tx_en_ff;

assign csr_uart_ctrl_tx_en_out = csr_uart_ctrl_tx_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_tx_en_ff <= 1'b0;
    end else  begin
     if (csr_uart_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_uart_ctrl_tx_en_ff <= wdata[1];
            end
        end else begin
            csr_uart_ctrl_tx_en_ff <= csr_uart_ctrl_tx_en_ff;
        end
    end
end


//---------------------
// Bit field:
// UART_CTRL[2] - RX_EN - Enable Receiver
// access: rw, hardware: o
//---------------------
reg  csr_uart_ctrl_rx_en_ff;

assign csr_uart_ctrl_rdata[2] = csr_uart_ctrl_rx_en_ff;

assign csr_uart_ctrl_rx_en_out = csr_uart_ctrl_rx_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_rx_en_ff <= 1'b0;
    end else  begin
     if (csr_uart_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_uart_ctrl_rx_en_ff <= wdata[2];
            end
        end else begin
            csr_uart_ctrl_rx_en_ff <= csr_uart_ctrl_rx_en_ff;
        end
    end
end


//---------------------
// Bit field:
// UART_CTRL[3] - TX_IRQ_EN - Enable TX Interrupt
// access: rw, hardware: o
//---------------------
reg  csr_uart_ctrl_tx_irq_en_ff;

assign csr_uart_ctrl_rdata[3] = csr_uart_ctrl_tx_irq_en_ff;

assign csr_uart_ctrl_tx_irq_en_out = csr_uart_ctrl_tx_irq_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_tx_irq_en_ff <= 1'b0;
    end else  begin
     if (csr_uart_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_uart_ctrl_tx_irq_en_ff <= wdata[3];
            end
        end else begin
            csr_uart_ctrl_tx_irq_en_ff <= csr_uart_ctrl_tx_irq_en_ff;
        end
    end
end


//---------------------
// Bit field:
// UART_CTRL[4] - RX_IRQ_EN - Enable RX Interrupt
// access: rw, hardware: o
//---------------------
reg  csr_uart_ctrl_rx_irq_en_ff;

assign csr_uart_ctrl_rdata[4] = csr_uart_ctrl_rx_irq_en_ff;

assign csr_uart_ctrl_rx_irq_en_out = csr_uart_ctrl_rx_irq_en_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_rx_irq_en_ff <= 1'b0;
    end else  begin
     if (csr_uart_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_uart_ctrl_rx_irq_en_ff <= wdata[4];
            end
        end else begin
            csr_uart_ctrl_rx_irq_en_ff <= csr_uart_ctrl_rx_irq_en_ff;
        end
    end
end


//---------------------
// Bit field:
// UART_CTRL[6:5] - BAUD_SEL - Baud Rate Selection (00->4800 / 01->9600 / 10->57600 / 11->115200)
// access: rw, hardware: o
//---------------------
reg [1:0] csr_uart_ctrl_baud_sel_ff;

assign csr_uart_ctrl_rdata[6:5] = csr_uart_ctrl_baud_sel_ff;

assign csr_uart_ctrl_baud_sel_out = csr_uart_ctrl_baud_sel_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_ctrl_baud_sel_ff <= 2'h0;
    end else  begin
     if (csr_uart_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_uart_ctrl_baud_sel_ff[1:0] <= wdata[6:5];
            end
        end else begin
            csr_uart_ctrl_baud_sel_ff <= csr_uart_ctrl_baud_sel_ff;
        end
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x4] - UART_STAT - UART STATUS REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_uart_stat_rdata;
assign csr_uart_stat_rdata[0] = 1'b0;
assign csr_uart_stat_rdata[3] = 1'b0;
assign csr_uart_stat_rdata[31:7] = 25'h0;

wire csr_uart_stat_wen;
assign csr_uart_stat_wen = wen && (waddr == 32'h4);

wire csr_uart_stat_ren;
assign csr_uart_stat_ren = ren && (raddr == 32'h4);
reg csr_uart_stat_ren_ff;
always @(posedge clk) begin
    if (rst) begin
        csr_uart_stat_ren_ff <= 1'b0;
    end else begin
        csr_uart_stat_ren_ff <= csr_uart_stat_ren;
    end
end
//---------------------
// Bit field:
// UART_STAT[1] - TX_RDY - Transmitter Ready
// access: ro, hardware: i
//---------------------
reg  csr_uart_stat_tx_rdy_ff;

assign csr_uart_stat_rdata[1] = csr_uart_stat_tx_rdy_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_uart_stat_tx_rdy_ff <= 1'b1;
    end else  begin
              begin            csr_uart_stat_tx_rdy_ff <= csr_uart_stat_tx_rdy_in;
        end
    end
end


//---------------------
// Bit field:
// UART_STAT[2] - TX_DONE - Transmitter Done
// access: roc, hardware: i
//---------------------
reg  csr_uart_stat_tx_done_ff;

assign csr_uart_stat_rdata[2] = csr_uart_stat_tx_done_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_uart_stat_tx_done_ff <= 1'b0;
    end else  begin
          if (csr_uart_stat_ren && !csr_uart_stat_ren_ff) begin
            csr_uart_stat_tx_done_ff <= 1'b0;
        end else            begin            csr_uart_stat_tx_done_ff <= csr_uart_stat_tx_done_in;
        end
    end
end


//---------------------
// Bit field:
// UART_STAT[4] - RX_RDY - Receiver Ready
// access: ro, hardware: i
//---------------------
reg  csr_uart_stat_rx_rdy_ff;

assign csr_uart_stat_rdata[4] = csr_uart_stat_rx_rdy_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_uart_stat_rx_rdy_ff <= 1'b1;
    end else  begin
              begin            csr_uart_stat_rx_rdy_ff <= csr_uart_stat_rx_rdy_in;
        end
    end
end


//---------------------
// Bit field:
// UART_STAT[5] - RX_DONE - Receiver Done
// access: roc, hardware: i
//---------------------
reg  csr_uart_stat_rx_done_ff;

assign csr_uart_stat_rdata[5] = csr_uart_stat_rx_done_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_uart_stat_rx_done_ff <= 1'b0;
    end else  begin
          if (csr_uart_stat_ren && !csr_uart_stat_ren_ff) begin
            csr_uart_stat_rx_done_ff <= 1'b0;
        end else            begin            csr_uart_stat_rx_done_ff <= csr_uart_stat_rx_done_in;
        end
    end
end


//---------------------
// Bit field:
// UART_STAT[6] - RX_FULL - RX Buffer Full
// access: ro, hardware: i
//---------------------
reg  csr_uart_stat_rx_full_ff;

assign csr_uart_stat_rdata[6] = csr_uart_stat_rx_full_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_uart_stat_rx_full_ff <= 1'b0;
    end else  begin
              begin            csr_uart_stat_rx_full_ff <= csr_uart_stat_rx_full_in;
        end
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x8] - UART_DATA - UART DATA REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_uart_data_rdata;
assign csr_uart_data_rdata[31:16] = 16'h0;

wire csr_uart_data_wen;
assign csr_uart_data_wen = wen && (waddr == 32'h8);

wire csr_uart_data_ren;
assign csr_uart_data_ren = ren && (raddr == 32'h8);
reg csr_uart_data_ren_ff;
always @(posedge clk) begin
    if (rst) begin
        csr_uart_data_ren_ff <= 1'b0;
    end else begin
        csr_uart_data_ren_ff <= csr_uart_data_ren;
    end
end
//---------------------
// Bit field:
// UART_DATA[7:0] - TX_DATA - UART TX Data
// access: wo, hardware: o
//---------------------
reg [7:0] csr_uart_data_tx_data_ff;

assign csr_uart_data_rdata[7:0] = 8'h0;

assign csr_uart_data_tx_data_out = csr_uart_data_tx_data_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_uart_data_tx_data_ff <= 8'h0;
    end else  begin
     if (csr_uart_data_wen) begin
            if (wstrb[0]) begin
                csr_uart_data_tx_data_ff[7:0] <= wdata[7:0];
            end
        end else begin
            csr_uart_data_tx_data_ff <= csr_uart_data_tx_data_ff;
        end
    end
end


//---------------------
// Bit field:
// UART_DATA[15:8] - RX_DATA - UART RX Data
// access: ro, hardware: i
//---------------------
reg [7:0] csr_uart_data_rx_data_ff;

assign csr_uart_data_rdata[15:8] = csr_uart_data_rx_data_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_uart_data_rx_data_ff <= 8'h0;
    end else  begin
              begin            csr_uart_data_rx_data_ff <= csr_uart_data_rx_data_in;
        end
    end
end


//------------------------------------------------------------------------------
// Write ready
//------------------------------------------------------------------------------
assign wready = 1'b1;

//------------------------------------------------------------------------------
// Read address decoder
//------------------------------------------------------------------------------
assign rdata = (raddr == 32'h0) ? csr_uart_ctrl_rdata :
               (raddr == 32'h4) ? csr_uart_stat_rdata :
               (raddr == 32'h8) ? csr_uart_data_rdata :
               32'h0;

//------------------------------------------------------------------------------
// Read data valid
//------------------------------------------------------------------------------
assign rvalid = ren;

endmodule
