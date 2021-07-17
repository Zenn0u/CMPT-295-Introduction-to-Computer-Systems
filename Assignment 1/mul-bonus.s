 	.globl times
times:
	movl $0, %eax
	cmpl $0, %edi
	je endloop
	cmpl $0, %esi
	je endloop
loop:
	cmpl $0, %edi
	jle endloop
	test $1, %edi
	je even
odd:
	addl %esi, %eax
	shl $1, %esi
	shr $1, %edi
	jmp loop
even:
	shl $1, %esi
	shr $1, %edi
	jmp loop
endloop:
	ret

