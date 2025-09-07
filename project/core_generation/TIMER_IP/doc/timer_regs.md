# Timer Registers

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
| [TIMER_CTRL](#timer_ctrl) | 0x00000000 | TIMER CONTROL REGISTER |
| [TIMER0](#timer0)        | 0x00000004 | Timer0 Delay Register |
| [PWM0](#pwm0)            | 0x00000008 | PWM0 Delay Register |

## TIMER_CTRL

TIMER CONTROL REGISTER

Address offset: 0x00000000

Reset value: 0x00000000

![timer_ctrl](md_img/timer_ctrl.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| -                | 31:3   | -               | 0x0000000  | Reserved |
| TMR_DONE         | 2      | ro              | 0x0        | Timer Done Flags |
| PWM_EN           | 1      | rw              | 0x0        | PWM Timer Enable |
| TMR_EN           | 0      | wosc            | 0x0        | Enable Timer |

Back to [Register map](#register-map-summary).

## TIMER0

Timer0 Delay Register

Address offset: 0x00000004

Reset value: 0x00000000

![timer0](md_img/timer0.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| DELAY            | 31:0   | wo              | 0x00000000 | Timer Delay |

Back to [Register map](#register-map-summary).

## PWM0

PWM0 Delay Register

Address offset: 0x00000008

Reset value: 0x00000000

![pwm0](md_img/pwm0.svg)

| Name             | Bits   | Mode            | Reset      | Description |
| :---             | :---   | :---            | :---       | :---        |
| DUTY_CYCLE       | 31:16  | wo              | 0x0000     | PWM0 Duty Cycle |
| PERIOD           | 15:0   | wo              | 0x0000     | PWM0 Period |

Back to [Register map](#register-map-summary).
