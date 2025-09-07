# UART Registers

Created with [Corsair](https://github.com/esynr3z/corsair) v1.0.4.

## Conventions

| Access mode | Description               |
| :---------- | :------------------------ |
| rw          | Read and Write            |
| rw1c        | Read and Write 1 to Clear |
| rw1s        | Read and Write 1 to Set   |
| ro          | Read Only                 |
| roc         | Read Only to Clear        |
| roll        | Read Only / Latch Low     |
| rolh        | Read Only / Latch High    |
| wo          | Write only                |
| wosc        | Write Only / Self Clear   |

## Register map summary

Base address: 0x00000000

| Name                     | Address    | Description |
| :---                     | :---       | :---        |
| [UART_CTRL](#uart_ctrl)  | 0x00000000 | UART CONTROL REGISTER |
| [UART_STAT](#uart_stat)  | 0x00000004 | UART STATUS REGISTER |
| [UART_DATA](#uart_data)  | 0x00000008 | UART DATA REGISTER |

## UART_CTRL

UART CONTROL REGISTER

Address offset: 0x00000000

Reset value: 0x00000000

![uart_ctrl](md_img/uart_ctrl.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:7   | -               | 0x000000   | Reserved |
| BAUD_SEL         | 6:5    | rw              | 0x0        | Baud Rate Selection (00->4800 / 01->9600 / 10->57600 / 11->115200) |
| RX_IRQ_EN        | 4      | rw              | 0x0        | Enable RX Interrupt |
| TX_IRQ_EN        | 3      | rw              | 0x0        | Enable TX Interrupt |
| RX_EN            | 2      | rw              | 0x0        | Enable Receiver |
| TX_EN            | 1      | rw              | 0x0        | Enable Transmitter |
| UART_EN          | 0      | rw              | 0x0        | Enable Uart |

Back to [Register map](#register-map-summary).

## UART_STAT

UART STATUS REGISTER

Address offset: 0x00000004

Reset value: 0x00000012

![uart_stat](md_img/uart_stat.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:7   | -               | 0x000000   | Reserved |
| RX_FULL          | 6      | ro              | 0x0        | RX Buffer Full |
| RX_DONE          | 5      | roc             | 0x0        | Receiver Done |
| RX_RDY           | 4      | ro              | 0x1        | Receiver Ready |
| -                | 3      | -               | 0x0        | Reserved |
| TX_DONE          | 2      | roc             | 0x0        | Transmitter Done |
| TX_RDY           | 1      | ro              | 0x1        | Transmitter Ready |

Back to [Register map](#register-map-summary).

## UART_DATA

UART DATA REGISTER

Address offset: 0x00000008

Reset value: 0x00000000

![uart_data](md_img/uart_data.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:16  | -               | 0x0000     | Reserved |
| RX_DATA          | 15:8   | ro              | 0x00       | UART RX Data |
| TX_DATA          | 7:0    | wo              | 0x00       | UART TX Data |

Back to [Register map](#register-map-summary).
