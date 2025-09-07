#include <stdint.h>
#include <stdlib.h>
#include "gpio.h"

// **** DEFINE PORTS HERE **** //
#define LED_PIN 0
#define SW_PIN  2
// *************************** //

//  FUNCTION DECLARATIONS HERE //
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    
    // SETUP
    uint8_t sw_val = 0;

    // LOOP
    while (1) {
    sw_val = readSwitch(SW_PIN);
    if (sw_val) {
        setLED(LED_PIN);
    } else {
        clearLED(LED_PIN);
    }
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //

// *************************** //
