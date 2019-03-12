#Nome: Luis Gabriel Maximo
#Matricula: 11721BCC027

    #Algoritmo de itera��o (ciclo de repeti��o) - Sequencia de Collatz

.data 	#  strings usadas nas entradas e saidas de dados

input1: .asciiz "Primeiro termo: "
input2: .asciiz ", "
output: .asciiz "Lista de termos: "

.text

main:
    
    li		$v0, 4
    la		$a0, input1             		#  Imprime a String -> "Primeiro termo" contida em input1
    syscall
    
    li		$v0,	5				#  Solicita ao usuario, um numero inteiro e armazena em v0
    syscall
    move		$t0, $v0		    	#  Armazena o inteiro de v0, no registrador t0
    
    li		$v0, 4	
    la		$a0, output			    	#  Imprime a string -> "Lista de Termos" contida em input2
    syscall
    
    li		$v0, 1			    
    move	$a0, $t0                		#  Imprime o primeiro termo, em seguida da inicio a itera��o
    syscall

    beq         $t0, 0  exit				#  Aqui evita que entre em um Loop infinito ao entrar com o numero 0
    beq		$t0, 1  exit		        	#  Termina o programa se o primeiro termo lido ja for o numero 1
    
iteracao:
    jal		nextTermo				#  Fun��o que calcula os proximos termos
    
    li		$v0, 4
    la		$a0, input2			    	#  Coloca a virgula depois de imprimir um termo.
    syscall
    
    li		$v0, 1
    move	$a0, $s0			    	#  Pega o inteiro retornado pela fun��o nextTermo em s0, joga em a0 para poder imprimir em seguida
    syscall
    
    beq		$s0, 1 exit		        	#  Termina a itera��o caso o retorno da fun��o nextTermo (registrador s0) seja 1
    jal iteracao					#  Caso contrario, repete o cliclo(entra em loop at� que s0 seja 1).
    


    #Aqui est�o as fun��es auxiliares usadas para o calculo dos termos
    
nextTermo:					        #  Recebe $a0 de argumento (onde a0 inicialmente vai ser o primeiro termo), retorno em $s0
    rem  		$t0, $a0, 2	        	#  t0 recebe o resto da divis�o de a0 por 2
    beqz		$t0, par			#  verifica se t0 � par, ou seja, verifica se t0 possui o valor 0
    
    # Se for Impar, ou seja, beqz for falso, ent�o faz isso:
    move		$s0, $a0			#  pega o termo contido em a0, e coloca em s0 para poder calcular o termo quando for impar.
    mul		    	$s0, $s0, 3		   	#  Aqui s0 recebe seu triplo
    add		    	$s0, $s0, 1		    	#  E aqui s0 recebe + 1
    jr			$ra				#  Retorno da funcao (retorna s0)

    # Se for par, ent�o essa fun��o � chamada.
par:
    move		$s0, $a0			#  coloca o termo contido em a0, passado como entrada da fun��o em s0 para poder fazer o calculo do termo quando ele for par.
    div		    	$s0, $s0, 2		    	#  Divide s0 por 2
    jr			$ra				#  Retorno da funcao (retorna s0)     

exit:
    li			$v0, 10			    	#  Sai do programa
    syscall 
