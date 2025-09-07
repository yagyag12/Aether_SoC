#ifndef SPI_H
#define SPI_H

#include <stdint.h>
#include "spi_regs.h"

// Initialize SPI
void initSPI(uint8_t is_master);

// Configure SPI
void confSPI(uint8_t cpol, uint8_t cpha, uint8_t clk_div);

// Chip Select
void slaveSelect(uint8_t cs);

// Check the Status Register
uint32_t checkSPIStatus(void);

// Send Data
void sendSPIData(uint8_t data);

// Read Data
uint8_t readSPIData(void);

// Send and Read Data
uint8_t spiTransfer(uint8_t data);

#endif /* SPI_H */