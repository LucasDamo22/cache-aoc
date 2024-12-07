
.data
prompt1: .asciiz "Programa de Raiz Quadrada - Newton-Raphson\n"
prompt2: .asciiz "Desenvolvedor:Lucas Daom, Nathan Cidal, Antonio\n"
prompt3: .asciiz "Digite os parâmetros x e i para calcular sqrt_nr(x, i) ou -1 para abortar a execução:\n"
prompt4: .asciiz "sqrt_nr("
prompt5: .asciiz ", "
prompt6: .asciiz ") = "
prompt7: .asciiz "\n"

.text
.globl main

main:
    # Print initial messages
    li $v0, 4
    la $a0, prompt1
    #syscall
    li $v0, 4
    la $a0, prompt2
    #syscall

loop:
    # Print parameter prompt
    li $v0, 4
    la $a0, prompt3
#    syscall 

    # Read x
    li $v0, 40
#    syscall
    move $t0, $v0  # x value in $t0
    bltz $t0, exit_program  # Break if x < 0

    # Read i
    li $v0, 8
#    syscall
    move $t1, $v0  # i value in $t1
    bltz $t1, exit_program  # Break if i < 0

    # Call sqrt_nr(x, i)
    subiu $sp, $sp, 12 # Opens space for ra and 2 parameters
    sw $ra, 8($sp)  # Saves the $ra
    sw $t0, 4($sp)  # Saves the x (first parameter)
    sw $t1, 0($sp)  # Saves the i (seccond parameter)
    jal sqrt_nr
    lw $ra, 8($sp)  # Restores the $ra
    lw $t0, 4($sp)  # Restores the x
    lw $t1, 0($sp)  # Restores the i
    addi $sp, $sp, 12 # Restores the stack from the last call

    move $t2, $v0  # Store result

    # Print result
   
    j exit_program

exit_program:
    j exit_program

sqrt_nr:
    # Restore parameters from the stack
    lw $a0, 4($sp)  # restores x
    lw $a1, 0($sp)  # restores i

    # Base case: if (i == 0)
    beqz $a1, base_case

    # Recursive call: sqrt_nr(x, i-1)
    addiu $a1, $a1, -1
    subiu $sp, $sp, 12 # Opens space for ra and 2 parameters
    sw $ra, 8($sp)  # Saves the $ra
    sw $a0, 4($sp)  # Saves the x (first parameter)
    sw $a1, 0($sp)  # Saves the i (seccond parameter)
    jal sqrt_nr
    lw $ra, 8($sp)  # Restores the $ra
    lw $a0, 4($sp)  # Restores the x
    lw $a1, 0($sp)  # Restores de old i-1
    addiu $sp, $sp, 12 # Restores the stack from the last call
    move $t0, $v0   # Hold returned value in a temp reg
    div $a0, $t0    # x / sqrt_nr
    mflo $t4        # Move result of division to $t4

    # Execute: (sqrt_nr + (x/sqrt_nr)) >> 1;
    add $t2, $t0, $t4  # $t2 = sqrt_nr + x/sqrt_nr
    sra $v0, $t2, 1    # Return value = ($t2) >> 1 (divides by 2)
    jr $ra    

base_case:
    li $v0, 1       # Return 1.
    jr $ra          # Return. 
