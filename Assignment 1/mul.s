	.globl times
times:
	movl $0, %eax		#total = 0
	cmpl $0, %edi		#checks a - 0 ? 0
	je endloop		#ends the loop if a == 0
	cmpl $0, %esi		#checks b - 0 ? 0
	je endloop		#ends the loop if b == 0
	movl $0, %ecx 		#loop counter i
loop:
	cmpl %ecx, %esi		#checks if b - i ? 0
	jle endloop		#ends the loop if i >= 0
	add %edi, %eax		#total += a
	inc %ecx		#++i
	jmp loop		#jumps to loop
endloop:
	ret			#returns %eax (total)

