#include <stdint.h>
#include <stdlib.h>
#include "uart.h"
#include "gpio.h"
#include "timer.h"
#include "spi.h"

// **** DEFINE PORTS HERE **** //
#define SPI_MODE    0

// *************************** //

//  FUNCTION DECLARATIONS HERE //
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    initSPI(SPI_MODE);

    // LOOP
    while (1) {
        spiTransfer('A');
        setDelayMicro(500);
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //

// *************************** //
