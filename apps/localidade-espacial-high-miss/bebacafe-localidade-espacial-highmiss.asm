.text			# Declaracao de inicio do segmento de texto
	.globl	main		# Declaracao de que o rotulo main e global
########################################
# testes de instrucoes individuais
########################################
main:				
	la   $s2, array #carrega oprimeiro endereço da mem data
	lw   $s3, cafe  # carrega a polavra que vai encher memoria
	
loop:	
	lw   $s4, contador #carrega um contador
	addiu $s4, $s4, 1  #soma 1 no contador
 	bge   $s4, 20, fim
	sw    $s4, contador		
	#cache 1
jump1:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 2
jump2:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero	
	#cache 3
jump3:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero	
	#cache 4
jump4:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 4
jump5:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero	
	#cache 6
jump6:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 7
jump7:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 8
jump8:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 9
jump9:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 10
jump10:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 11
jump11:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 12
jump12:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 13
jump13:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	#cache 14
jump14:	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	addu  $t0, $zero, $zero
	
last:	addiu $s2, $s2, 4 #soma 4 no endereço mem
	addu $s1, $zero, $s3 #carrega bebacafe no s1
	sw   $s1, 0($s2) #salva o s1 na mem
	j loop
fim:
	j fim
.data
contador: .word 0
cafe: .word 0xBEBACAFE
array: .word 0xffffffff
