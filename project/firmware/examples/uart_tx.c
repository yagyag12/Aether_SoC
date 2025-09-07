#include <stdint.h>
#include <stdlib.h>
#include "uart.h"

// **** DEFINE PORTS HERE **** //

// *************************** //

//  FUNCTION DECLARATIONS HERE //
void helloWorld();
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    helloWorld();

    // LOOP
    while (1) {
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //
void helloWorld () {
    startSerial(9600);
    sendString("HELLO WORLD!\n");
    stopSerial();    
}
// *************************** //