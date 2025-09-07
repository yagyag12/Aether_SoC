#include <stdint.h>
#include <stdlib.h>
#include "gpio.h"
#include "timer.h"

// **** DEFINE PORTS HERE **** //
// *************************** //

//  FUNCTION DECLARATIONS HERE //
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    setPWM(100,25);
    setDelayMili(8);
    stopPWM();
    
    // LOOP
    while (1) {
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //

// *************************** //