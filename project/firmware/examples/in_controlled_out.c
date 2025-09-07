#include <stdint.h>
#include <stdlib.h>
#include "gpio.h"

// **** DEFINE PORTS HERE **** //
#define IN_PIN   0
#define OUT_PIN  2
// *************************** //

//  FUNCTION DECLARATIONS HERE //
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    uint8_t in_val = 0;
    setIO(IN_PIN, 0);
    setIO(OUT_PIN, 1);

    // LOOP
    while (1) {
    in_val = readInput(IN_PIN);
    if (in_val) {
        setOut(OUT_PIN);
    } else {
        clearOut(OUT_PIN);
    }
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //

// *************************** //
