/*------ C Linker ------*/
/*-- Only ram not rom --*/

OUTPUT_ARCH( "riscv" )

MEMORY{  ram ( wxa!ri ) : ORIGIN = 0x0, LENGTH = 0x2000	}

SECTIONS
{
  .memory : {
		. = 0x000004;
		*(.text);
		*(.rodata);
		*(.preinit_array);
		*(.init_array);
		*(.fini_array);
		*(.ctors);
		*(.dtors);
		. = ALIGN(4);
		*(.data);
		*(.bss);
		*(.stack);
		end = .;
	} > ram
  
}
