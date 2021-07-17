	.globl conv_arr

conv_arr:
	leaq (%rcx,%rsi,1), %r11	# limit <- n + m
	subq $2, %r11			# limit <- n + m - 2
	movq $0, %r10			# i <- 0

loop:
	cmpq %r10, %r11			# if (limit - i) < 0 go to endloop
	jl endloop

	pushq %rdi			# store x
	movq %r10, %rdi			# rdi <- i
	incq %rdi			# rdi <- i + 1
	pushq %rsi			# store n
	movq %rcx, %rsi			# rsi <- m

	call min

	popq %rsi			# restore n
	popq %rdi			# restore x

	pushq %rax			# store ladj
	movq %rcx, %r9			# radj <- m

	pushq %rdi			# store rdi
	movq %rsi, %rdi			# rdi <- n
	addq %rcx, %rdi			# rdi <- n + m
	subq %r10, %rdi			# rdi <- n + m - i
	decq %rdi			# rdi <- n + m - i
	pushq %rsi			# store rsi
	movq %rcx, %rsi			# rsi <- m

	call min

	subq %rax, %r9			# radj <- m - min(m+n-(i+1), m)
	popq %rsi			# restore rsi
	popq %rdi			# restore rdi
	popq %rax			# rax <- ladj

	pushq %r11			# backup r11
	movq %rdi, %r11			# r11 <- rdi
	pushq %r11			# backup rdi
	movq %rsi, %r11			# r11 <- rsi
	pushq %r11			# backup rsi
	movq %rdx, %r11			# r11 <- rdx
	pushq %r11			# backup rdx
	movq %r8, %r11			# r11 <- r8
	pushq %r11			# backup r8

	addq %r10, %r8			# result[i]
	addq %r10, %rdi			# rdi <- x + i
	incq %rdi			# rdi <- x + i + 1
	subq %rax, %rdi			# rdi <- x + i + 1 - ladj
	movq %rdx, %rsi			# rsi <- h
	addq %r9, %rsi			# rsi <- h + radj

	subq %r9, %rax			# rax <- ladj - radj
	movq %rax, %rdx			# rdx <- rax
	pushq %rcx			# backup rcx

	call conv

	mov %al, (%r8)			# return[i] <- conv

	popq %rcx			# restore rcx
	popq %r8			# restore r8
	popq %rdx			# restore rdx
	popq %rsi			# restore rsi
	popq %rdi			# restore rdi
	popq %r11			# restore r11

	incq %r10			# i++
	jmp loop

endloop:
	ret
