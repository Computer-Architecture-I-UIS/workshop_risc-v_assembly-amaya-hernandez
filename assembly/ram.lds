/*-- Assembler Linker --*/
/*-- Only ram not rom --*/
OUTPUT_ARCH( "riscv" )

MEMORY{  ram ( wxa!ri ) : ORIGIN = 0x0, LENGTH = 0x2000	}

SECTIONS
{
  .memory : {
		. = 0x000004;
		*(.text);
		*(.data);
		*(.bss);
		end = .;
	} > ram
  
}
