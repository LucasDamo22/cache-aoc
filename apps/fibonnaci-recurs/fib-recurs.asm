.text
.globl main
main:
	li	$a0, 7
	jal	fib
	move 	$a0, $v0
	sw      $a0,result
	
fim: j fim
	
	
fib:	
        subiu	$sp, $sp, 12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	
	addiu	$s0, $a0, 0
	beq	$0, $s0, done
	addiu	$t0, $0, 1
	beq	$t0, $s0, done
	
	addiu	$a0, $s0, -1
	jal	fib
	addiu	$s1, $v0, 0
	subiu	$a0, $s0, 2
	jal	fib
	addu	$v0, $v0, $s1
	j	finish
	
done:	
        addu	$v0, $0, $s0
	j	finish
	
finish: 
        lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 12
	jr	$ra
	
	
.data

result: .word 0x0
