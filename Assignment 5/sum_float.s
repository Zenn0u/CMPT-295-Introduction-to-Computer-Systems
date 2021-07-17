	.globl sum_float

	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer)
	#   %rsi:   n
	#   %rbp:   endptr

sum_float:
	push	%rbp

	xorps	%xmm0, %xmm0            # total <- 0.0

	xorq	%r11, %r11		# i = 0
	movq 	%rsp, %r10		# backup

	movq	%rsi, %r9		# n = size
	imul	$4, %r9			# bit space of stack n * 4
	subq	%r9, %r10		# head(Q)

	movq	$0x7f800000, %r8	# r8 <- +inf
	movq 	%r8, %xmm1		# xmm1 <- +inf
	movss	%xmm1, (%r10)		# head(Q) <- +inf
loop:
	cmpq 	%r11, %rsi		# if i >= n
	jle 	endloop			# jump if condition is met

	xorps	%xmm1, %xmm1		# xmm1 <- 0.0
	xorps	%xmm2, %xmm2		# xmm2 <- 0.0

	movq	(%rdi), %rdx		# rdx <- M[rdi]
	movq	(%r10), %rcx		# rcx <- M[r10]

	cmpq 	%rcx, %rdx		# rdx - rcx < 0
	jl	qx

fx:
	movss	(%rdi), %xmm1		# xmm1 <- M[rdi]
	addq	$4, %rdi		# rdi += 4
	jmp	nd
qx:
	cmpq	(%r10), %r8		# if M[r10] == +inf skip
	je nd
	movss	(%r10), %xmm1		# xmm1 <- M[r10]
	sub	$4, %r10		# r10 -= 4
nd:

        movq    (%rdi), %rdx		# rdx <- M[rdi]
        movq    (%r10), %rcx		# rcx <- M[r10]

        cmpq    %rcx, %rdx		# rdx - rcx < 0
        jl      qy

fy:
	movss 	(%rdi), %xmm2		# xmm2 <- M[rdi]
	addq	$4, %rdi		# rdi += 4
	jmp xy

qy:
        cmpq    (%r10), %r8		# if M[r10] == +inf skip
        je xy
        movss   (%r10), %xmm2		# xnn2 <- M[r10]
        sub     $4, %r10		# r10 -= 4

xy:
	addss	%xmm2, %xmm1		# xmm1 += xmm2
	addq $4, %r10			# r10 += 4
	movss	%xmm1, (%r10)		# M[r10] <- xmm1


	incq	%r11			# i++
	jmp	loop
endloop:
	movq (%r10), %xmm0		# xmm0 <- M[r10]
	pop	%rbp
	ret
