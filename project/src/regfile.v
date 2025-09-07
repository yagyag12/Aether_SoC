/*******************************************************************/
//                          REGISTER FILE                          //
/*******************************************************************/

`timescale 1ns/1ps

module regfile (
    input               clk,
    input               rstn,
    input               i_wen,
    input       [31:0]  i_rd,
    input       [ 4:0]  i_rd_addr,
    input       [ 4:0]  i_rs1_addr,
    input       [ 4:0]  i_rs2_addr,
    output      [31:0]  o_rs1,
    output      [31:0]  o_rs2
);

reg [31:0] registers [31:0];
integer i;
always @ (posedge clk) begin
    if (~rstn) begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'd0; // Hard Zero
        end
    end
    if (i_wen & (i_rd_addr != 5'd0)) begin
        registers[i_rd_addr] <= i_rd;
    end
end

assign o_rs1 = (i_rs1_addr == 5'd0) ? 32'd0 : registers[i_rs1_addr];
assign o_rs2 = (i_rs2_addr == 5'd0) ? 32'd0 : registers[i_rs2_addr];

endmodule
