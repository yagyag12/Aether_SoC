#include "timer.h"

#define MS_TO_CYCLES(ms)    ((CLK_FREQ / 1000) * (ms))
#define US_TO_CYCLES(us) ((CLK_FREQ / 1000000) * (us))

void setDelayMili(uint32_t delay_ms) {
    uint32_t cycles = MS_TO_CYCLES(delay_ms);
    TIMER->TIMER0 = cycles;
    TIMER->TIMER_CTRL_bf.TMR_EN = 1;
    while ((TIMER->TIMER_CTRL_bf.TMR_DONE));
    while (!(TIMER->TIMER_CTRL_bf.TMR_DONE));
}

void setDelayMicro(uint32_t delay_us) {
    uint32_t cycles = US_TO_CYCLES(delay_us);
    TIMER->TIMER0 = cycles;
    TIMER->TIMER_CTRL_bf.TMR_EN = 1;
    while ((TIMER->TIMER_CTRL_bf.TMR_DONE));
    while (!(TIMER->TIMER_CTRL_bf.TMR_DONE));
}

void setPWM(uint16_t period_us, uint16_t duty_cycle) {

    uint16_t period_counter = US_TO_CYCLES(period_us);
    uint16_t duty_counter   = US_TO_CYCLES(duty_cycle);

        TIMER->PWM0 = ((uint32_t)duty_counter << 16) | period_counter;
        TIMER->TIMER_CTRL_bf.PWM_EN = 1;
}

void stopPWM() {
        TIMER->PWM0 = 0;
        TIMER->TIMER_CTRL_bf.PWM_EN = 0;
}