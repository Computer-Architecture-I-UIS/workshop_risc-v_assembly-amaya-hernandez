	.file	"order.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	li	a5,536870912
	addi	a5,a5,96
	sw	a5,-24(s0)
	li	a5,16
	sb	a5,-25(s0)
	li	a5,536870912
	addi	a5,a5,96
	li	a4,1828679680
	addi	a4,a4,-1282
	sw	a4,0(a5)
	li	a5,536870912
	addi	a5,a5,100
	li	a4,-725901312
	addi	a4,a4,1567
	sw	a4,0(a5)
	li	a5,536870912
	addi	a5,a5,104
	li	a4,1428824064
	addi	a4,a4,-680
	sw	a4,0(a5)
	li	a5,536870912
	addi	a5,a5,108
	li	a4,-50667520
	addi	a4,a4,322
	sw	a4,0(a5)
	li	a5,536879104
	addi	a5,a5,128
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sw	zero,0(a5)
	sb	zero,-17(s0)
	j	.L2
.L6:
	li	a5,1
	sb	a5,-17(s0)
	li	a5,1
	sb	a5,-18(s0)
	j	.L3
.L5:
	lbu	a5,-18(s0)
	addi	a5,a5,-1
	lw	a4,-24(s0)
	add	a5,a4,a5
	lbu	a4,0(a5)
	lbu	a5,-18(s0)
	lw	a3,-24(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	bgeu	a4,a5,.L4
	lbu	a5,-18(s0)
	addi	a5,a5,-1
	lw	a4,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sb	a5,-33(s0)
	lbu	a5,-18(s0)
	lw	a4,-24(s0)
	add	a4,a4,a5
	lbu	a5,-18(s0)
	addi	a5,a5,-1
	lw	a3,-24(s0)
	add	a5,a3,a5
	lbu	a4,0(a4)
	sb	a4,0(a5)
	lbu	a5,-18(s0)
	lw	a4,-24(s0)
	add	a5,a4,a5
	lbu	a4,-33(s0)
	sb	a4,0(a5)
	sb	zero,-17(s0)
.L4:
	lbu	a5,-18(s0)
	addi	a5,a5,1
	sb	a5,-18(s0)
.L3:
	lbu	a4,-18(s0)
	lbu	a5,-25(s0)
	bltu	a4,a5,.L5
.L2:
	lbu	a5,-17(s0)
	beq	a5,zero,.L6
	lw	a5,-32(s0)
	li	a4,1
	sw	a4,0(a5)
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
