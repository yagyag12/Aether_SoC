#include <stdint.h>
#include <stdlib.h>
#include "gpio.h"
#include "timer.h"

// **** DEFINE PORTS HERE **** //
#define LED_PIN 0
// *************************** //

//  FUNCTION DECLARATIONS HERE //
void blinkLED_delay();
// *************************** //

// ****** MAIN FUNCTION ****** //
int main(void) {
    // SETUP
    
    // LOOP
    while (1) {
        blinkLED_delay();
    };

    return 0;
}
// ** END OF MAIN FUNCTION ** //


//  FUNCTION DEFINITIONS HERE //
void blinkLED_delay() {
    setLED(LED_PIN);
    setDelayMicro(100);
    clearLED(LED_PIN);
    setDelayMicro(100);
}
// *************************** //