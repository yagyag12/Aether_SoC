// Created with Corsair v1.0.4
#ifndef __UART_REGS_H
#define __UART_REGS_H

#define __I  volatile const // 'read only' permissions
#define __O  volatile       // 'write only' permissions
#define __IO volatile       // 'read / write' permissions


#ifdef __cplusplus
#include <cstdint>
extern "C" {
#else
#include <stdint.h>
#endif

#define UART_BASE_ADDR 0x50000000

// UART_CTRL - UART CONTROL REGISTER
#define UART_UART_CTRL_ADDR 0x0
#define UART_UART_CTRL_RESET 0x0
typedef struct {
    uint32_t UART_EN : 1; // Enable Uart
    uint32_t TX_EN : 1; // Enable Transmitter
    uint32_t RX_EN : 1; // Enable Receiver
    uint32_t TX_IRQ_EN : 1; // Enable TX Interrupt
    uint32_t RX_IRQ_EN : 1; // Enable RX Interrupt
    uint32_t BAUD_SEL : 2; // Baud Rate Selection (00->4800 / 01->9600 / 10->57600 / 11->115200)
    uint32_t : 25; // reserved
} uart_uart_ctrl_t;

// UART_CTRL.UART_EN - Enable Uart
#define UART_UART_CTRL_UART_EN_WIDTH 1
#define UART_UART_CTRL_UART_EN_LSB 0
#define UART_UART_CTRL_UART_EN_MASK 0x1
#define UART_UART_CTRL_UART_EN_RESET 0x0

// UART_CTRL.TX_EN - Enable Transmitter
#define UART_UART_CTRL_TX_EN_WIDTH 1
#define UART_UART_CTRL_TX_EN_LSB 1
#define UART_UART_CTRL_TX_EN_MASK 0x2
#define UART_UART_CTRL_TX_EN_RESET 0x0

// UART_CTRL.RX_EN - Enable Receiver
#define UART_UART_CTRL_RX_EN_WIDTH 1
#define UART_UART_CTRL_RX_EN_LSB 2
#define UART_UART_CTRL_RX_EN_MASK 0x4
#define UART_UART_CTRL_RX_EN_RESET 0x0

// UART_CTRL.TX_IRQ_EN - Enable TX Interrupt
#define UART_UART_CTRL_TX_IRQ_EN_WIDTH 1
#define UART_UART_CTRL_TX_IRQ_EN_LSB 3
#define UART_UART_CTRL_TX_IRQ_EN_MASK 0x8
#define UART_UART_CTRL_TX_IRQ_EN_RESET 0x0

// UART_CTRL.RX_IRQ_EN - Enable RX Interrupt
#define UART_UART_CTRL_RX_IRQ_EN_WIDTH 1
#define UART_UART_CTRL_RX_IRQ_EN_LSB 4
#define UART_UART_CTRL_RX_IRQ_EN_MASK 0x10
#define UART_UART_CTRL_RX_IRQ_EN_RESET 0x0

// UART_CTRL.BAUD_SEL - Baud Rate Selection (00->4800 / 01->9600 / 10->57600 / 11->115200)
#define UART_UART_CTRL_BAUD_SEL_WIDTH 2
#define UART_UART_CTRL_BAUD_SEL_LSB 5
#define UART_UART_CTRL_BAUD_SEL_MASK 0x60
#define UART_UART_CTRL_BAUD_SEL_RESET 0x0

// UART_STAT - UART STATUS REGISTER
#define UART_UART_STAT_ADDR 0x4
#define UART_UART_STAT_RESET 0x12
typedef struct {
    uint32_t : 1; // reserved
    uint32_t TX_RDY : 1; // Transmitter Ready
    uint32_t TX_DONE : 1; // Transmitter Done
    uint32_t : 1; // reserved
    uint32_t RX_RDY : 1; // Receiver Ready
    uint32_t RX_DONE : 1; // Receiver Done
    uint32_t RX_FULL : 1; // RX Buffer Full
    uint32_t : 25; // reserved
} uart_uart_stat_t;

// UART_STAT.TX_RDY - Transmitter Ready
#define UART_UART_STAT_TX_RDY_WIDTH 1
#define UART_UART_STAT_TX_RDY_LSB 1
#define UART_UART_STAT_TX_RDY_MASK 0x2
#define UART_UART_STAT_TX_RDY_RESET 0x1

// UART_STAT.TX_DONE - Transmitter Done
#define UART_UART_STAT_TX_DONE_WIDTH 1
#define UART_UART_STAT_TX_DONE_LSB 2
#define UART_UART_STAT_TX_DONE_MASK 0x4
#define UART_UART_STAT_TX_DONE_RESET 0x0

// UART_STAT.RX_RDY - Receiver Ready
#define UART_UART_STAT_RX_RDY_WIDTH 1
#define UART_UART_STAT_RX_RDY_LSB 4
#define UART_UART_STAT_RX_RDY_MASK 0x10
#define UART_UART_STAT_RX_RDY_RESET 0x1

// UART_STAT.RX_DONE - Receiver Done
#define UART_UART_STAT_RX_DONE_WIDTH 1
#define UART_UART_STAT_RX_DONE_LSB 5
#define UART_UART_STAT_RX_DONE_MASK 0x20
#define UART_UART_STAT_RX_DONE_RESET 0x0

// UART_STAT.RX_FULL - RX Buffer Full
#define UART_UART_STAT_RX_FULL_WIDTH 1
#define UART_UART_STAT_RX_FULL_LSB 6
#define UART_UART_STAT_RX_FULL_MASK 0x40
#define UART_UART_STAT_RX_FULL_RESET 0x0

// UART_DATA - UART DATA REGISTER
#define UART_UART_DATA_ADDR 0x8
#define UART_UART_DATA_RESET 0x0
typedef struct {
    uint32_t TX_DATA : 8; // UART TX Data
    uint32_t RX_DATA : 8; // UART RX Data
    uint32_t : 16; // reserved
} uart_uart_data_t;

// UART_DATA.TX_DATA - UART TX Data
#define UART_UART_DATA_TX_DATA_WIDTH 8
#define UART_UART_DATA_TX_DATA_LSB 0
#define UART_UART_DATA_TX_DATA_MASK 0xff
#define UART_UART_DATA_TX_DATA_RESET 0x0

// UART_DATA.RX_DATA - UART RX Data
#define UART_UART_DATA_RX_DATA_WIDTH 8
#define UART_UART_DATA_RX_DATA_LSB 8
#define UART_UART_DATA_RX_DATA_MASK 0xff00
#define UART_UART_DATA_RX_DATA_RESET 0x0


// Register map structure
typedef struct {
    union {
        __IO uint32_t UART_CTRL; // UART CONTROL REGISTER
        __IO uart_uart_ctrl_t UART_CTRL_bf; // Bit access for UART_CTRL register
    };
    union {
        __IO uint32_t UART_STAT; // UART STATUS REGISTER
        __IO uart_uart_stat_t UART_STAT_bf; // Bit access for UART_STAT register
    };
    union {
        __IO uint32_t UART_DATA; // UART DATA REGISTER
        __IO uart_uart_data_t UART_DATA_bf; // Bit access for UART_DATA register
    };
} uart_t;

#define UART ((uart_t*)(UART_BASE_ADDR))

#ifdef __cplusplus
}
#endif

#endif /* __UART_REGS_H */