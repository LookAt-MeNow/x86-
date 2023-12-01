	.file	"derl.c"
	.intel_syntax noprefix
	.text
	.globl	swap
	.type	swap, @function
swap:
	endbr32
	push	ebp
	mov	ebp, esp
	sub	esp, 4

	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [ebp-4], eax
	
	mov	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp+12]
	mov	edx, DWORD PTR [ebp-4]
	mov	DWORD PTR [eax], edx
	nop
	leave
	ret
	.size	swap, .-swap
	.globl	main
	.type	main, @function
main:
	endbr32
	push	ebp
	mov	ebp, esp
	sub	esp, 12
	mov	eax, DWORD PTR gs:20
	mov	DWORD PTR [ebp-4], eax
	xor	eax, eax

	mov	DWORD PTR [ebp-12], 3
	mov	DWORD PTR [ebp-8], 4

	lea	eax, [ebp-8]
	push	eax
	lea	eax, [ebp-12]
	push	eax
	call	swap
	add	esp, 8
	mov	eax, 0
	mov	edx, DWORD PTR [ebp-4]
	xor	edx, DWORD PTR gs:20
	je	.L4
	call	__stack_chk_fail
.L4:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 4
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 4
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 4
4:
