#ifndef TIMER_H
#define TIMER_H

#include <stdint.h>
#include "timer_regs.h"

#define CLK_FREQ    100000000

// Set Delay in ms
void setDelayMili(uint32_t delay_ms);

// Set Delay in us
void setDelayMicro(uint32_t delay_us);

// Set PWM
void setPWM(uint16_t period_us, uint16_t duty_cycle);

// Stop PWM
void stopPWM();


#endif /* TIMER_H */