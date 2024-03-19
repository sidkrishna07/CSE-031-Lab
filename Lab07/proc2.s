.data
x:	.word 5
y:	.word 10
m:	.word 15
b:	.word 2

.text
MAIN:	la $t0, x
	lw $s0, 0($t0)		# s0 = x
	la $t0, y
	lw $s1, 0($t0)		# s1 = y
	
	# Prepare to call SUM
	addu $a0, $zero, $s0	# Set a0 as input argument for SUM
	jal SUM
	addu $t0, $s1, $s0
	addu $s1, $t0, $v0
	addiu $a0, $s1, 0 
	li $v0, 1		 
	syscall	
	j END
		
SUM: 	addiu $sp, $sp, -12	# Prologue: Make space on stack for $ra, $a0, and $s0
	sw $ra, 8($sp)		# Save $ra
	sw $a0, 4($sp)		# Save $a0
	sw $s0, 0($sp)		# Save $s0

	la $t0, m
	lw $s0, 0($t0)		# s0 = m
	addu $a0, $s0, $a0	# Update a0 as new argument for SUB
	jal SUB
	addu $v0, $a0, $v0

	lw $s0, 0($sp)		# Epilogue: Restore $s0
	lw $a0, 4($sp)		# Restore $a0
	lw $ra, 8($sp)		# Restore $ra
	addiu $sp, $sp, 12	# Adjust stack pointer back
	jr $ra		
		
SUB:	la $t0, b
	addiu $sp, $sp -4
	sw $s0, 0($sp)		# Backup s0 from SUM
	lw $s0, 0($t0)		# s0 = b
	subu $v0, $a0, $s0
	lw $s0, 0($sp)		# Restore s0 from SUM
	addiu $sp, $sp 4
	jr $ra

END: