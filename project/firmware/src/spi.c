#include <stdint.h>

void initSPI(uint8_t is_master) {
    volatile uint32_t *spi_ctrl = (uint32_t *)0x80000000;
    uint32_t reg = *spi_ctrl;

    if (is_master)
        reg |= (1 << 0);
    else
        reg &= ~(1 << 0);
    reg |= (1 << 1);
    *spi_ctrl = reg;
}

void confSPI(uint8_t cpol, uint8_t cpha, uint8_t clk_div) {
    volatile uint32_t *spi_ctrl = (uint32_t *)0x80000000;
    uint32_t reg = *spi_ctrl;

    if (cpol)
        reg |= (1 << 2);
    else
        reg &= ~(1 << 2);

    if (cpha)
        reg |= (1 << 3);
    else
        reg &= ~(1 << 3);

    reg &= ~(0xF << 4);
    reg |= ((clk_div & 0xF) << 4);
    *spi_ctrl = reg;
}

void slaveSelect(uint8_t cs) {
    volatile uint32_t *spi_ctrl = (uint32_t *)0x80000000;
    uint32_t reg = *spi_ctrl;

    reg &= ~(0xF << 12);
    reg |= ((cs & 0xF) << 12);
    *spi_ctrl = reg;
}

uint32_t checkSPIStatus(void) {
    volatile uint32_t *spi_stat = (uint32_t *)0x80000004;
    return *spi_stat;
}

void sendSPIData(uint8_t data) {
    volatile uint32_t *spi_stat = (uint32_t *)0x80000004;
    volatile uint32_t *spi_data = (uint32_t *)0x80000008;

    while (((*spi_stat) & 0x1) == 0);    
    *spi_data = (*spi_data & 0xFFFFFF00) | data;
}

uint8_t readSPIData(void) {
    volatile uint32_t *spi_stat = (uint32_t *)0x80000004;
    volatile uint32_t *spi_data = (uint32_t *)0x80000008;

    while (((*spi_stat >> 3) & 0x1) == 0);
    return (uint8_t)((*spi_data >> 8) & 0xFF);
}

uint8_t spiTransfer(uint8_t data) {
    sendSPIData(data);
    return readSPIData();
}
