#ifndef UART_H
#define UART_H

#include <stdint.h>
#include "uart_regs.h"

// Initialize the UART and Set the Baud Rate
void startSerial(uint32_t baud);    

// Disable the UART
void stopSerial(void);

// Send Data from UART TX
void sendChar(uint8_t data);   

// Send String from UART TX
void sendString(const char *str);

// Read the UART RX
uint8_t readChar(void);

// Read the UART RX and Save it into the "buffer" with the size "max_length"
void readString(char *buffer, uint8_t max_length);

// Check TX Ready
uint8_t checkTX(void);

// Check RX Ready
uint8_t checkRX(void);

#endif /* UART_H */