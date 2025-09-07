# GPIO Registers

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
| [GPIO_DATA](#gpio_data)  | 0x00000000 | General Purpose Input Output Data Register |
| [GPIO_CTRL](#gpio_ctrl)  | 0x00000004 | General Purpose Input Output Control Register |

## GPIO_DATA

General Purpose Input Output Data Register

Address offset: 0x00000000

Reset value: 0x00000000

![gpio_data](md_img/gpio_data.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| GPIO_IN          | 31:20  | ro              | 0x000      | GPIO Pin Value if selected as INPUT |
| GPIO_OUT         | 19:8   | wo              | 0x000      | GPIO Pin Value if selected as OUTPUT |
| SW               | 7:4    | ro              | 0x0        | Built-in Input Switches |
| LED              | 3:0    | wo              | 0x0        | Built-in Output LEDs |

Back to [Register map](#register-map-summary).

## GPIO_CTRL

General Purpose Input Output Control Register

Address offset: 0x00000004

Reset value: 0x00000000

![gpio_ctrl](md_img/gpio_ctrl.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:12  | -               | 0x00000    | Reserved |
| GPIO_DIR         | 11:0   | rw              | 0x000      | GPIO Pin Direction |

Back to [Register map](#register-map-summary).
