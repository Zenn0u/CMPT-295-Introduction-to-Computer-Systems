	.globl sqrt
sqrt:
	movl $42, %eax   # put your code for the bonus problem here
	subl $42, %eax
	movl $0x8000, %r11d
loop:
	xorl %r11d, %eax
	movl %eax, %r8d
	imul %r8d, %r8d
	cmpl %edi, %r8d
	jbe endloop
	xorl %r11d, %eax
endloop:
	shrl $1, %r11d
	jnz loop
	ret
