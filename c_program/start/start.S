//
#define __global_pointer	0x0
#define _sp 			0x2000

	

	_start:
	addi x1, zero  , 0
	addi x2, zero  , 0
	addi x3, zero  , 0
	addi x4, zero  , 0
	addi x5, zero  , 0
	addi x6, zero  , 0
	addi x7, zero  , 0
	addi x8, zero  , 0
	addi x9, zero  , 0
	addi x10, zero  , 0
	addi x11, zero  , 0
	addi x12, zero  , 0
	addi x13, zero  , 0
	addi x14, zero  , 0
	addi x15, zero  , 0
	addi x16, zero  , 0
	addi x17, zero  , 0
	addi x18, zero  , 0
	addi x19, zero  , 0
	addi x20, zero  , 0
	addi x21, zero  , 0
	addi x22, zero  , 0
	addi x23, zero  , 0
	addi x24, zero  , 0
	addi x25, zero  , 0
	addi x26, zero  , 0
	addi x27, zero  , 0
	addi x28, zero  , 0
	addi x29, zero  , 0
	addi x30, zero  , 0
	addi x31, zero  , 0
  // Initialize the global pointer// i now that this its needed 
	li gp, __global_pointer 
	li sp, _sp
	mv s0, sp

  // Prepare the execution environment
	auipc ra, 0         // Put ra here, the debugger understands this as end of stack?
	addi sp, sp, -16    // Make this "_start" like a function 
	sw ra, 8(sp)

	/* argc = argv = 0 */
	li a0, 0
	li a1, 0

	// Just call main
	call main
	
 	j _start


1:
	j 1b


