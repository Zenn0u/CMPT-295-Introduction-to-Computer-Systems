
	.globl conv
conv:
	xorq %rax, %rax		# return value
	xorq %r11, %r11		# i to keep track of number of loops
loop:
	movq %rdi, %r9		# pointer to signal array
	decq %r9		# move signal backwards by 1 element
	addq %rdx, %r9		# move signal forward by rdx(adj) elements

	movq %rsi, %r8		# pointer to h array

	xorq %r10, %r10		# r10 <- 0
	addq (%r9), %r10	# r10 += signal[rdx-1+i]
	imulq (%r8), %r10	# r10 *= h[i]
	addq %r10, %rax		# rax += r10

	incq %rsi		# moves the h array by 1 element
	incq %r11		# i++
	incq %rdx		# adj++

	cmpq $2, %r11		# because h has only size 3, the loop must run 3 times only
	jg endloop		# jumps to endloop if r11-2 > 0
	jmp loop

endloop:
	ret
