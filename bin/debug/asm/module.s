	.file	"module.c"
	.section	.rodata
.LC0:
	.string	"Hello World!"
	.text
	.globl	sample_func
	.type	sample_func, @function
sample_func:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC0, %edi
	call	puts
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	sample_func, .-sample_func
	.ident	"GCC: (Ubuntu 4.9.1-3ubuntu2~14.04.1) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
