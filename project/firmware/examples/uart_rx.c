#include <stdint.h>
#include <stdlib.h>
#include "uart.h"

// **** DEFINE PORTS HERE **** //

// *************************** //

//  FUNCTION DECLARATIONS HERE //
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    startSerial(9600);
    uint8_t received_char = readChar();
    stopSerial();
    
    // LOOP
    while (1) {
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //
// *************************** //