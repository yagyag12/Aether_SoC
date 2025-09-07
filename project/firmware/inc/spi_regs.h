// Created with Corsair v1.0.4
#ifndef __SPI_REGS_H
#define __SPI_REGS_H

#define __I  volatile const // 'read only' permissions
#define __O  volatile       // 'write only' permissions
#define __IO volatile       // 'read / write' permissions


#ifdef __cplusplus
#include <cstdint>
extern "C" {
#else
#include <stdint.h>
#endif

#define SPI_BASE_ADDR 0x80000000

// SPI_CTRL - SPI CONTROL REGISTER
#define SPI_SPI_CTRL_ADDR 0x0
#define SPI_SPI_CTRL_RESET 0x0
typedef struct {
    uint32_t SPI_EN : 1; // Enable SPI
    uint32_t MASTER_EN : 1; // Enable SPI as Master (0 -> Slave / 1 -> Master)
    uint32_t CPOL : 1; // Clock Polarity
    uint32_t CPHA : 1; // Clock Phase
    uint32_t CLK_DIV : 8; // Clock Divider for SPI Clock Generation
    uint32_t CS : 2; // Chip Select
    uint32_t : 18; // reserved
} spi_spi_ctrl_t;

// SPI_CTRL.SPI_EN - Enable SPI
#define SPI_SPI_CTRL_SPI_EN_WIDTH 1
#define SPI_SPI_CTRL_SPI_EN_LSB 0
#define SPI_SPI_CTRL_SPI_EN_MASK 0x1
#define SPI_SPI_CTRL_SPI_EN_RESET 0x0

// SPI_CTRL.MASTER_EN - Enable SPI as Master (0 -> Slave / 1 -> Master)
#define SPI_SPI_CTRL_MASTER_EN_WIDTH 1
#define SPI_SPI_CTRL_MASTER_EN_LSB 1
#define SPI_SPI_CTRL_MASTER_EN_MASK 0x2
#define SPI_SPI_CTRL_MASTER_EN_RESET 0x0

// SPI_CTRL.CPOL - Clock Polarity
#define SPI_SPI_CTRL_CPOL_WIDTH 1
#define SPI_SPI_CTRL_CPOL_LSB 2
#define SPI_SPI_CTRL_CPOL_MASK 0x4
#define SPI_SPI_CTRL_CPOL_RESET 0x0

// SPI_CTRL.CPHA - Clock Phase
#define SPI_SPI_CTRL_CPHA_WIDTH 1
#define SPI_SPI_CTRL_CPHA_LSB 3
#define SPI_SPI_CTRL_CPHA_MASK 0x8
#define SPI_SPI_CTRL_CPHA_RESET 0x0

// SPI_CTRL.CLK_DIV - Clock Divider for SPI Clock Generation
#define SPI_SPI_CTRL_CLK_DIV_WIDTH 8
#define SPI_SPI_CTRL_CLK_DIV_LSB 4
#define SPI_SPI_CTRL_CLK_DIV_MASK 0xff0
#define SPI_SPI_CTRL_CLK_DIV_RESET 0x0

// SPI_CTRL.CS - Chip Select
#define SPI_SPI_CTRL_CS_WIDTH 2
#define SPI_SPI_CTRL_CS_LSB 12
#define SPI_SPI_CTRL_CS_MASK 0x3000
#define SPI_SPI_CTRL_CS_RESET 0x0

// SPI_STAT - SPI STATUS REGISTER
#define SPI_SPI_STAT_ADDR 0x4
#define SPI_SPI_STAT_RESET 0x5
typedef struct {
    uint32_t TX_RDY : 1; // Transmitter Ready
    uint32_t TX_DONE : 1; // Transmitter Done
    uint32_t RX_RDY : 1; // Receiver Ready
    uint32_t RX_DONE : 1; // Receiver Done
    uint32_t BUSY : 1; // SPI is busy
    uint32_t : 27; // reserved
} spi_spi_stat_t;

// SPI_STAT.TX_RDY - Transmitter Ready
#define SPI_SPI_STAT_TX_RDY_WIDTH 1
#define SPI_SPI_STAT_TX_RDY_LSB 0
#define SPI_SPI_STAT_TX_RDY_MASK 0x1
#define SPI_SPI_STAT_TX_RDY_RESET 0x1

// SPI_STAT.TX_DONE - Transmitter Done
#define SPI_SPI_STAT_TX_DONE_WIDTH 1
#define SPI_SPI_STAT_TX_DONE_LSB 1
#define SPI_SPI_STAT_TX_DONE_MASK 0x2
#define SPI_SPI_STAT_TX_DONE_RESET 0x0

// SPI_STAT.RX_RDY - Receiver Ready
#define SPI_SPI_STAT_RX_RDY_WIDTH 1
#define SPI_SPI_STAT_RX_RDY_LSB 2
#define SPI_SPI_STAT_RX_RDY_MASK 0x4
#define SPI_SPI_STAT_RX_RDY_RESET 0x1

// SPI_STAT.RX_DONE - Receiver Done
#define SPI_SPI_STAT_RX_DONE_WIDTH 1
#define SPI_SPI_STAT_RX_DONE_LSB 3
#define SPI_SPI_STAT_RX_DONE_MASK 0x8
#define SPI_SPI_STAT_RX_DONE_RESET 0x0

// SPI_STAT.BUSY - SPI is busy
#define SPI_SPI_STAT_BUSY_WIDTH 1
#define SPI_SPI_STAT_BUSY_LSB 4
#define SPI_SPI_STAT_BUSY_MASK 0x10
#define SPI_SPI_STAT_BUSY_RESET 0x0

// SPI_DATA - SPI DATA REGISTER
#define SPI_SPI_DATA_ADDR 0x8
#define SPI_SPI_DATA_RESET 0x0
typedef struct {
    uint32_t TX_DATA : 8; // SPI TX Data
    uint32_t RX_DATA : 8; // SPI RX Data
    uint32_t : 16; // reserved
} spi_spi_data_t;

// SPI_DATA.TX_DATA - SPI TX Data
#define SPI_SPI_DATA_TX_DATA_WIDTH 8
#define SPI_SPI_DATA_TX_DATA_LSB 0
#define SPI_SPI_DATA_TX_DATA_MASK 0xff
#define SPI_SPI_DATA_TX_DATA_RESET 0x0

// SPI_DATA.RX_DATA - SPI RX Data
#define SPI_SPI_DATA_RX_DATA_WIDTH 8
#define SPI_SPI_DATA_RX_DATA_LSB 8
#define SPI_SPI_DATA_RX_DATA_MASK 0xff00
#define SPI_SPI_DATA_RX_DATA_RESET 0x0


// Register map structure
typedef struct {
    union {
        __IO uint32_t SPI_CTRL; // SPI CONTROL REGISTER
        __IO spi_spi_ctrl_t SPI_CTRL_bf; // Bit access for SPI_CTRL register
    };
    union {
        __IO uint32_t SPI_STAT; // SPI STATUS REGISTER
        __IO spi_spi_stat_t SPI_STAT_bf; // Bit access for SPI_STAT register
    };
    union {
        __IO uint32_t SPI_DATA; // SPI DATA REGISTER
        __IO spi_spi_data_t SPI_DATA_bf; // Bit access for SPI_DATA register
    };
} spi_t;

#define SPI ((spi_t*)(SPI_BASE_ADDR))

#ifdef __cplusplus
}
#endif

#endif /* __SPI_REGS_H */