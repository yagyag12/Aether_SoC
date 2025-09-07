/*******************************************************************/
//                               TIMERS                            //
/*******************************************************************/
`timescale 1ns/1ps

module timers (
    input               clk,
    input               rstn,
    input               timer_en,
    input               pwm_en,
    input       [31:0]  load_tmr0,
    input       [15:0]  load_pwm0,
    input       [15:0]  duty_cycle_pwm0,
    output  reg         timeout_dly,
    output  reg         pwm
);

//////////////     ---     SIGNALS     ---     //////////////

reg [31:0]  counter_dly;
reg [15:0]  counter_pwm; 
reg         start_dly;
integer i;

//////////////     ---     TIMER CONTROL     ---     //////////////

always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
        for(i = 0; i < 2; i = i + 1) begin
            counter_dly <= 0;
            counter_pwm <= 0;
            timeout_dly <= 0;
            pwm         <= 0;
        end
    end
    else begin
        // TMR0
        if (timer_en) begin
            start_dly   <= 1;
            timeout_dly <= 0;
        end
        if (start_dly) begin
            if (counter_dly == load_tmr0 - 1) begin
                counter_dly  <= 0;
                timeout_dly  <= 1;
                start_dly    <= 0;
            end
            else begin
                counter_dly  <= counter_dly + 1;
                timeout_dly  <= 0;
            end
        end
        else begin
            counter_dly <= 0;
        end

        // PWM0
        if (pwm_en) begin
            if (counter_pwm  >= load_pwm0 - 1) begin
                counter_pwm  <= 0;
            end
            else begin
                counter_pwm <= counter_pwm + 1;
            end
            pwm             <= counter_pwm < duty_cycle_pwm0 ? 1 : 0;
        end
        else begin
            counter_pwm  <= 0;
            pwm          <= 0;
        end
    end
end

endmodule
