/*******************************************************************/
//                           UART RECEIVER                         //
/*******************************************************************/
`timescale 1ns/1ps

module uart_rx (
    input               clk,
    input               rst,
    input               tick,
    input               i_rx_en,
    input               i_rx,
    output  reg         o_ready,
    output  reg         o_done,
    output  reg         o_full,
    output  reg [7:0]   o_rx_data
);

//////////////     ---     SIGNALS     ---     //////////////

reg [3:0]   bit_counter;
reg [8:0]   frame;
reg [3:0]   sample_counter;

//////////////     ---     CONTROL     ---     //////////////

always @(posedge clk) begin
    if (rst) begin
        o_ready         <= 1;
        o_done          <= 0;
        o_full          <= 0;
        frame           <= 9'b111111111;
        bit_counter     <= 0;
        sample_counter  <= 0;
        o_rx_data       <= 0;
    end
    else begin
        if (i_rx_en & o_ready & ~i_rx) begin
            o_ready         <= 0;
            bit_counter     <= 0;
            sample_counter  <= 0;
            o_done          <= 0;
            o_full          <= 0;
        end
        else if (tick & !o_ready) begin
            if (sample_counter == 7) begin
                frame       <= {i_rx, frame[8:1]};
                bit_counter <= bit_counter + 1;
            end
            sample_counter  <= sample_counter + 1;
            if (bit_counter == 10 && sample_counter == 15) begin
                o_ready     <= 1;
                o_done      <= 1;
                o_full      <= 1;
                o_rx_data   <= frame[7:0];
            end
        end
    end
end

endmodule
