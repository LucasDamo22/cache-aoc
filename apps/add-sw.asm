.text			# Declaracao de inicio do segmento de texto
	.globl	main		# Declaracao de que o rotulo main e global
########################################
# testes de instrucoes individuais
########################################
main:				
	la   $s2, array
	lw   $s3, cafe

loop:	lw   $s1, ($s2)
	addiu $s2, $s2, 4
	addu $s1, $zero, $s3
	sw   $s1, 0($s2)
	j loop
.data
cafe: .word 0xBEBACAFE
array: .word 0xffffffff
