`timescale 1ns/1ps
        /////////////////////////////////////////////////////////
        /////    ---     AETHER SOC - RV32I CORE     ---    /////
        /////   Designed by Yagiz Yagmur                    /////
        /////   Version:    v0.0.1                          /////
        /////////////////////////////////////////////////////////

module rv32_core (
    input           clk,
    input           rstn,
    input           dmem_rvalid,
    input   [31:0]  dmem_rdata,
    output  [31:0]  dmem_addr,
    output  [31:0]  dmem_wdata,
    output  [ 3:0]  dmem_wmask,
    output          dmem_wen,
    output          dmem_ren
);

/***************************  PARAMETERS  ***************************/

//                  Parameter           Opcode          Description                         Instructions                                                //
//localparam  [6:0]   OPCODE_LUI      =   7'b0110111;     // Load Upper Immediate             (LUI)
//localparam  [6:0]   OPCODE_AUIPC    =   7'b0010111;     // Add Upper Immediate to PC        (AUIPC)
//localparam  [6:0]   OPCODE_ALU      =   7'b0110011;     // ALU Instructions                 (ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND)
//localparam  [6:0]   OPCODE_ALUI     =   7'b0010011;     // ALU Immediate Instructions       (ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI)
//localparam  [6:0]   OPCODE_STORE    =   7'b0100011;     // Store Instructions               (SB, SH, SW)
localparam  [6:0]   OPCODE_LOAD     =   7'b0000011;     // Load Instructions                (LB, LH, LW, LBU, LHU)
//localparam  [6:0]   OPCODE_BRANCH   =   7'b1100011;     // Branch Instructions              (BEQ, BNE, BLT, BGE, BLTU, BGEU)
localparam  [6:0]   OPCODE_JAL      =   7'b1101111;     // Jump and Link                    (JAL)
localparam  [6:0]   OPCODE_JALR     =   7'b1100111;     // Jump and Link Register           (JALR)

localparam  MEM_SIZE = 2048;
localparam  MEM_FILE = "firmware/firmware.hex";   

/*******************************************************************/
//                      F E T C H     S T A G E                    //
/*******************************************************************/

wire    [31:0]  instr;
reg     [31:0]  pc;
reg     [31:0]  pc_prev;
reg     [31:0]  instr_reg;
wire    [31:0]  pc_next;
wire            branch_taken;
wire            stall;

wire    [31:0]  imem_rdata;
wire    [31:0]  imem_addr;

reg             phase;

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        pc_prev     <= 32'd0;
        pc          <= 32'd0;
        instr_reg   <= 32'h00000013;
        phase       <= 0;
    end
    else begin
        pc         <= pc_next;
        pc_prev    <= pc;
        if (phase) begin
            instr_reg  <= imem_rdata;    
        end        
        phase <= ~phase;
    end 
end    

assign imem_addr = pc;
assign instr = instr_reg;

/*************************  PROGRAM COUNTER  ***********************/

assign pc_next =    (branch & branch_taken) ?   (pc_prev + imm_data) :
                    (opcode == OPCODE_JAL)  ?   (pc_prev + imm_data) :
                    (opcode == OPCODE_JALR) ?   {alu_result[31:1], 1'b0} :
                                                pc_prev + 4;  

/***********************  INSTRUCTION MEMORY  **********************/

instr_mem #(
    .MEM_FILE   (MEM_FILE),
    .MEM_SIZE   (MEM_SIZE)
) instr_mem (
    .mem_addr   (imem_addr),       
    .mem_rdata  (imem_rdata)
);

/*******************************************************************/
//                     D E C O D E    S T A G E                    //
/*******************************************************************/

/*****************************  DECODER  ***************************/

wire    [6:0]   opcode;
wire    [2:0]   funct3;
wire            branch;
wire    [1:0]   result_mux;
wire    [2:0]   branch_op;
wire            alu_src_a;
wire            mem_write;
wire    [3:0]   mem_mask;
wire            alu_src_b;
wire            reg_write;
wire    [3:0]   alu_op;
wire    [4:0]   rs1_addr;
wire    [4:0]   rs2_addr;
wire    [4:0]   rd_addr;
wire    [31:0]  imm_data;

decoder instr_decoder (
    .i_instr        (instr),
    .o_opcode       (opcode),
    .o_funct3       (funct3),
    .o_branch       (branch),
    .o_result_mux   (result_mux),
    .o_branch_op    (branch_op),
    .o_alu_src_a    (alu_src_a),
    .o_mem_write    (mem_write),
    .o_mem_mask     (mem_mask),
    .o_alu_src_b    (alu_src_b),
    .o_reg_write    (reg_write),
    .o_alu_op       (alu_op),
    .o_rs1_addr     (rs1_addr),
    .o_rs2_addr     (rs2_addr),
    .o_rd_addr      (rd_addr),
    .o_imm          (imm_data)
);

/*******************************************************************/
//                     E X E C U T E   S T A G E                   //
/*******************************************************************/

/*****************************  ALU MUX  ***************************/

wire    [31:0]  alu_op_a;
wire    [31:0]  alu_op_b;

assign  alu_op_a    =   alu_src_a ? pc_prev  : rs1_data;
assign  alu_op_b    =   alu_src_b ? imm_data : rs2_data;

/******************************  ALU  ******************************/

wire    [31:0]  alu_result;

alu alu (
    .i_alu_op       (alu_op),
    .i_op_a         (alu_op_a),
    .i_op_b         (alu_op_b),
    .o_alu_result   (alu_result)
);

/****************************  BRANCH  *****************************/

branch_unit branch_unit (
    .funct3         (branch_op),
    .rs1            (rs1_data),
    .rs2            (rs2_data),
    .branch_taken   (branch_taken)
);

/************************ EX - MEM PIPELINE *************************/

reg     [31:0]  alu_result_reg;
reg     [4:0]   rd_addr_reg;
reg     [2:0]   funct3_reg;
reg     [1:0]   result_mux_reg;
reg             mem_write_reg;
reg     [3:0]   mem_mask_reg;
reg             reg_write_reg;
reg             load_valid_reg;
reg     [31:0]  pc_prev_reg;
reg     [31:0]  imm_data_reg;
reg     [31:0]  rs1_data_reg;
reg     [31:0]  rs2_data_reg;
reg     [31:0]  rd_data_reg;


always @ (posedge clk or negedge rstn) begin
    if (~rstn) begin
        alu_result_reg  <= 0; 
        rd_addr_reg     <= 0; 
        funct3_reg      <= 0; 
        result_mux_reg  <= 0; 
        mem_write_reg   <= 0; 
        mem_mask_reg    <= 0; 
        reg_write_reg   <= 0; 
        load_valid_reg  <= 0; 
        pc_prev_reg     <= 0;
        imm_data_reg    <= 0;
        rs1_data_reg    <= 0;
        rs2_data_reg    <= 0;
    end
    else begin
        alu_result_reg  <= alu_result; 
        rd_addr_reg     <= rd_addr; 
        funct3_reg      <= funct3; 
        result_mux_reg  <= result_mux; 
        mem_write_reg   <= mem_write; 
        mem_mask_reg    <= mem_mask; 
        reg_write_reg   <= reg_write; 
        load_valid_reg  <= (opcode == OPCODE_LOAD); 
        pc_prev_reg     <= pc_prev;
        imm_data_reg    <= imm_data;
        rs1_data_reg    <= rs1_data;
        rs2_data_reg    <= rs2_data;
    end
end

/*******************************************************************/
//          M E M O R Y / W R I T E B A C K   S T A G E            //
/*******************************************************************/

/**********************  WRITEBACK MUX   ************************/

assign rd_data =
    (result_mux_reg == 2'b00) ? alu_result_reg  :           // ALU
    (result_mux_reg == 2'b01) ? load_data   :               // LOAD
    (result_mux_reg == 2'b10) ? (pc_prev_reg + 4)    :      // JAL / JALR
    (result_mux_reg == 2'b11) ? imm_data_reg    : 32'b0;    // LUI

/***************************  REGFILE  ****************************/

wire    [31:0]  rs1_data;
wire    [31:0]  rs2_data;
wire    [31:0]  rd_data;
wire            wb_en;

assign wb_en = reg_write_reg;

regfile regfile(
    .clk        (clk),
    .rstn       (rstn),
    .i_wen      (wb_en),
    .i_rd       (rd_data),
    .i_rd_addr  (rd_addr_reg),
    .i_rs1_addr (rs1_addr),
    .i_rs2_addr (rs2_addr),
    .o_rs1      (rs1_data),
    .o_rs2      (rs2_data)  
);

/***************************  LOAD    ****************************/

wire    [7:0]   load_byte;
wire    [15:0]  load_halfword;
reg     [31:0]  load_data;

assign load_byte = (alu_result_reg[1:0] == 2'b00) ? dmem_rdata[7:0]   :
                   (alu_result_reg[1:0] == 2'b01) ? dmem_rdata[15:8]  :
                   (alu_result_reg[1:0] == 2'b10) ? dmem_rdata[23:16] :
                                                    dmem_rdata[31:24];

assign load_halfword = alu_result_reg[1] ? dmem_rdata[31:16] : dmem_rdata[15:0];

always @(*) begin
    case (funct3_reg)
        3'b000:  load_data = {{24{load_byte[7]}}, load_byte};            // LB
        3'b001:  load_data = {{16{load_halfword[15]}}, load_halfword};   // LH
        3'b010:  load_data = dmem_rdata;                                 // LW
        3'b100:  load_data = {24'b0, load_byte};                         // LBU
        3'b101:  load_data = {16'b0, load_halfword};                     // LHU
        default: load_data = 32'b0;
    endcase
end

/**********************   BUS CONNECTION   ***********************/

assign dmem_addr  = (dmem_ren | dmem_wen) ? alu_result_reg : 32'hFFFF_FFFF;
assign dmem_wdata = rs2_data_reg;
assign dmem_wmask = mem_write_reg ? (mem_mask_reg << alu_result_reg[1:0]) : 4'b0000;
assign dmem_wen   = mem_write_reg;
assign dmem_ren   = load_valid_reg;

endmodule
