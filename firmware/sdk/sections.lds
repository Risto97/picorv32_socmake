/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/

MEMORY {
	/* the memory in the testbench is 128k in size;
	 * set LENGTH=96k and leave at least 32k for stack */
	mem : ORIGIN = 0x00000000, LENGTH = 0x00018000
}
PROVIDE(_smem = ORIGIN(mem));
PROVIDE(_estack = ORIGIN(mem) + LENGTH(mem));

SECTIONS {

	.memory : {
        *.crt0.S*(.text)
        *.crt0.s*(.text)
        *.S*(.text)
        *.s*(.text)
        *(.text)
        *(.text.*)
        _sdata = .; 
        *(.data*)
        _edata = .;
        *(.text*);
        ._sbss = .;
        *(.bss*);
        ._ebss = .;
		*(*);
		end = .;
		. = ALIGN(4);
	} > mem 

}

