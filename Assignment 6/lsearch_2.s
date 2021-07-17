	# var map
	#	%r8d = int i
	#	%esi = int n
	#	%rdi = int* A
	#	%r9d = *tmp
	#	%edx = int target
	.globl	lsearch_2
lsearch_2:
	testl	%esi, %esi		# if (n <= 0)
	jle	endn			#    jump endn
	movslq	%esi, %rax		# tmp = n
	leaq	-4(%rdi,%rax,4), %rax	# tmp = A + n*4 - 4
	movl	(%rax), %r9d		# r9d = *tmp
	movl	%edx, (%rax)		# A[n-1] = target
	cmpl	(%rdi), %edx		# if (target == A[0])
	je	i_0			#    jmp i_0
	movl	$1, %ecx		# ecx = 1
loop1:
	movl	%ecx, %r8d		# r8d(i) = ecx
	addq	$1, %rcx		# rcx++
	cmpl	%edx, -4(%rdi,%rcx,4)	# if (target != A[rcx-1])
	jne	loop1			#    jmp loop1
loop2:
	movl	%r9d, (%rax)		# A[n-1] = r9d(*tmp)
	leal	-1(%rsi), %eax		# eax = n - 1
	cmpl	%r8d, %eax		# if (i < n-1)
	jg	i_i			#    jmp i_i
	cmpl	%edx, %r9d		# if (*tmp != target)
	jne	endn			#    jmp endn
	rep ret				# return i
i_i:
	movl	%r8d, %eax		# eax = i
	ret				# return i
i_0:
	xorl	%r8d, %r8d		# i = 0
	jmp	loop2			# jmp loop2
endn:
	movl	$-1, %eax		# eax = -1
	ret				# return -1
