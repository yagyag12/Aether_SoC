/*******************************************************************/
//                            DATA MEMORY                          //
/*******************************************************************/
`timescale 1ns/1ps

module data_mem #(
    parameter MEM_FILE = "",
    parameter MEM_SIZE = 1024
) (
    input           clk,            
    input   [31:0]  mem_addr,   
    input   [31:0]  mem_wdata,     
    input   [ 3:0]  mem_wmask,    
    input           mem_ren,   
    input           mem_wen,   
    output  [31:0]  mem_rdata,     
    output          mem_rvalid  
);

//////////////     ---     SIGNALS     ---     //////////////

reg     [31:0]  MEMORY      [0:MEM_SIZE-1];  
wire    [29:0]  word_addr;    
reg     [31:0]  mem_rdata_reg;
integer i;

//////////////     ---     MEMORY MANAGEMENT     ---     //////////////

initial begin
    for (i = 0; i < MEM_SIZE; i = i + 1)
        MEMORY[i] = 'h0;

    if (MEM_FILE != "")
        $readmemh(MEM_FILE, MEMORY);
end

assign word_addr  = mem_addr[31:2];

// READ
assign mem_rdata  = mem_ren ? MEMORY[word_addr] : 32'h00000000;
assign mem_rvalid = mem_ren;

// WRITE
always @(posedge clk) begin
    if (mem_wen) begin
        if (mem_wmask[0]) MEMORY[word_addr][ 7:0 ] <= mem_wdata[ 7:0 ];
        if (mem_wmask[1]) MEMORY[word_addr][15:8 ] <= mem_wdata[15:8 ];
        if (mem_wmask[2]) MEMORY[word_addr][23:16] <= mem_wdata[23:16];
        if (mem_wmask[3]) MEMORY[word_addr][31:24] <= mem_wdata[31:24];	    
    end
end

endmodule
