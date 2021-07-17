	.globl sqrt
sqrt:
	movl $0, %eax		# result <- 0
	movl $0, %r10d
	movl $0, %r8d
loop:
	movl %r8d, %r9d		# r9d keeps track of the current r8d
	imul %r8d, %r8d		# assigns r8d <- r8d * r8d
	cmpl %edi, %r8d		# compares if the r8d squared is less then edi
	jg endloop		# jumps if edi > r8d
	movl %r9d, %r8d		# restores r8d back ( r8d <- r9d )
	movl %r9d, %r10d	# r10d keeps track of the previous r8d
	incl %r8d		# increases r8d by 1
	jmp loop
endloop:
	movl %r10d, %eax	# restores the value r8d before the last loop
				# because the squared of that number is either equal or closest to square of our number
	ret
