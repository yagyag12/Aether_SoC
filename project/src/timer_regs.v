// Created with Corsair v1.0.4

module timer_regs (
    // System
    input clk,
    input rst,
    // TIMER_CTRL.TMR_EN
    output  csr_timer_ctrl_tmr_en_out,
    // TIMER_CTRL.PWM_EN
    output  csr_timer_ctrl_pwm_en_out,
    // TIMER_CTRL.TMR_DONE
    input  csr_timer_ctrl_tmr_done_in,

    // TIMER0.DELAY
    output [31:0] csr_timer0_delay_out,

    // PWM0.PERIOD
    output [15:0] csr_pwm0_period_out,
    // PWM0.DUTY_CYCLE
    output [15:0] csr_pwm0_duty_cycle_out,

    // Local Bus
    input  [31:0] waddr,
    input  [31:0] wdata,
    input         wen,
    input  [ 3:0] wstrb,
    output        wready,
    input  [31:0] raddr,
    input         ren,
    output [31:0] rdata,
    output        rvalid
);
//------------------------------------------------------------------------------
// CSR:
// [0x0] - TIMER_CTRL - TIMER CONTROL REGISTER
//------------------------------------------------------------------------------
wire [31:0] csr_timer_ctrl_rdata;
assign csr_timer_ctrl_rdata[31:3] = 29'h0;

wire csr_timer_ctrl_wen;
assign csr_timer_ctrl_wen = wen && (waddr == 32'h0);

//---------------------
// Bit field:
// TIMER_CTRL[0] - TMR_EN - Enable Timer
// access: wosc, hardware: o
//---------------------
reg  csr_timer_ctrl_tmr_en_ff;

assign csr_timer_ctrl_rdata[0] = 1'b0;

assign csr_timer_ctrl_tmr_en_out = csr_timer_ctrl_tmr_en_ff;

always @(posedge clk) begin
    if (!rst) begin
        csr_timer_ctrl_tmr_en_ff <= 1'b0;
    end else  begin
     if (csr_timer_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_timer_ctrl_tmr_en_ff <= wdata[0];
            end
        end else begin
            csr_timer_ctrl_tmr_en_ff <= 1'b0;
        end
    end
end

//---------------------
// Bit field:
// TIMER_CTRL[1] - PWM_EN - PWM Timer Enable
// access: rw, hardware: o
//---------------------
reg  csr_timer_ctrl_pwm_en_ff;

assign csr_timer_ctrl_rdata[1] = csr_timer_ctrl_pwm_en_ff;

assign csr_timer_ctrl_pwm_en_out = csr_timer_ctrl_pwm_en_ff;

always @(posedge clk) begin
    if (!rst) begin
        csr_timer_ctrl_pwm_en_ff <= 1'b0;
    end else  begin
     if (csr_timer_ctrl_wen) begin
            if (wstrb[0]) begin
                csr_timer_ctrl_pwm_en_ff <= wdata[1];
            end
        end else begin
            csr_timer_ctrl_pwm_en_ff <= csr_timer_ctrl_pwm_en_ff;
        end
    end
end


//---------------------
// Bit field:
// TIMER_CTRL[2] - TMR_DONE - Timer Done Flags
// access: ro, hardware: i
//---------------------
reg  csr_timer_ctrl_tmr_done_ff;

assign csr_timer_ctrl_rdata[2] = csr_timer_ctrl_tmr_done_ff;


always @(posedge clk) begin
    if (!rst) begin
        csr_timer_ctrl_tmr_done_ff <= 1'b0;
    end else  begin
              begin            csr_timer_ctrl_tmr_done_ff <= csr_timer_ctrl_tmr_done_in;
        end
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x4] - TIMER0 - Timer0 Delay Register
//------------------------------------------------------------------------------
wire [31:0] csr_timer0_rdata;

wire csr_timer0_wen;
assign csr_timer0_wen = wen && (waddr == 32'h4);

//---------------------
// Bit field:
// TIMER0[31:0] - DELAY - Timer Delay
// access: wo, hardware: o
//---------------------
reg [31:0] csr_timer0_delay_ff;

assign csr_timer0_rdata[31:0] = 32'h0;

assign csr_timer0_delay_out = csr_timer0_delay_ff;

always @(posedge clk) begin
    if (!rst) begin
        csr_timer0_delay_ff <= 32'h0;
    end else  begin
     if (csr_timer0_wen) begin
            if (wstrb[0]) begin
                csr_timer0_delay_ff[7:0] <= wdata[7:0];
            end
            if (wstrb[1]) begin
                csr_timer0_delay_ff[15:8] <= wdata[15:8];
            end
            if (wstrb[2]) begin
                csr_timer0_delay_ff[23:16] <= wdata[23:16];
            end
            if (wstrb[3]) begin
                csr_timer0_delay_ff[31:24] <= wdata[31:24];
            end
        end else begin
            csr_timer0_delay_ff <= csr_timer0_delay_ff;
        end
    end
end


//------------------------------------------------------------------------------
// CSR:
// [0x8] - PWM0 - PWM0 Delay Register
//------------------------------------------------------------------------------
wire [31:0] csr_pwm0_rdata;

wire csr_pwm0_wen;
assign csr_pwm0_wen = wen && (waddr == 32'h8);

//---------------------
// Bit field:
// PWM0[15:0] - PERIOD - PWM0 Period
// access: wo, hardware: o
//---------------------
reg [15:0] csr_pwm0_period_ff;

assign csr_pwm0_rdata[15:0] = 16'h0;

assign csr_pwm0_period_out = csr_pwm0_period_ff;

always @(posedge clk) begin
    if (!rst) begin
        csr_pwm0_period_ff <= 16'h0;
    end else  begin
     if (csr_pwm0_wen) begin
            if (wstrb[0]) begin
                csr_pwm0_period_ff[7:0] <= wdata[7:0];
            end
            if (wstrb[1]) begin
                csr_pwm0_period_ff[15:8] <= wdata[15:8];
            end
        end else begin
            csr_pwm0_period_ff <= csr_pwm0_period_ff;
        end
    end
end


//---------------------
// Bit field:
// PWM0[31:16] - DUTY_CYCLE - PWM0 Duty Cycle
// access: wo, hardware: o
//---------------------
reg [15:0] csr_pwm0_duty_cycle_ff;

assign csr_pwm0_rdata[31:16] = 16'h0;

assign csr_pwm0_duty_cycle_out = csr_pwm0_duty_cycle_ff;

always @(posedge clk) begin
    if (!rst) begin
        csr_pwm0_duty_cycle_ff <= 16'h0;
    end else  begin
     if (csr_pwm0_wen) begin
            if (wstrb[2]) begin
                csr_pwm0_duty_cycle_ff[7:0] <= wdata[23:16];
            end
            if (wstrb[3]) begin
                csr_pwm0_duty_cycle_ff[15:8] <= wdata[31:24];
            end
        end else begin
            csr_pwm0_duty_cycle_ff <= csr_pwm0_duty_cycle_ff;
        end
    end
end


//------------------------------------------------------------------------------
// Write ready
//------------------------------------------------------------------------------
assign wready = 1'b1;

//------------------------------------------------------------------------------
// Read address decoder
//------------------------------------------------------------------------------

assign rdata =  (raddr == 32'h0) ? csr_timer_ctrl_rdata :
                (raddr == 32'h4) ? csr_timer0_rdata :
                (raddr == 32'h8) ? csr_pwm0_rdata :
                32'h0;


//------------------------------------------------------------------------------
// Read data valid
//------------------------------------------------------------------------------

assign rvalid = ren;

endmodule
