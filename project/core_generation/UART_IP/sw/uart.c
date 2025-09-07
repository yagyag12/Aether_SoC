#include "uart.h"

void startSerial(uint32_t baud) {
    switch (baud) {
        case 4800:      UART->UART_CTRL = 0x00000007; break;
        case 9600:      UART->UART_CTRL = 0x00000027; break;
        case 57600:     UART->UART_CTRL = 0x00000047; break;
        case 115200:    UART->UART_CTRL = 0x00000067; break;
        default:        UART->UART_CTRL = 0x00000027; break; 
    }
}

void stopSerial(void) {
    UART->UART_CTRL = 0x00000000;
}

void sendChar(uint8_t data) {
    while (UART->UART_STAT_bf.TX_RDY == 0); 
    UART->UART_DATA_bf.TX_DATA = data;
    while (UART->UART_STAT_bf.TX_DONE == 0); 
}

void sendString(const char *str) {
    while (*str) {
        sendChar(*str++);
    }
};

uint8_t readChar(void) {
    uint32_t timeout = 50000;
    while ((UART->UART_STAT_bf.RX_DONE == 0) && (--timeout));
    if (timeout == 0) {
        return -1;
    }
    return (uint8_t) UART->UART_DATA_bf.RX_DATA;
}

void readString(char *buffer, uint8_t max_length) {
    uint8_t index = 0;
    uint32_t timeout;

    while (index < max_length - 1) { 
        timeout = 100;

        while (UART->UART_STAT_bf.RX_DONE == 0 && timeout--);

        if (timeout == 0) {
            break;
        }

        char received = UART->UART_DATA_bf.RX_DATA;
        buffer[index++] = received;

        if (received == '\n') {
            break;
        }
    }

    buffer[index] = '\0';
}


uint8_t checkTX(void) {
    return UART->UART_STAT_bf.TX_RDY;
}

uint8_t checkRX(void) {
    return UART->UART_STAT_bf.RX_RDY;
}

