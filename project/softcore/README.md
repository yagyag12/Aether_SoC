The design is synthesized and implemented in Xilinx Vivado and tested on the Zybo Z7 FPGA Development board.

| Name            | Slice LUTs (53200) | Slice Registers (106400) | F7 Muxes (26600) | F8 Muxes (13300) | Slice (13300) | LUT as Logic (53200) | LUT as Memory (17400) |

|-----------------|--------------------|--------------------------|------------------|------------------|----------------|-----------------------|-----------------------|

| \*\*aether\_soc\*\*  | 4707               | 1648                     | 870              | 325              | 1382           | 3683                  | 1024                  |

| ├─ data\_mem     | 1092               | 0                        | 530              | 256              | 302            | 68                    | 1024                  |

| ├─ gpio0        | 4                  | 44                       | 0                | 0                | 26             | 4                     | 0                     |

| ├─ rv32\_core    | 3409               | 1257                     | 339              | 69               | 1035           | 3409                  | 0                     |

| │  ├─ alu       | 21                 | 0                        | 0                | 0                | 32             | 21                    | 0                     |

| │  ├─ branch\_unit | 0                | 0                        | 0                | 0                | 12             | 0                     | 0                     |

| │  ├─ instr\_mem | 544                | 0                        | 63               | 1                | 170            | 544                   | 0                     |

| │  └─ regfile   | 2634               | 992                      | 276              | 68               | 804            | 2634                  | 0                     |

| ├─ spi0         | 54                 | 93                       | 1                | 0                | 28             | 54                    | 0                     |

| │  ├─ spi\_master\_i | 40              | 43                       | 1                | 0                | 18             | 40                    | 0                     |

| │  ├─ spi\_regs\_i   | 9               | 22                       | 0                | 0                | 15             | 9                     | 0                     |

| │  └─ spi\_slave\_i  | 5               | 28                       | 0                | 0                | 8              | 5                     | 0                     |

| ├─ timer0       | 100                | 118                      | 0                | 0                | 50             | 100                   | 0                     |

| │  ├─ timer\_regs  | 64               | 67                       | 0                | 0                | 33             | 64                    | 0                     |

| │  └─ timers0     | 37               | 51                       | 0                | 0                | 43             | 37                    | 0                     |

| └─ uart\_ip      | 51                 | 96                       | 0                | 0                | 29             | 51                    | 0                     |

|    ├─ baud\_rate\_generator0 | 17      | 23                       | 0                | 0                | 8              | 17                    | 0                     |

|    ├─ uart\_regs          | 8         | 29                       | 0                | 0                | 18             | 8                     | 0                     |

|    ├─ uart\_rx0           | 10        | 27                       | 0                | 0                | 8              | 10                    | 0                     |

|    └─ uart\_tx0           | 16        | 17                       | 0                | 0                | 7              | 16                    | 0                     |



\# Design Timing Summary



| Category     | Metric                             | Value     |

|--------------|------------------------------------|-----------|

| \*\*Setup\*\*    | Worst Negative Slack (WNS)         | 5.793 ns  |

|              | Total Negative Slack (TNS)         | 0.000 ns  |

|              | Number of Failing Endpoints        | 0         |

|              | Total Number of Endpoints          | 14107     |

| \*\*Hold\*\*     | Worst Hold Slack (WHS)             | 0.052 ns  |

|              | Total Hold Slack (THS)             | 0.000 ns  |

|              | Number of Failing Endpoints        | 0         |

|              | Total Number of Endpoints          | 14107     |

| \*\*Pulse Width\*\* | Worst Pulse Width Slack (WPWS)  | 8.750 ns  |

|              | Total Pulse Width Negative Slack (TPWS) | 0.000 ns |

|              | Number of Failing Endpoints        | 0         |

|              | Total Number of Endpoints          | 2673      |





\# Power Summary



| Metric                | Value        |

|-----------------------|--------------|

| Total On-Chip Power   | \*\*0.125 W\*\*  |

| Design Power Budget   | Not Specified |

| Process               | typical      |

| Power Budget Margin   | N/A          |

| Junction Temperature  | 26.4 °C      |

| Thermal Margin        | 58.6 °C (4.9 W) |

| Ambient Temperature   | 25.0 °C      |

| Effective ΘJA         | 11.5 °C/W    |



---



\## On-Chip Power Breakdown



| Category  | Power   | Percentage |

|-----------|---------|------------|

| \*\*Dynamic\*\* | 0.019 W | 15% |

| ├─ Clocks   | 0.004 W | 23% |

| ├─ Signals  | 0.008 W | 45% |

| ├─ Logic    | 0.005 W | 28% |

| └─ I/O      | 0.001 W | 4%  |

| \*\*Device Static\*\* | 0.106 W | 85% |



