#ifndef GPIO_H
#define GPIO_H

#include <stdint.h>
#include "gpio_regs.h"

// Turn on the LED
void setLED(uint8_t led_num);

// Turn off the LED
void clearLED(uint8_t led_num);

// Toggle the LED
void toggleLED(uint8_t led_num);

// Read the Switch
uint8_t readSwitch(uint8_t switch_num);

// Set GPIO as Input or Output (1 = output / 0 = input)
void setIO (uint8_t pin, uint8_t dir);

// Set Output port to 1
void setOut (uint8_t pin);

// Reset Output port to 0
void clearOut (uint8_t pin);

// Read Input port
uint8_t readInput (uint8_t pin);

#endif /* GPIO_H */