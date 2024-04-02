.data
prompt: .asciiz "Please enter a number: "
result: .asciiz "\n"

.text
.globl main

main:
    # Print prompt
    li $v0, 4          # syscall for print string
    la $a0, prompt     # load address of prompt into $a0
    syscall

    # Read integer
    li $v0, 5          # syscall for read int
    syscall
    move $a0, $v0      # move read integer into $a0 for recursion function

    jal recursion      # call recursion function
    move $a1, $v0      # move result of recursion into $a1

    # Print result
    li $v0, 1          # syscall for print int
    move $a0, $a1      # move result into $a0
    syscall

    # Print newline
    li $v0, 4          # syscall for print string
    la $a0, result     # load address of newline into $a0
    syscall

    # Exit
    li $v0, 10         # syscall for exit
    syscall

recursion:
    # Base case 1: if m == -1
    li $t0, -1         # load -1 into $t0
    beq $a0, $t0, base_case_1

    # Base case 2: if m <= -2
    li $t1, -2         # load -2 into $t1
    ble $a0, $t1, base_case_2

    # Recursive case
    addi $sp, $sp, -8  # allocate stack space for 2 words
    sw $ra, 4($sp)     # save return address
    sw $a0, 0($sp)     # save argument m

    addi $a0, $a0, -3  # calculate m - 3
    jal recursion      # recursion(m - 3)
    move $t2, $v0      # save result of recursion(m - 3) in $t2

    lw $a0, 0($sp)     # restore argument m
    addi $a0, $a0, -2  # calculate m - 2
    jal recursion      # recursion(m - 2)
    add $v0, $v0, $t2  # add results of recursion(m - 3) and recursion(m - 2)
    lw $ra, 4($sp)     # restore return address
    lw $a0, 0($sp)     # restore argument m
    add $v0, $v0, $a0  # add m to the result
    addi $sp, $sp, 8   # deallocate stack space
    jr $ra             # return

base_case_1:
    li $v0, 3          # return 3
    jr $ra

base_case_2:
    blt $a0, $t1, less_than_neg2
    li $v0, 1          # return 1 for m == -2
    jr $ra

less_than_neg2:
    li $v0, 2          # return 2 for m < -2
    jr $ra