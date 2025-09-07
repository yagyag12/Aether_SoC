/*******************************************************************/
//                  ARITHMETIC LOGIC UNIT (ALU)                    //
/*******************************************************************/

`timescale 1ns/1ps

module alu (
    input       [ 3:0]  i_alu_op,
    input       [31:0]  i_op_a,
    input       [31:0]  i_op_b,
    output  reg [31:0]  o_alu_result
);

//////////////     ---     PARAMETERS     ---     //////////////
// Format: {funct7[5], funct3} => 4-bit unique code

localparam  [3:0]   ALU_ADD     =   4'b0000;    // funct3 = 000, funct7 = 0000000
localparam  [3:0]   ALU_SUB     =   4'b1000;    // funct3 = 000, funct7 = 0100000
localparam  [3:0]   ALU_SLL     =   4'b0001;    // funct3 = 001
localparam  [3:0]   ALU_SLT     =   4'b0010;    // funct3 = 010
localparam  [3:0]   ALU_SLTU    =   4'b0011;    // funct3 = 011
localparam  [3:0]   ALU_XOR     =   4'b0100;    // funct3 = 100
localparam  [3:0]   ALU_SRL     =   4'b0101;    // funct3 = 101, funct7 = 0000000
localparam  [3:0]   ALU_SRA     =   4'b1101;    // funct3 = 101, funct7 = 0100000
localparam  [3:0]   ALU_OR      =   4'b0110;    // funct3 = 110
localparam  [3:0]   ALU_AND     =   4'b0111;    // funct3 = 111

//////////////     ---     SIGNALS     ---     //////////////

wire        [31:0]  result_add;
wire        [31:0]  result_sub;
wire        [31:0]  result_sll;
wire        [31:0]  result_slt;
wire        [31:0]  result_sltu;
wire        [31:0]  result_xor;
wire        [31:0]  result_srl;
wire        [31:0]  result_sra;
wire        [31:0]  result_or;
wire        [31:0]  result_and;

//////////////     ---     OPERATIONS     ---     //////////////

assign  result_add  =   i_op_a + i_op_b;
assign  result_sub  =   i_op_a - i_op_b;
assign  result_sll  =   i_op_a << i_op_b[4:0];
assign  result_slt  =   ($signed(i_op_a) < $signed(i_op_b)) ? 32'd1 : 32'd0;
assign  result_sltu =   (i_op_a < i_op_b) ? 32'd1 : 32'd0;
assign  result_xor  =   i_op_a ^ i_op_b;
assign  result_srl  =   i_op_a >> i_op_b[4:0];
assign  result_sra  =   i_op_a >>> i_op_b[4:0];
assign  result_or   =   i_op_a | i_op_b;
assign  result_and  =   i_op_a & i_op_b;

always @(*) begin
    case(i_alu_op)
        ALU_ADD:    begin  o_alu_result = result_add;   end
        ALU_SUB:    begin  o_alu_result = result_sub;   end
        ALU_SLL:    begin  o_alu_result = result_sll;   end
        ALU_SLT:    begin  o_alu_result = result_slt;   end
        ALU_SLTU:   begin  o_alu_result = result_sltu;  end
        ALU_XOR:    begin  o_alu_result = result_xor;   end
        ALU_SRL:    begin  o_alu_result = result_srl;   end
        ALU_SRA:    begin  o_alu_result = result_sra;   end
        ALU_OR:     begin  o_alu_result = result_or;    end
        ALU_AND:    begin  o_alu_result = result_and;   end
        default:    begin  o_alu_result = 32'd0;        end
    endcase
end

endmodule
