// Created with Corsair v1.0.4
`timescale 1ns/1ps

module gpio_regs(
    // System
    input clk,
    input rst,
    // GPIO_DATA.LED
    output [3:0] csr_gpio_data_led_out,
    // GPIO_DATA.SW
    input [3:0] csr_gpio_data_sw_in,
    // GPIO_DATA.GPIO_OUT
    output [11:0] csr_gpio_data_gpio_out_out,
    // GPIO_DATA.GPIO_IN
    input [11:0] csr_gpio_data_gpio_in_in,

    // GPIO_CTRL.GPIO_DIR
    output [11:0] csr_gpio_ctrl_gpio_dir_out,

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
// [0x0] - GPIO_DATA - General Purpose Input Output Data Register
//------------------------------------------------------------------------------
wire [31:0] csr_gpio_data_rdata;

wire csr_gpio_data_wen;
assign csr_gpio_data_wen = wen && (waddr == 32'h0);

wire csr_gpio_data_ren;
assign csr_gpio_data_ren = ren && (raddr == 32'h0);

//---------------------
// Bit field:
// GPIO_DATA[3:0] - LED - Built-in Output LEDs
// access: wo, hardware: o
//---------------------
reg [3:0] csr_gpio_data_led_ff;

assign csr_gpio_data_rdata[3:0] = 4'h0;

assign csr_gpio_data_led_out = csr_gpio_data_led_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_gpio_data_led_ff <= 4'h0;
    end else  begin
     if (csr_gpio_data_wen) begin
            if (wstrb[0]) begin
                csr_gpio_data_led_ff[3:0] <= wdata[3:0];
            end
        end else begin
            csr_gpio_data_led_ff <= csr_gpio_data_led_ff;
        end
    end
end


//---------------------
// Bit field:
// GPIO_DATA[7:4] - SW - Built-in Input Switches
// access: ro, hardware: i
//---------------------
reg [3:0] csr_gpio_data_sw_ff;

assign csr_gpio_data_rdata[7:4] = csr_gpio_data_sw_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_gpio_data_sw_ff <= 4'h0;
    end else  begin
              begin            csr_gpio_data_sw_ff <= csr_gpio_data_sw_in;
        end
    end
end


//---------------------
// Bit field:
// GPIO_DATA[19:8] - GPIO_OUT - GPIO Pin Value if selected as OUTPUT
// access: wo, hardware: o
//---------------------
reg [11:0] csr_gpio_data_gpio_out_ff;

assign csr_gpio_data_rdata[19:8] = 12'h0;

assign csr_gpio_data_gpio_out_out = csr_gpio_data_gpio_out_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_gpio_data_gpio_out_ff <= 12'h0;
    end else  begin
     if (csr_gpio_data_wen) begin
            if (wstrb[1]) begin
                csr_gpio_data_gpio_out_ff[7:0] <= wdata[15:8];
            end
            if (wstrb[2]) begin
                csr_gpio_data_gpio_out_ff[11:8] <= wdata[19:16];
            end
        end else begin
            csr_gpio_data_gpio_out_ff <= csr_gpio_data_gpio_out_ff;
        end
    end
end


//---------------------
// Bit field:
// GPIO_DATA[31:20] - GPIO_IN - GPIO Pin Value if selected as INPUT
// access: ro, hardware: i
//---------------------
reg [11:0] csr_gpio_data_gpio_in_ff;

assign csr_gpio_data_rdata[31:20] = csr_gpio_data_gpio_in_ff;


always @(posedge clk) begin
    if (rst) begin
        csr_gpio_data_gpio_in_ff <= 12'h0;
    end else  begin
              begin            csr_gpio_data_gpio_in_ff <= csr_gpio_data_gpio_in_in;
        end
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x4] - GPIO_CTRL - General Purpose Input Output Control Register
//------------------------------------------------------------------------------
wire [31:0] csr_gpio_ctrl_rdata;
assign csr_gpio_ctrl_rdata[31:12] = 20'h0;

wire csr_gpio_ctrl_wen;
assign csr_gpio_ctrl_wen = wen && (waddr == 32'h4);

wire csr_gpio_ctrl_ren;
assign csr_gpio_ctrl_ren = ren && (raddr == 32'h4);
reg csr_gpio_ctrl_ren_ff;
always @(posedge clk) begin
    if (rst) begin
        csr_gpio_ctrl_ren_ff <= 1'b0;
    end else begin
        csr_gpio_ctrl_ren_ff <= csr_gpio_ctrl_ren;
    end
end
//---------------------
// Bit field:
// GPIO_CTRL[11:0] - GPIO_DIR - GPIO Pin Direction
// access: rw, hardware: o
//---------------------
reg [11:0] csr_gpio_ctrl_gpio_dir_ff;

assign csr_gpio_ctrl_rdata[11:0] = csr_gpio_ctrl_gpio_dir_ff;

assign csr_gpio_ctrl_gpio_dir_out = csr_gpio_ctrl_gpio_dir_ff;

always @(posedge clk) begin
    if (rst) begin
        csr_gpio_ctrl_gpio_dir_ff <= 12'h0;
    end else  begin
     if (csr_gpio_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_gpio_ctrl_gpio_dir_ff[7:0] <= wdata[7:0];
            end
            if (wstrb[1]) begin
                csr_gpio_ctrl_gpio_dir_ff[11:8] <= wdata[11:8];
            end
        end else begin
            csr_gpio_ctrl_gpio_dir_ff <= csr_gpio_ctrl_gpio_dir_ff;
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
assign rdata =  (raddr == 32'h0) ? csr_gpio_data_rdata :
                (raddr == 32'h4) ? csr_gpio_ctrl_rdata :
                32'h0;

//------------------------------------------------------------------------------
// Read data valid
//------------------------------------------------------------------------------
assign rvalid = ren;

endmodule
