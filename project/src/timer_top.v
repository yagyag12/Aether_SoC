/*******************************************************************/
//                            TIMER CORE                           //
/*******************************************************************/
`timescale 1ns/1ps

module timer_top (
    input               clk,
    input               rstn,
    input   [31:0]      waddr,
    input   [31:0]      wdata,
    input               wen,
    input   [ 3:0]      wstrb,
    output              wready,
    input   [31:0]      raddr,
    input               ren,
    output  [31:0]      rdata,
    output              rvalid,
    output              pwm
);

//////////////     ---     SIGNALS     ---     //////////////

wire        timer_en;
wire        pwm_en;
wire [31:0] load_tmr0;
wire [15:0] load_pwm0;
wire [15:0] duty_cycle_pwm0;
wire        timeout_dly;

//////////////     ---     MODULE INSTANCES     ---     //////////////

// TIMERS
timers timers0 (
    .clk                (clk),
    .rstn               (rstn),
    .timer_en           (timer_en),
    .pwm_en             (pwm_en),
    .load_tmr0          (load_tmr0),
    .load_pwm0          (load_pwm0),
    .duty_cycle_pwm0    (duty_cycle_pwm0),
    .timeout_dly        (timeout_dly),
    .pwm                (pwm)
);    

// REGISTERS
timer_regs timer_regs (
    .clk(clk),
    .rst(rstn),
    .csr_timer_ctrl_tmr_done_in (timeout_dly),
    .csr_timer_ctrl_tmr_en_out  (timer_en),
    .csr_timer_ctrl_pwm_en_out  (pwm_en),
    .csr_timer0_delay_out       (load_tmr0),
    .csr_pwm0_period_out        (load_pwm0),
    .csr_pwm0_duty_cycle_out    (duty_cycle_pwm0),
    .waddr      (waddr),
    .wdata      (wdata),
    .wen        (wen),
    .wstrb      (wstrb),
    .wready     (wready),
    .raddr      (raddr),
    .ren        (ren),
    .rdata      (rdata),
    .rvalid     (rvalid)
);

endmodule
