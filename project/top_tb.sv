/*******************************************************************/
//                     TESTBENCH FOR AETHER SOC                    //
/*******************************************************************/
`timescale 1ns/1ps

module top_tb;

//////////////     ---     SIGNALS     ---     //////////////

localparam CLK_PERIOD = 10;
reg             clk;
reg             rstn;
wire    [3:0]   gpio_led;
reg     [3:0]   gpio_sw;
reg     [11:0]  gpio_in;
reg             uart_rx;
wire            uart_tx;
wire            spi_clk;
reg             i_spi_miso;
wire            spi_miso;
wire            spi_mosi;
wire            spi_slave_csn;
wire    [3:0]   spi_master_cs;

//////////////     ---     UUT     ---     //////////////

aether_soc uut (
    .clk            (clk),
    .rstn           (rstn),
    .gpio_led       (gpio_led),
    .gpio_sw        (gpio_sw),
    .gpio_in        (gpio_in),
    .uart_rx        (uart_rx),
    .uart_tx        (uart_tx),
    .spi_clk        (spi_clk),
    .spi_miso       (spi_miso),
    .spi_mosi       (spi_mosi),
    .spi_slave_csn  (spi_slave_csn),
    .spi_master_cs  (spi_master_cs)
);

//////////////     ---     TESTBENCH     ---     //////////////

initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end

initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, uut);
end

initial begin
    rstn    = 1'bx;
    #(CLK_PERIOD*3);
    rstn    = 1;
    #(CLK_PERIOD*3);
    rstn    = 0;
    repeat(5) @(posedge clk);
    rstn    = 1;
    @(posedge clk);

    //  - - - - - - POSSIBLE TESTBENCHES - - - - - - //
    // Uncomment one of the following lines for testing
    // a specific peripheral
    // simulate_uart_receive(8'h41);    // UART RX TEST
    
    // simulate_in_sw(4'b0100);         // SW - LED TEST

    // simulate_in_gpio(12'h001);       // IN - OUT TEST

    // simulate_spi_miso(8'h41);        // SPI MISO TEST

    repeat(50000) @(posedge clk);
    $finish;
end

//////////////     ---     TASKS     ---     //////////////

// Simulate UART Receiving a Byte
task simulate_uart_receive(input [7:0] rx_data);
integer i;
begin
    uart_rx = 0; // Start Bit
    #104166; // 9600 baud period (Assuming 100MHz clock)

    for (i = 0; i < 8; i = i + 1) begin
        uart_rx = rx_data[i];
        #104166;
    end

    uart_rx = 1; // Stop Bit
    #104166;
end
endtask

// Simulate Input Switch Control
task simulate_in_sw(input [3:0] gpio_sel);
begin
    gpio_sw = 4'b0000;
    #50000;
    gpio_sw = gpio_sel;
    #50000;
    gpio_sw = 4'b0000;
end
endtask

// Simulate Input Port Control
task simulate_in_gpio(input [11:0] gpio_sel);
begin
    gpio_in = 12'h000;
    #50000;
    gpio_in = gpio_sel;
    #50000;
    gpio_in = 12'h000;
end
endtask

// Simulate SPI MISO Receiver
task simulate_spi_miso(input [7:0] miso_data);
integer i;
begin
    @(posedge spi_clk);
    for (i = 0; i < 8; i = i + 1) begin
        i_spi_miso = miso_data[7 - i];
        @(posedge spi_clk);
    end
end
endtask
assign spi_miso = i_spi_miso;


endmodule
