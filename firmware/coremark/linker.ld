/* Target */
OUTPUT_ARCH(riscv)
OUTPUT_FORMAT(elf32-littleriscv)

/* Entry point label (only for ELF simulation) */
ENTRY(_start)

/* Memory Layout */
MEMORY
{
    RAM (rWx)  : ORIGIN = 0x00000000, LENGTH = 32K 
}

SECTIONS
{
    . = ORIGIN(RAM);
    
    .text : {
        *startup.o(.text)
        *(.text)
        *(.text.*)
    } > RAM
    

    .rodata : {
        *(.rodata)
        *(.rodata.*)
        *(.srodata)
        *(.srodata.*)
    } > RAM

    
    .data ALIGN(4): {
        *(.data)
        *(.data.*)
        *(.sdata)
        *(.sdata.*)
    } > RAM


    .bss ALIGN(4): {
        _sbss = .;
        *(.bss)
        *(.bss.*)
        *(.sbss)
        *(.sbss.*)
        *(COMMON)
        _ebss = .; /* Assumes next section will be ALIGN(4)... */
    } > RAM

    /* .comment is avoided intentionally... */

    /* Stack located at the top of DRAM
       Stack decrements first and store, growing downwards
       Aligning SP initial value to 16-byte boundary as suggested by RISC-V ABI */
    _stack_top = (ORIGIN(RAM) + LENGTH(RAM)) & ~0xF;  
}
