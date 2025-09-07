// Created with Corsair v1.0.4
#ifndef __TIMER_REGS_H
#define __TIMER_REGS_H

#define __I  volatile const // 'read only' permissions
#define __O  volatile       // 'write only' permissions
#define __IO volatile       // 'read / write' permissions


#ifdef __cplusplus
#include <cstdint>
extern "C" {
#else
#include <stdint.h>
#endif

#define TIMER_BASE_ADDR 0x60000000

// TIMER_CTRL - TIMER CONTROL REGISTER
#define TIMER_TIMER_CTRL_ADDR 0x0
#define TIMER_TIMER_CTRL_RESET 0x0
typedef struct {
    uint32_t TMR_EN : 1; // Enable Timer
    uint32_t PWM_EN : 1; // PWM Timer Enable
    uint32_t TMR_DONE : 1; // Timer Done Flags
    uint32_t : 29; // reserved
} timer_timer_ctrl_t;

// TIMER_CTRL.TMR_EN - Enable Timer
#define TIMER_TIMER_CTRL_TMR_EN_WIDTH 1
#define TIMER_TIMER_CTRL_TMR_EN_LSB 0
#define TIMER_TIMER_CTRL_TMR_EN_MASK 0x1
#define TIMER_TIMER_CTRL_TMR_EN_RESET 0x0

// TIMER_CTRL.PWM_EN - PWM Timer Enable
#define TIMER_TIMER_CTRL_PWM_EN_WIDTH 1
#define TIMER_TIMER_CTRL_PWM_EN_LSB 1
#define TIMER_TIMER_CTRL_PWM_EN_MASK 0x2
#define TIMER_TIMER_CTRL_PWM_EN_RESET 0x0

// TIMER_CTRL.TMR_DONE - Timer Done Flags
#define TIMER_TIMER_CTRL_TMR_DONE_WIDTH 1
#define TIMER_TIMER_CTRL_TMR_DONE_LSB 2
#define TIMER_TIMER_CTRL_TMR_DONE_MASK 0x4
#define TIMER_TIMER_CTRL_TMR_DONE_RESET 0x0

// TIMER0 - Timer0 Delay Register
#define TIMER_TIMER0_ADDR 0x4
#define TIMER_TIMER0_RESET 0x0
typedef struct {
    uint32_t DELAY : 32; // Timer Delay
} timer_timer0_t;

// TIMER0.DELAY - Timer Delay
#define TIMER_TIMER0_DELAY_WIDTH 32
#define TIMER_TIMER0_DELAY_LSB 0
#define TIMER_TIMER0_DELAY_MASK 0xffffffff
#define TIMER_TIMER0_DELAY_RESET 0x0

// PWM0 - PWM0 Delay Register
#define TIMER_PWM0_ADDR 0x8
#define TIMER_PWM0_RESET 0x0
typedef struct {
    uint32_t PERIOD : 16; // PWM0 Period
    uint32_t DUTY_CYCLE : 16; // PWM0 Duty Cycle
} timer_pwm0_t;

// PWM0.PERIOD - PWM0 Period
#define TIMER_PWM0_PERIOD_WIDTH 16
#define TIMER_PWM0_PERIOD_LSB 0
#define TIMER_PWM0_PERIOD_MASK 0xffff
#define TIMER_PWM0_PERIOD_RESET 0x0

// PWM0.DUTY_CYCLE - PWM0 Duty Cycle
#define TIMER_PWM0_DUTY_CYCLE_WIDTH 16
#define TIMER_PWM0_DUTY_CYCLE_LSB 16
#define TIMER_PWM0_DUTY_CYCLE_MASK 0xffff0000
#define TIMER_PWM0_DUTY_CYCLE_RESET 0x0


// Register map structure
typedef struct {
    union {
        __IO uint32_t TIMER_CTRL; // TIMER CONTROL REGISTER
        __IO timer_timer_ctrl_t TIMER_CTRL_bf; // Bit access for TIMER_CTRL register
    };
    union {
        __O uint32_t TIMER0; // Timer0 Delay Register
        __O timer_timer0_t TIMER0_bf; // Bit access for TIMER0 register
    };
    union {
        __O uint32_t PWM0; // PWM0 Delay Register
        __O timer_pwm0_t PWM0_bf; // Bit access for PWM0 register
    };
} timer_t;

#define TIMER ((timer_t*)(TIMER_BASE_ADDR))

#ifdef __cplusplus
}
#endif

#endif /* __TIMER_REGS_H */