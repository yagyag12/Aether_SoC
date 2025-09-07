/*******************************************************************/
//                        UART TRANSMITTER                         //
/*******************************************************************/
`timescale 1ns/1ps 

module uart_tx (
    input           clk,
    input           rst,
    input           tick,
    input           i_tx_en,        
    input   [7:0]   i_data,
    input           i_valid,
    output  reg     o_ready,        
    output  reg     o_done,         
    output          o_tx            
);

//////////////     ---     SIGNALS     ---     //////////////

reg [9:0] frame;
reg [3:0] bit_counter;
reg       o_load;

//////////////     ---     CONTROL     ---     //////////////

always @(posedge clk) begin
    if (rst | ~i_tx_en) begin
        o_ready     <= 1;
        frame       <= 10'b1111111111; 
        bit_counter <= 0;
        o_done      <= 0;
        o_load      <= 0;
    end
    else begin
        if (i_valid & o_ready) begin
            frame       <= 10'b1111111111; 
            o_ready     <= 0;
            bit_counter <= 0;
            o_done      <= 0;
            o_load      <= 1;
        end
        else if (o_load) begin
            o_load      <= 0;
            frame       <= {1'b1, i_data, 1'b0};
        end 
        else if (tick & !o_ready) begin
            if (bit_counter < 9) begin
                frame       <= {1'b0, frame[9:1]};
                bit_counter <= bit_counter + 1;
            end
            else begin
                o_ready <= 1;
                o_done  <= 1;
            end
        end    
        end
end

assign o_tx = frame[0];

endmodule
