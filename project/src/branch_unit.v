/*******************************************************************/
//                          BRANCH UNIT                            //
/*******************************************************************/

`timescale 1ns/1ps

module branch_unit (
    input  wire [2:0]  funct3,
    input  wire [31:0] rs1,
    input  wire [31:0] rs2,
    output reg         branch_taken
);

//////////////     ---     PARAMETERS     ---     //////////////
//          Instruction     funct3      Description
localparam  [2:0]  BEQ  =   3'b000;     // Branch Equal
localparam  [2:0]  BNE  =   3'b001;     // Branch Not Equal
localparam  [2:0]  BLT  =   3'b100;     // Branch Less Than
localparam  [2:0]  BGE  =   3'b101;     // Branch Greater Than or Equal
localparam  [2:0]  BLTU =   3'b110;     // Branch Less Than Unsigned
localparam  [2:0]  BGEU =   3'b111;     // Branch Greater Than or Equal Unsigned

//////////////     ---     SELECT BRANCH     ---     //////////////

always @(*) begin
    case (funct3)
        BEQ:     begin   branch_taken = (rs1 == rs2);                    end
        BNE:     begin   branch_taken = (rs1 != rs2);                    end
        BLT:     begin   branch_taken = ($signed(rs1) < $signed(rs2));   end
        BGE:     begin   branch_taken = ($signed(rs1) >= $signed(rs2));  end
        BLTU:    begin   branch_taken = (rs1 < rs2);                     end
        BGEU:    begin   branch_taken = (rs1 >= rs2);                    end
        default: begin   branch_taken = 1'b0;                            end
    endcase
end

endmodule
