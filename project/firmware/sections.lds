ENTRY(_start)

MEMORY {
    mem (rwx) : ORIGIN = 0x00000000, LENGTH = 4K
}

SECTIONS {
    .text : {
        . = 0x00000000;       /* Force _start to be placed at 0x00000000 */
        KEEP(*(.text.start)); /* Ensure _start is the first thing in memory */
        *(.text*);
        . = ALIGN(4);
    } > mem

    .rodata : {
        . = ALIGN(4);
        *(.rodata*);
        . = ALIGN(4);
    } > mem

    .data : {
        . = ALIGN(4);
        *(.data*);
        . = ALIGN(4);
    } > mem

    .bss : {
        . = ALIGN(4);
        *(.bss*);
        . = ALIGN(4);
    } > mem
}
