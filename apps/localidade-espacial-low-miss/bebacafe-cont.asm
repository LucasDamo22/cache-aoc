.text			# Declaracao de inicio do segmento de texto
	.globl	main		# Declaracao de que o rotulo main e global
########################################
# testes de instrucoes individuais
########################################
main:				
	la   $s2, array #carrega oprimeiro endereço da mem data
	lw   $s3, cafe  # carrega a polavra que vai encher memoria
	
loop:	
	li   $t0, 5
	lw   $s4, contador #carrega um contador
	addiu $s4, $s4, 1  #soma 1 no contador
 	bge   $s4, 20, fim
	sw    $s4, contador		
	#cache 1
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	#cache 2
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0	
	#cache 3
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0	
	#cache 4
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0	
	#cache 4
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0	
	#cache 6
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	addu  $t0, $t0, $t0
	#cache 7
	#addu  $t0, $zero, $zero
	#addu  $t0, $zero, $zero
	#addu  $t0, $zero, $zero
	#addu  $t0, $zero, $zero
	#addu  $t0, $zero, $zero
	#addu  $t0, $zero, $zero
	#addu  $t0, $zero, $zero
	#saddu  $t0, $zero, $zero		
	
	addiu $s2, $s2, 4 #soma 4 no endereço mem
	addu $s1, $zero, $s3 #carrega bebacafe no s1
	sw   $s1, 0($s2) #salva o s1 na mem
	j loop
fim:
	j fim
.data
contador: .word 0
cafe: .word 0xBEBACAFE
array: .word 0xffffffff
