/*******************************************************************/
//                            SPI MASTER                           //
/*******************************************************************/
`timescale 1ns/1ps

module spi_master #(
  parameter CLKS_PER_HALF_BIT = 2) (
  input             i_clk,      
  input             i_rstn,  
  // MOSI Signals
  input       [7:0] i_mosi_data,        
  input             i_mosi_valid,        
  output  reg       o_mosi_ready, 
  // MISO Signals
  output  reg       o_miso_valid,   
  output  reg [7:0] o_miso_data,  
  // SPI Interface
  input             i_cpol,
  input             i_cpha,
  input       [1:0] i_cs,
  input             i_spi_miso_bit,
  output  reg       o_spi_clk,
  output  reg       o_spi_mosi_bit,
  output  reg [3:0] o_spi_cs
);

//////////////     ---     SIGNALS     ---     //////////////

reg [$clog2(CLKS_PER_HALF_BIT*2)-1:0] spi_clk_counter;
reg       spi_clk_reg;
reg [4:0] spi_edge_counter;
reg       leading_edge_reg;
reg       trailing_edge_reg;
reg       mosi_valid_reg;
reg [7:0] mosi_data_reg;
reg [2:0] miso_bit_counter;
reg [2:0] mosi_bit_counter;
reg       edge_detect;

//////////////     ---     CHIP SELECT     ---     //////////////

always @(posedge i_clk) begin
  if (~i_rstn) begin
      o_spi_cs <= 4'b1111;
  end
  else begin
      if (spi_edge_counter != 0) begin
          o_spi_cs[i_cs] <= 0;
      end
      else begin
          o_spi_cs <= 4'b1111;
      end
  end
end

//////////////     ---     SPI CLOCK GEN     ---     //////////////

always @(posedge i_clk) begin
  if (~i_rstn) begin
    o_mosi_ready      <= 0;
    spi_edge_counter  <= 0;
    spi_clk_reg       <= 0;
    spi_clk_counter   <= 0;
  end
  else begin
    leading_edge_reg  <= 0;
    trailing_edge_reg <= 0;

    if (spi_edge_counter == 0) begin
      spi_clk_reg       <= i_cpol;
    end
    
    if (mosi_valid_reg) begin
      o_mosi_ready     <= 0;
      spi_edge_counter <= 16;
    end

    else if (spi_edge_counter != 0) begin
      o_mosi_ready <= 0;
      
      if (spi_clk_counter == CLKS_PER_HALF_BIT*2-1) begin
        spi_edge_counter  <= spi_edge_counter - 1;
        trailing_edge_reg <= 1;
        spi_clk_counter   <= 0;
        spi_clk_reg       <= ~spi_clk_reg;
      end
      else if (spi_clk_counter == CLKS_PER_HALF_BIT-1) begin
        spi_edge_counter  <= spi_edge_counter - 1;
        leading_edge_reg  <= 1;
        spi_clk_counter   <= spi_clk_counter + 1;
        spi_clk_reg       <= ~spi_clk_reg;
      end
      else begin
        spi_clk_counter   <= spi_clk_counter + 1;
      end
    end  
    else begin
      o_mosi_ready <= 1'b1;
    end  
  end
end

//////////////     ---     WRITE MOSI     ---     //////////////

// MOSI Data Storage
always @(posedge i_clk) begin
  if (~i_rstn) begin
    mosi_data_reg   <= 0;
    mosi_valid_reg  <= 0;
  end
  else begin
      mosi_valid_reg <= i_mosi_valid;
      if (mosi_valid_reg) begin
        mosi_data_reg <= i_mosi_data;
      end
    end
end

// MOSI Output
always @(posedge i_clk)
begin
  if (~i_rstn) begin
    o_spi_mosi_bit   <= 1'b0;
    mosi_bit_counter <= 3'b111;
  end
  else begin
    if (o_mosi_ready) begin
      mosi_bit_counter <= 3'b111;
    end
    else if (mosi_valid_reg & ~i_cpha) begin
      o_spi_mosi_bit   <= mosi_data_reg[7];
      mosi_bit_counter <= 3'b110;
    end
    else if ((leading_edge_reg & i_cpha) | (trailing_edge_reg & ~i_cpha)) begin
      o_spi_mosi_bit   <= mosi_data_reg[mosi_bit_counter];
      if (mosi_bit_counter != 3'b000)
        mosi_bit_counter <= mosi_bit_counter - 1'b1;
    end
  end
end

//////////////     ---     READ MISO     ---     //////////////

always @(posedge i_clk) begin
  if (~i_rstn) begin
    o_miso_data       <= 0;
    miso_bit_counter  <= 3'b111;
    edge_detect       <= 0;
  end
  else begin
    o_miso_valid        <= 0;
    if (o_mosi_ready) begin
      miso_bit_counter  <= 3'b111;
    end
    else if ((leading_edge_reg & ~i_cpha) | (trailing_edge_reg & i_cpha)) begin
      edge_detect <= 1;
    end
    if (edge_detect) begin
        o_miso_data[miso_bit_counter] <= i_spi_miso_bit;
        miso_bit_counter              <= miso_bit_counter - 1;
        edge_detect                   <= 0;
    end
    if (miso_bit_counter == 3'b000) begin
        o_miso_valid   <= 1;
    end
  end
end

always @(posedge i_clk) begin
  o_spi_clk <= spi_clk_reg;
end

endmodule
