#include <stdint.h>
#include <stdlib.h>
#include "timer.h"
#include "spi.h"

// **** DEFINE PORTS HERE **** //
#define SPI_MODE    1
#define CPOL        0
#define CPHA        0
#define CLK_DIV     4
#define SLAVE       0

// *************************** //

//  FUNCTION DECLARATIONS HERE //
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    initSPI(SPI_MODE);
    confSPI(CPOL,CPHA,CLK_DIV);
    slaveSelect(SLAVE);

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
