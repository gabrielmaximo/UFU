#     Arquitetura e Organização de Computadores 1            #
#                 PC - 2 (Bhaskara)                          #

#  Aluno: Luis Gabriel Maximo ->  Matricula: 11721BCC027     #

#  Programa que calcula o Discriminante da fórmula Bhaskara. #

	.data
input_str_0:   .asciiz "Entrada:"
input_str_a:   .asciiz "\nA= "
input_str_b:   .asciiz "B= "
input_str_c:   .asciiz "C= "
out_str_r1:    .asciiz "\nSaida:\nr1= "
out_str_r2:    .asciiz "\nr2= "
out_str_erro:  .asciiz "\nErro, Discriminante Negativo!\n"
zero: .float 0.0
two: .float 2
four: .float 4 

   	.text
   		.globl main

main:
    	# 	REGISTRADORES AUXILIARES UTILIZADOS DURANTE OS CALCULOS:
	lwc1 $f10,zero
	lwc1 $f17,two
	
	li	$v0, 4
	la	$a0, input_str_0
	syscall
	
	#	LEITURA DE A
	li	$v0, 4
	la	$a0, input_str_a
	syscall
	li	$v0, 6
	syscall
	mov.s	$f1, $f0
	
	#	LEITURA DE B
	li	$v0, 4
	la	$a0, input_str_b
	syscall
	li	$v0, 6
	syscall
	mov.s	$f2, $f0
	
	#	LEITURA DE C
	li	$v0, 4
	la	$a0, input_str_c
	syscall
	li	$v0, 6
	syscall
	mov.s	$f3, $f0
	
	#	CHAMA A FUNCAO SQRT-DELTA E ARMAZENA O VALOR DA RAIZ DE DELTA NO REGISTRADOR F4
    	jal sqrt_delta
    		mov.s   $f24,  $f0
    	
    		#	CALCULANDO AS RAIZES:
	
		#CALCULANDO (2*A)
		mul.s $f23, $f17, $f1
	
		#	CALCULANDO A PRIMEIRA RAIZ: (R1)
		neg.s $f22, $f2
		add.s $f21, $f22, $f24
		div.s $f5, $f21, $f23
	
		#	CALCULANDO A SEGUNDA RAIZ: (R2)
		sub.s $f20, $f22, $f24
		div.s $f6, $f20, $f23 
	
   	 	#   	IMPRIMINDO A SOLUÇÃO
    	
   	 	#	IMPRIMINDO R1
    		li	$v0, 4
		la	$a0, out_str_r1
		syscall
    		li	$v0, 2
		add.s $f12, $f10, $f5
		syscall
	
		#	IMPRIMINDO R2
		li	$v0, 4
		la	$a0, out_str_r2
		syscall
    		li	$v0, 2
		add.s $f12, $f10, $f6
		syscall
    	
    		li $v0, 10
    		syscall
    	
	
sqrt_delta:
	# REGISTRADORES AUXILIARES UTILIZADOS DURANTE OS CALCULOS:
	lwc1 $f16,four
	
	#	AQUI COMEÇA O CÁLCULO -> PRIMEIRO O DISCRIMINANTE COM.. (B^2)
	mul.s	 $f30,$f2, $f2	#RESULTADO SALVO EM f30

	#	AGORA (4*A*C)
	
	#	PRIMEIRO (4*A)
	mul.s	$f28, $f16, $f1
	
	#	ENTÃO (4*A)*C
	mul.s	$f27, $f28, $f3
	
	#	AGORA TERMINANDO COM A SUBTRAÇÃO DE B^2 - 4*A*C
	sub.s	$f4, $f30, $f27
	
	#	AQUI VERIFICA  SE O DISCRIMINANTE É MENOR QUE ZERO
	mfc1 $t1, $f4
	bltz  $t1, exit
	
	#	AQUI CALCULA A RAIZ DO DISCRIMINANTE (sqrt(d))
	sqrt.s $f0, $f4
	
	#	FINALIZANDO A FUNCAO E RETORNANDO O VALOR EM $f0
	jr      $ra
	
	
	#	FINALIZA O PROGRAMA
exit:
    	li $v0, 10
    	syscall
