/*******************************************************************/
//                           DEVICE SELECT                         //
/*******************************************************************/

`timescale 1ns/1ps

module device_sel (   
    input   [ 3:0]  i_dev_addr,
    input   [31:0]  i_ram_rdata,
    input   [31:0]  i_gpio_rdata,
    input   [31:0]  i_uart_rdata,
    input   [31:0]  i_timer_rdata,
    input   [31:0]  i_spi_rdata,
    output  [31:0]  o_mem_rdata,
    output          o_sel_mem,
    output          o_sel_gpio,
    output          o_sel_uart,
    output          o_sel_timer,
    output          o_sel_spi
);


assign o_mem_rdata =    (i_dev_addr == 4'h0) ? i_ram_rdata :
                        (i_dev_addr == 4'h4) ? i_gpio_rdata :
                        (i_dev_addr == 4'h5) ? i_uart_rdata :
                        (i_dev_addr == 4'h6) ? i_timer_rdata :
                        (i_dev_addr == 4'h8) ? i_spi_rdata :  32'd0;
assign o_sel_mem   =    (i_dev_addr == 4'h0);
assign o_sel_gpio  =    (i_dev_addr == 4'h4);
assign o_sel_uart  =    (i_dev_addr == 4'h5);
assign o_sel_timer =    (i_dev_addr == 4'h6);
assign o_sel_spi   =    (i_dev_addr == 4'h8);

endmodule
