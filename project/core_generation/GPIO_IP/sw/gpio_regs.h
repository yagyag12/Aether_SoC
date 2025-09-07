// Created with Corsair v1.0.4
#ifndef __GPIO_REGS_H
#define __GPIO_REGS_H

#define __I  volatile const // 'read only' permissions
#define __O  volatile       // 'write only' permissions
#define __IO volatile       // 'read / write' permissions


#ifdef __cplusplus
#include <cstdint>
extern "C" {
#else
#include <stdint.h>
#endif

#define GPIO_BASE_ADDR 0x40000000

// GPIO_DATA - General Purpose Input Output Data Register
#define GPIO_GPIO_DATA_ADDR 0x0
#define GPIO_GPIO_DATA_RESET 0x0
typedef struct {
    uint32_t LED : 4; // Built-in Output LEDs
    uint32_t SW : 4; // Built-in Input Switches
    uint32_t GPIO_OUT : 12; // GPIO Pin Value if selected as OUTPUT
    uint32_t GPIO_IN : 12; // GPIO Pin Value if selected as INPUT
} gpio_gpio_data_t;

// GPIO_DATA.LED - Built-in Output LEDs
#define GPIO_GPIO_DATA_LED_WIDTH 4
#define GPIO_GPIO_DATA_LED_LSB 0
#define GPIO_GPIO_DATA_LED_MASK 0xf
#define GPIO_GPIO_DATA_LED_RESET 0x0

// GPIO_DATA.SW - Built-in Input Switches
#define GPIO_GPIO_DATA_SW_WIDTH 4
#define GPIO_GPIO_DATA_SW_LSB 4
#define GPIO_GPIO_DATA_SW_MASK 0xf0
#define GPIO_GPIO_DATA_SW_RESET 0x0

// GPIO_DATA.GPIO_OUT - GPIO Pin Value if selected as OUTPUT
#define GPIO_GPIO_DATA_GPIO_OUT_WIDTH 12
#define GPIO_GPIO_DATA_GPIO_OUT_LSB 8
#define GPIO_GPIO_DATA_GPIO_OUT_MASK 0xfff00
#define GPIO_GPIO_DATA_GPIO_OUT_RESET 0x0

// GPIO_DATA.GPIO_IN - GPIO Pin Value if selected as INPUT
#define GPIO_GPIO_DATA_GPIO_IN_WIDTH 12
#define GPIO_GPIO_DATA_GPIO_IN_LSB 20
#define GPIO_GPIO_DATA_GPIO_IN_MASK 0xfff00000
#define GPIO_GPIO_DATA_GPIO_IN_RESET 0x0

// GPIO_CTRL - General Purpose Input Output Control Register
#define GPIO_GPIO_CTRL_ADDR 0x4
#define GPIO_GPIO_CTRL_RESET 0x0
typedef struct {
    uint32_t GPIO_DIR : 12; // GPIO Pin Direction
    uint32_t : 20; // reserved
} gpio_gpio_ctrl_t;

// GPIO_CTRL.GPIO_DIR - GPIO Pin Direction
#define GPIO_GPIO_CTRL_GPIO_DIR_WIDTH 12
#define GPIO_GPIO_CTRL_GPIO_DIR_LSB 0
#define GPIO_GPIO_CTRL_GPIO_DIR_MASK 0xfff
#define GPIO_GPIO_CTRL_GPIO_DIR_RESET 0x0


// Register map structure
typedef struct {
    union {
        __IO uint32_t GPIO_DATA; // General Purpose Input Output Data Register
        __IO gpio_gpio_data_t GPIO_DATA_bf; // Bit access for GPIO_DATA register
    };
    union {
        __IO uint32_t GPIO_CTRL; // General Purpose Input Output Control Register
        __IO gpio_gpio_ctrl_t GPIO_CTRL_bf; // Bit access for GPIO_CTRL register
    };
} gpio_t;

#define GPIO ((gpio_t*)(GPIO_BASE_ADDR))

#ifdef __cplusplus
}
#endif

#endif /* __GPIO_REGS_H */