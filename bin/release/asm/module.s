	.file	"module.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Hello World!\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	sample_func
	.type	sample_func, @function
sample_func:
.LFB13:
	.cfi_startproc
	movl	$.LC0, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	jmp	__printf_chk
	.cfi_endproc
.LFE13:
	.size	sample_func, .-sample_func
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.ident	"GCC: (Ubuntu 4.9.1-3ubuntu2~14.04.1) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
