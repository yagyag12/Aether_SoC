/*******************************************************************/
//                       INSTRUCTION DECODER                       //
/*******************************************************************/

`timescale 1ns/1ps

module decoder (
    input       [31:0]  i_instr,
    output      [6:0]   o_opcode,
    output      [2:0]   o_funct3,
    output  reg         o_branch,
    output  reg [1:0]   o_result_mux,
    output  reg [2:0]   o_branch_op,
    output  reg         o_mem_write,
    output  reg [3:0]   o_mem_mask,
    output  reg         o_alu_src_a,
    output  reg         o_alu_src_b,
    output  reg         o_reg_write,
    output  reg [3:0]   o_alu_op,
    output      [4:0]   o_rs1_addr,
    output      [4:0]   o_rs2_addr,
    output      [4:0]   o_rd_addr,
    output  reg [31:0]  o_imm
);

//////////////     ---     OPCODES     ---     //////////////
//                  Parameter           Opcode          Description                         Instructions                                                //
localparam  [6:0]   OPCODE_LUI      =   7'b0110111;     // Load Upper Immediate             (LUI)
localparam  [6:0]   OPCODE_AUIPC    =   7'b0010111;     // Add Upper Immediate to PC        (AUIPC)
localparam  [6:0]   OPCODE_ALU      =   7'b0110011;     // ALU Instructions                 (ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND)
localparam  [6:0]   OPCODE_ALUI     =   7'b0010011;     // ALU Immediate Instructions       (ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI)
localparam  [6:0]   OPCODE_STORE    =   7'b0100011;     // Store Instructions               (SB, SH, SW)
localparam  [6:0]   OPCODE_LOAD     =   7'b0000011;     // Load Instructions                (LB, LH, LW, LBU, LHU)
localparam  [6:0]   OPCODE_BRANCH   =   7'b1100011;     // Branch Instructions              (BEQ, BNE, BLT, BGE, BLTU, BGEU)
localparam  [6:0]   OPCODE_JAL      =   7'b1101111;     // Jump and Link                    (JAL)
localparam  [6:0]   OPCODE_JALR     =   7'b1100111;     // Jump and Link Register           (JALR)

//////////////     ---     FIELDS     ---     //////////////
wire o_funct7b5;
assign  o_funct3    = i_instr[14:12];
assign  o_funct7b5  = i_instr[30];
assign  o_opcode    = i_instr[6:0];
assign  o_rd_addr   = i_instr[11:7];
assign  o_rs1_addr  = i_instr[19:15];
assign  o_rs2_addr  = i_instr[24:20];

//////////////     ---     IMMEDIATE     ---     //////////////
wire [31:0] imm_u = {i_instr[31:12], {12{1'b0}}};   // imm[31:12] | rd | opcode
wire [31:0] imm_i = {{21{i_instr[31]}}, i_instr[30:20]};    // imm[31:20] | rs1 | funct3 | rd | opcode
wire [31:0] imm_s = {{21{i_instr[31]}}, i_instr[30:25], i_instr[11:7]}; // imm[31:25] | rs2 | rs1 | funct3 | imm[11:7] | opcode
wire [31:0] imm_b = {{20{i_instr[31]}}, i_instr[7],i_instr[30:25],i_instr[11:8],1'b0};  // imm[31] | imm[7] | rs2 | rs1 | funct3 | imm[11:8] | imm[30:25] | opcode
wire [31:0] imm_j = {{12{i_instr[31]}}, i_instr[19:12],i_instr[20],i_instr[30:21],1'b0};    // imm[31] | imm[19:12] | imm[20] | imm[30:21] | rd | opcode

//////////////     ---     DECODING     ---     //////////////
//  o_alu_src_a: 1 = pc  / 0 = rs1  //
//  o_alu_src_b: 1 = imm / 0 = rs2  //
//  o_reg_write: Write to regfile   //

always @(*) begin
    // defaults
    o_branch     = 0;
    o_result_mux = 2'b00;
    o_branch_op  = 3'b000;
    o_mem_write  = 0;
    o_mem_mask   = 4'b0000;
    o_alu_src_a  = 0;
    o_alu_src_b  = 0;
    o_reg_write  = 0;
    o_alu_op     = 4'b0000;
    o_imm        = 32'd0;

    case (o_opcode)
        OPCODE_ALU: begin
            o_reg_write     = 1;
            o_alu_src_a     = 0;
            o_alu_src_b     = 0; 
            o_alu_op        = {o_funct7b5, o_funct3};
            o_imm           = 32'd0;
        end

        OPCODE_ALUI: begin
            o_reg_write     = 1;
            o_alu_src_a     = 0;    
            o_alu_src_b     = 1;
            o_alu_op        = (o_funct3 == 3'b101) ?    {o_funct7b5, o_funct3} :
                                                        {1'b0, o_funct3};
            o_imm           = imm_i;
        end

        OPCODE_LOAD: begin
            o_reg_write     = 1;
            o_alu_src_a     = 0;    
            o_alu_src_b     = 1; 
            o_result_mux    = 2'b01;    // data memory
            o_alu_op        = 4'b0000; 
            o_imm           = imm_i;
        end

        OPCODE_STORE: begin
            o_mem_write     = 1;
            o_alu_src_a     = 0;    
            o_alu_src_b     = 1;    
            o_alu_op        = 4'b0000; 

            // Bit Masking
            case (o_funct3) 
                3'b000: begin o_mem_mask = 4'b0001; end // Store Byte
                3'b001: begin o_mem_mask = 4'b0011; end // Store Halfword
                3'b010: begin o_mem_mask = 4'b1111; end // Store Word
                default:begin o_mem_mask = 4'b0000; end
            endcase

            o_imm           = imm_s;
        end

        OPCODE_BRANCH: begin
            o_branch        = 1;
            o_branch_op     = o_funct3;
            o_alu_op        = 4'b0001; 
            o_imm           = imm_b;
        end

        OPCODE_JAL: begin
            //o_branch        = 1;
            o_result_mux    = 2'b10; 
            o_reg_write     = 1;
            o_imm           = imm_j;
        end

        OPCODE_JALR: begin
            //o_branch        = 1;
            o_result_mux    = 2'b10;
            o_reg_write     = 1;
            o_alu_op        = 4'b0000; 
            o_imm           = imm_i;
        end

        OPCODE_LUI: begin
            o_result_mux    = 2'b11; 
            o_reg_write     = 1;
            o_imm           = imm_u;
        end

        OPCODE_AUIPC: begin
            o_alu_src_a     = 1;
            o_alu_src_b     = 1; 
            o_alu_op        = 4'b0000; 
            o_reg_write     = 1;
            o_result_mux    = 2'b00;
            o_imm           = imm_u;
        end
        default: begin
            o_branch     = 0;
            o_result_mux = 2'b00;
            o_branch_op  = 3'b000;
            o_mem_write  = 0;
            o_mem_mask   = 4'b0000;
            o_alu_src_a  = 0;
            o_alu_src_b  = 0;
            o_reg_write  = 0;
            o_alu_op     = 4'b0000;
            o_imm        = 32'd0;
        end
    endcase
end

endmodule
