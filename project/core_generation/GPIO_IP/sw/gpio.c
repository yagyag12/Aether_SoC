#include "gpio.h"

void setLED(uint8_t led_num) {
    if (led_num < 4) {
        GPIO->GPIO_DATA_bf.LED |= (1 << led_num);
    }
}

void clearLED(uint8_t led_num) {
    if (led_num < 4) {
        GPIO->GPIO_DATA_bf.LED &= ~(1 << led_num);
    }
}

void toggleLED(uint8_t led_num) {
    if (led_num < 4) {
        GPIO->GPIO_DATA_bf.LED ^= (1 << led_num);
    }
}

uint8_t readSwitch(uint8_t switch_num) {
    if (switch_num < 4) {
        return (GPIO->GPIO_DATA_bf.SW >> switch_num) & 1;
    }
    return 0;
}

void setIO (uint8_t pin, uint8_t dir) {
    if (pin < 12) {
        if (dir) {
            GPIO->GPIO_CTRL_bf.GPIO_DIR |= (1 << pin); // 1 = output
        } else {
            GPIO->GPIO_CTRL_bf.GPIO_DIR &= ~(1 << pin); // 0 = input
        }
    }
}

void setOut (uint8_t pin) {
    if ((pin < 12) && (GPIO->GPIO_CTRL_bf.GPIO_DIR & (1 << pin))) {
        GPIO->GPIO_DATA_bf.GPIO_OUT |= (1 << pin);
    } 
}

void clearOut (uint8_t pin) {
    if ((pin < 12) && (GPIO->GPIO_CTRL_bf.GPIO_DIR & (1 << pin))) {
        GPIO->GPIO_DATA_bf.GPIO_OUT &= ~(1 << pin);
    } 
}

uint8_t readInput (uint8_t pin) {
    if (pin < 12 && !(GPIO->GPIO_CTRL_bf.GPIO_DIR & (1 << pin))) {
        return (GPIO->GPIO_DATA_bf.GPIO_IN >> pin) & 1;
    }
    return 0;
}

