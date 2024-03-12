
# Step 2: Declare a variable n and set it to 25
.data

n: .word 25

str1: .asciiz "Less than\n"
str2: .asciiz "Less than or equal to\n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"

.text
.globl main
main:
    #4: Read an integer from the user
    li $v0, 5 # syscall for read_int
    syscall
    move $t0, $v0 # Move the read integer to $t0

    # Load n into $t1
    la $t1, n # Load address of n
    lw $t1, 0($t1) # Load word (value of n) into $t1

    #7: Compare if user input is greater than n
    slt $t2, $t1, $t0 # If n < input, set $t2 to 1 (input > n)
    beq $t2, $zero, L1 # If $t2 is 0 (input <= n), skip to L1
    li $v0, 4 # syscall for print_string
    la $a0, str3 # Load address of "Greater than\n"
    syscall
    j End

L1: # 8: Compare if user input is less than or equal to n
    slt $t2, $t0, $t1 # If input < n, set $t2 to 1
    bne $t2, $zero, L2 # If $t2 is not 0 (input < n), jump to L2
    li $v0, 4 # syscall for print_string
    la $a0, str4 # Load address of "Greater than or equal to\n"
    syscall
    j End

L2:
    li $v0, 4 # syscall for print_string
    la $a0, str2 # Load address of "Less than or equal to\n"
    syscall

End:
    # Exit program
    li $v0, 10 # syscall for exit
    syscall
