.text			# Declaracao de inicio do segmento de texto
	.globl	main		# Declaracao de que o rotulo main e global
########################################
# testes de instrucoes individuais
########################################
main:		
			addi $s1, $zero, 15
			sw   $s1, array
.data

array: .word 0xffffffff