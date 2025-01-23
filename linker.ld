ENTRY(_start)

MEMORY
{
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
    .text : {
        *(.text.init)
        *(.text)
    } > RAM

    .rodata : {
        . = ALIGN(8);
        *(.rodata .rodata.*)
        . = ALIGN(8);
    } > RAM

    .data : {
        . = ALIGN(8);
        *(.sdata .sdata.*)
        *(.data .data.*)
        . = ALIGN(8);
    } > RAM

    .bss : {
        . = ALIGN(8);
        *(.sbss .sbss.*)
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(16);
        . = . + 1024 * 4;
        _stack_top = .;
        . = ALIGN(8);
    } > RAM
}
