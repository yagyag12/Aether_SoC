/*******************************************************************/
//                         INSTRUCTION MEMORY                      //
/*******************************************************************/
`timescale 1ns/1ps

module instr_mem #(
    parameter MEM_FILE = "",
    parameter MEM_SIZE = 1024
) (
    input   [31:0]  mem_addr,       
    output  [31:0]  mem_rdata       
);

//////////////     ---     SIGNALS     ---     //////////////

reg     [31:0]  MEMORY      [0:MEM_SIZE-1];  
wire    [29:0]  word_addr;    
integer i;

//////////////     ---     MEMORY MANAGEMENT     ---     //////////////

//  INIT MEMORY
initial begin
    for (i = 0; i < MEM_SIZE; i = i + 1) begin
        MEMORY[i] = 'h0;
    end
    if (MEM_FILE != 0) begin
        $readmemh(MEM_FILE,MEMORY);
    end
end

//  READ MEMORY
assign word_addr = mem_addr[31:2];
assign mem_rdata = MEMORY[word_addr];

endmodule
