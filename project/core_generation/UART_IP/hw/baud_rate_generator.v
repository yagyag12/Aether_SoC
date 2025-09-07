/*******************************************************************/
//                        BAUD RATE GENERATOR                      //
/*******************************************************************/

`timescale 1ns/1ps

module baud_rate_generator (
    input           clk,
    input           rst,
    input           uart_en,
    input   [1:0]   baud_sel,
    output  reg     tx_tick,
    output  reg     rx_tick
);

///////////////////////   RX BAUD TICK VALUES   ///////////////////////

// For 100 MHz
localparam [10:0] RX_TICK_4800   = 1302;
localparam [9:0]  RX_TICK_9600   = 651;
localparam [6:0]  RX_TICK_57600  = 109;
localparam [5:0]  RX_TICK_115200 = 54;

// For 50 MHz
//localparam [9:0] RX_TICK_4800   = 651;
//localparam [8:0] RX_TICK_9600   = 326;
//localparam [5:0] RX_TICK_57600  = 54;
//localparam [4:0] RX_TICK_115200 = 27;

////////////////////////////   REGISTERS   ////////////////////////////

reg [10:0] rx_counter;
reg [3:0]  tx_counter;
reg [10:0] rx_tick_value;

//////////////////////   BAUD SELECT REGISTERED   //////////////////////

always @(posedge clk) begin
    if (rst) begin
        rx_tick_value <= RX_TICK_4800;
    end 
    else begin
        case (baud_sel)
            2'b00:   rx_tick_value <= RX_TICK_4800;
            2'b01:   rx_tick_value <= {1'b0, RX_TICK_9600};
            2'b10:   rx_tick_value <= {4'b0000, RX_TICK_57600};
            2'b11:   rx_tick_value <= {5'b00000, RX_TICK_115200};
            default: rx_tick_value <= RX_TICK_4800;
        endcase
    end
end

//////////////////////   RX & TX TICK GENERATION   //////////////////////

always @(posedge clk) begin
    if (rst) begin
        rx_counter <= 0;
        tx_counter <= 0;
        rx_tick    <= 1'b0;
        tx_tick    <= 1'b0;
    end 
    else begin
        rx_tick <= 1'b0;
        tx_tick <= 1'b0;

        if (!uart_en) begin
            rx_counter <= 0;
            tx_counter <= 0;
        end 
        else begin
            if (rx_counter == (rx_tick_value - 1)) begin
                rx_counter <= 0;
                rx_tick    <= 1'b1;      

                if (tx_counter == 4'd15) begin
                    tx_counter <= 0;
                    tx_tick    <= 1'b1;      
                end 
                else begin
                    tx_counter <= tx_counter + 1;
                end
            end 
            else begin
                rx_counter <= rx_counter + 1;
            end
        end
    end
end

endmodule
