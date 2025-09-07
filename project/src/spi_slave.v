/*******************************************************************/
//                             SPI SLAVE                           //
/*******************************************************************/
`timescale 1ns/1ps

module spi_slave (
    input               i_clk,          // System clock
    input               i_rstn,         // Active-low reset
    input               i_spi_clk,      // SPI clock (external domain)
    input               i_spi_csn,      // Active-low chip select
    input               i_spi_mosi_bit, // SPI data in (MOSI)
    input               i_cpha,         // Clock phase select
    input               i_miso_valid,   // Data valid for MISO
    input       [7:0]   i_miso_data,    // Data to send to master
    output              o_spi_miso_bit, // SPI data out (MISO)
    output  reg         o_mosi_valid,   // Valid flag for received data
    output  reg [7:0]   o_mosi_data     // Received data (MOSI)
);

//////////////     ---     SPI CLOCK SYNC & EDGE DETECTION     ---     //////////////

reg spi_clk_sync_0, spi_clk_sync_1;
always @(posedge i_clk) begin
    if (!i_rstn) begin
        spi_clk_sync_0 <= 1'b0;
        spi_clk_sync_1 <= 1'b0;
    end else begin
        spi_clk_sync_0 <= i_spi_clk;
        spi_clk_sync_1 <= spi_clk_sync_0;
    end
end

wire spi_clk_rise = ( spi_clk_sync_0 & ~spi_clk_sync_1 );
wire spi_clk_fall = (~spi_clk_sync_0 &  spi_clk_sync_1 );
wire spi_tick     = i_cpha ? spi_clk_fall : spi_clk_rise;

//////////////     ---     SPI FSM for Receiving Data (MOSI)     ---     //////////////

reg [6:0] mosi_shift_reg;
reg [2:0] bit_cnt;

always @(posedge i_clk) begin
    if (!i_rstn) begin
        mosi_shift_reg <= 7'd0;
        o_mosi_data    <= 8'd0;
        o_mosi_valid   <= 1'b0;
        bit_cnt        <= 3'd0;
    end else if (!i_spi_csn) begin
        if (spi_tick) begin
            mosi_shift_reg <= {mosi_shift_reg[5:0], i_spi_mosi_bit};
            bit_cnt <= bit_cnt + 1;
            if (bit_cnt == 3'd7) begin
                o_mosi_data  <= {mosi_shift_reg, i_spi_mosi_bit};
                o_mosi_valid <= 1'b1;
            end else begin
                o_mosi_valid <= 1'b0;
            end
        end else begin
            o_mosi_valid <= 1'b0;
        end
    end else begin
        bit_cnt        <= 3'd0;
        o_mosi_valid   <= 1'b0;
    end
end

//////////////     ---     MISO Shift Register ---     //////////////

reg [7:0] miso_shift_reg;
reg [2:0] miso_bit_cnt;

always @(posedge i_clk) begin
    if (!i_rstn) begin
        miso_shift_reg <= 8'd0;
        miso_bit_cnt   <= 3'd7;
    end else if (!i_spi_csn) begin
        if (i_miso_valid) begin
            miso_shift_reg <= i_miso_data;
            miso_bit_cnt   <= 3'd7;
        end else if (spi_tick) begin
            miso_shift_reg <= {miso_shift_reg[6:0], 1'b0};
            miso_bit_cnt   <= miso_bit_cnt - 1;
        end
    end
end

assign o_spi_miso_bit = miso_shift_reg[7];

endmodule
