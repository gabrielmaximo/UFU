#nome: Luis Gabriel Maximo
#matrícula: 11721BCC027

#calculo dos dígitos verificadores de um cpf


.data
	cpf: .space  44
	numerox:  .asciiz "\nNumero "
	quebralinha: .asciiz "\n"
	mensagem: .asciiz "\n Seu cpf eh "
	traco: .asciiz "-"

.text
	main:	
	#INICIO DO LOOP
	addi $t0,$zero,1
	#INICIO DO ARRAY
	addi $t1,$zero,0


	while:
		bgt $t0 ,9 ,exit
	
	
		#PREPARANDO A ENTRADA DE DADOS
		li $v0, 4
		la $a0, numerox
		syscall
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 4
		la $a0, quebralinha
		syscall
	
		#LENDO E ARMAZENANDO A ENTRADA DE DADOS
	
		li $v0, 5
		syscall 	
		move $s0,$v0		
	
		#ARMAZENANDO CADA NUMERO DO CPF	
		sw $s0, cpf($t1)
		
		#INCREMENTA O CONTADOR
		addi $t1, $t1, 4
		
		
		#INCREMENTA INSTRUÇÕES DO LOOP
		addi $t0,$t0, 1
		#REPETE O CODIGO ATE SER SOLICITADO A OPÇÃO DE SAIDA
		j while
	exit:
	
	jal calculadecimo
	jal calcula_decimo_primeiro

		
	#IMPRIMINDO O ARRAY NA TELA
	#ZERANDO O CONTADOR E O ARRAY
	addi $t0,$zero,1
	addi $t1,$zero,0
	
	#IMPRIME A MENSSAGEM "seu cpf eh "
	li $v0, 4
	la $a0, mensagem
	syscall
	#LISTA OS NUMEROS DO 1 AO 9
	while2:
		#CONDIÇÃO DE SAIDA (>9)
		bgt $t0,9,exit2
		
		#ARMAZENA O VALOR EM T2
		lw $t2,cpf($t1)
		
		#INCREMENTA O INDICE DO ARRAY
		addi $t1, $t1, 4
		
		#IMPRIME O VALOR
		li $v0, 1
		move $a0, $t2
		syscall
		
		#AVANÇA O LOOP (++)
		addi $t0,$t0, 1
		j while2
	exit2:
	
		#IMPRIME UM CARACTER "-"
		li $v0, 4
		la $a0, traco
		syscall
		#IMPRIME OS ULTIMOS DOIS CARACTERES DE "-"
	
		#ARMAZENA O VALOR EM T2
		lw $t2,cpf($t1)
		
		#AVANÇA O ARRAY
		addi $t1, $t1, 4
		
		#IMPRIME O VALOR
		li $v0, 1
		move $a0, $t2
		syscall
		
		#GUARDA O VALOR EM T2
		lw $t2,cpf($t1)
		
		
		#IMPRIME O VALOR
		li $v0, 1
		move $a0, $t2
		syscall	


		
	
	
	#FINALIZA O PROGRAMA
	li $v0,10
	syscall
	
	
	
	
	calculadecimo:
		#CONTADOR E USADO PARA MULTIPLICAR O ARRAY
		#REGISTRADORES UTILIZADOS PARA ARMAZENAR VALORES
		#CONTADOR
		addi $t0,$zero,1
		#INDICE DO ARRAY
		addi $t4,$zero,0
		#VALORES DE 10 A 2
		addi $t1,$zero,10
		# T5 GUARDA A SOMA DAS MULTIPLICAÇOES PELOS NUMEROS DO CPF
		addi $t5, $zero,0
		#GUARDA AS MULTIPLICAÇÕES PARCIAIS 
		addi $t3,$zero,0
		while3:
			bgt $t0, 9,exit3
			

			#ARMAZENA O VALOR DO ARRAY EM T2
			lw $t2, cpf($t4)
			#MULTIPLICA E ARMAZENA EM T3
			mul $t3, $t2, $t1
			
			#GUARDA OS VALORES DAS MULTIPLICAÇÕES
			add $t5,$t5,$t3
			
			#DECREMENTA O VALOR A SER MULTIPLICADO
			subi $t1,$t1,1
			#INCREMENTA O INDICE
			addi $t4,$t4,4
			#INCREMENTA O CONTADOR
			addi $t0,$t0, 1
			j while3
		exit3:

		
		#AGORA BASTA PEGAR O VALOR EM T5, MULTIPLICAR POR 10 E DIVIDIR POR 11
		mul $t5, $t5, 10
		div $t5, $t5, 11
		#COLOCA O VALOR DO DECIMO NUMERO SENDO O RESTO DA DIVISAO POR 11
		addi $t6,$zero,0
		mfhi $t6
	 	
	 	
	 	beq $t6, 10,restozero
	 	
		
		sw $t6, cpf($t4)
		
	jr $ra
		
			
	
		
		
	#reutilizei o anterior e mudei alguns comentários e alguns índices:
		
	calcula_decimo_primeiro:
	#vou usar o contador para multiplicar o array
		#registradores usandos para armazenar os valores
		#contador
		addi $t0,$zero,1
		#indice do array
		addi $t4,$zero,0
		#valores de 11 a 2
		addi $t1,$zero,11
		# t5 guarda a soma das multiplicações pelos núemros do cpf
		addi $t5, $zero,0
		#guarda as multiplicações parciaais 
		addi $t3,$zero,0
		#t2 guarda o valor do array naquele instante do loop
		addi $t2,$zero,0
		while4:
			bgt $t0, 10,exit3
			

			#guarda o valor do array em t2
			lw $t2, cpf($t4)
			#multiplica e guarda em t3
			mul $t3, $t2, $t1
			
			#guarda os valores das multiplicaçoes
			add $t5,$t5,$t3
			
			#decrementa o valor que vai multiplicar
			subi $t1,$t1,1
			#incrementa o índice
			addi $t4,$t4,4
			#incrementa o contador
			addi $t0,$t0, 1
			j while4
		exit4:
		

		#agora basta pegar o valor em t5 multiplicar por 10 e dividir por 11
		mul $t5, $t5, 10
		div $t5, $t5, 11
		#e colcoar o valor do décimo número sendo o resto dessa divisão por 11
		addi $t6,$zero,0
		mfhi $t6
		
		#explicação dessa condição no final do código
		beq $t6, 10,restozero
		#armazena o valor no array
		sw $t6, cpf($t4)
	jr $ra
	
	
	
	#se o resto da divisão do numero por 10 der 10 tem que setar pra 0
	restozero:
	addi $t6,$zero,0
	jr $ra
