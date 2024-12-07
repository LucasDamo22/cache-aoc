.text
.globl main
main:
	li	$a0, 7
	la   $s2, array #carrega oprimeiro endereço da mem data
	lw   $s3, cafe  # carrega a polavra que vai encher memoria
	jal	fib
	move 	$a0, $v0
	sw      $a0,result
	
fim: j fim
	
	
fib:	
	j loop
retloop:subiu	$sp, $sp, 12
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
############################
loop:	
	lw   $s4, contador #carrega um contador
	addiu $s4, $s4, 1  #soma 1 no contador
 	bge   $s4, 20, retloop
	sw    $s4, contador		
	#cache 1
jump1:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump17
	#cache 2
jump2:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero	
	j jump16
	#cache 3
jump3:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero	
	j jump12
	#cache 4
jump4:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump11
	#cache 4
jump5:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero	
	j jump9
	#cache 6
jump6:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j last


jump7:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump12
	#cache 8
jump8:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump15
	#cache 9
jump9:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump4
	#cache 10
jump10:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump6
	#cache 11
jump11:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump10
	#cache 12
jump12:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump5
	#cache 13
jump13:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump3
	#cache 14
jump14:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump13
jump15:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump18
jump16:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump8
jump17:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump2
jump18:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump19
jump19:	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	addu  $t7, $zero, $zero
	j jump14
	
last:	addiu $s2, $s2, 4 #soma 4 no endereço mem
	addu $s1, $zero, $s3 #carrega bebacafe no s1
	sw   $s1, 0($s2) #salva o s1 na mem
	j loop
	
.data

result: .word 0x0
contador: .word 0
cafe: .word 0xBEBACAFE
array: .word 0xffffffff
