# Aether SoC

Aether SoC is an open-source RISC-V microcontroller. The design aims to provide a lightweight and easily extensible platform for embedded system development and applications.
The system is built around a mutli-cycle RV32I processor, implementing the base RISC-V integer instruction set. It follows a Harvard memory architecture, meaning instruction and data memory are separated. The peripheral bus is a custom memory-mapped I/O (MMIO) Bus where all the peripheral connections along with the data memory (RAM) are integrated on the same bus, separated by address regions.

## Features

To support interaction with the external world, Aether SoC includes several configurable peripheral modules, including:
•	8 kB of RAM
•	A UART module with 4 selectable baud rates
•	An SPI module, configurable as either master or slave, master mode supporting up to 4 slaves
•	12 General-Purpose I/O (GPIO) pins, all individually configurable as input or output.
•	4 built-in LEDs and switches.
•	A PWM-controlled output channels.
•	An independent timer, designed primarily for delay generation and basic timing tasks.

## Design Philosophy

The system operates at 50 MHz and has been fully implemented and tested on Digilent Zybo Z7 development board (Xilinx Zynq-7020 SoC). In addition, the design was successfully fabricated using the SkyWater 130 nm (Sky130 PDK) process within the OpenLane physical design flow.
Aether SoC has been developed in a vision with minimalist, modular and configurable design, specifically targeting students and beginners.
Please note that this project is not intended for industrial or safety-critical use. Rather, it serves as a beginner level engineering project, which will continue to evolve and improve through iterative development.


