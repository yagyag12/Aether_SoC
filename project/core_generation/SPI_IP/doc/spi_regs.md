# SPI Registers

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
| [SPI_CTRL](#spi_ctrl)    | 0x00000000 | SPI CONTROL REGISTER |
| [SPI_STAT](#spi_stat)    | 0x00000004 | SPI STATUS REGISTER |
| [SPI_DATA](#spi_data)    | 0x00000008 | SPI DATA REGISTER |

## SPI_CTRL

SPI CONTROL REGISTER

Address offset: 0x00000000

Reset value: 0x00000000

![spi_ctrl](md_img/spi_ctrl.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:14  | -               | 0x0000     | Reserved |
| CS               | 13:12  | rw              | 0x0        | Chip Select |
| CLK_DIV          | 11:4   | rw              | 0x00       | Clock Divider for SPI Clock Generation |
| CPHA             | 3      | rw              | 0x0        | Clock Phase |
| CPOL             | 2      | rw              | 0x0        | Clock Polarity |
| MASTER_EN        | 1      | rw              | 0x0        | Enable SPI as Master (0 -> Slave / 1 -> Master) |
| SPI_EN           | 0      | rw              | 0x0        | Enable SPI |

Back to [Register map](#register-map-summary).

## SPI_STAT

SPI STATUS REGISTER

Address offset: 0x00000004

Reset value: 0x00000005

![spi_stat](md_img/spi_stat.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:5   | -               | 0x000000   | Reserved |
| BUSY             | 4      | ro              | 0x0        | SPI is busy |
| RX_DONE          | 3      | roc             | 0x0        | Receiver Done |
| RX_RDY           | 2      | ro              | 0x1        | Receiver Ready |
| TX_DONE          | 1      | roc             | 0x0        | Transmitter Done |
| TX_RDY           | 0      | ro              | 0x1        | Transmitter Ready |

Back to [Register map](#register-map-summary).

## SPI_DATA

SPI DATA REGISTER

Address offset: 0x00000008

Reset value: 0x00000000

![spi_data](md_img/spi_data.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:16  | -               | 0x0000     | Reserved |
| RX_DATA          | 15:8   | ro              | 0x00       | SPI RX Data |
| TX_DATA          | 7:0    | wo              | 0x00       | SPI TX Data |

Back to [Register map](#register-map-summary).
