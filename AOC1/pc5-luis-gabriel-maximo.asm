# Nome: Luis Gabriel Maximo
# Matricula: 11721BCC027

	# Algoritmo de simulação de pilha - Sequencia de Collatz
    
.data

input1: .asciiz "Primeiro termo: "
input2: .asciiz ", "
output: .asciiz "Lista de termos: "

.text

main:

    li		$v0, 4				
    la		$a0, input1			#  Imprime a String -> "Primeiro termo" contida em input1
    syscall
    
    li		$v0, 5				#  Solicita ao usuario um numero inteiro
    syscall
    move	$t0, $v0			#  Armazena o inteiro de v0, no registrador t0
    
    sw		$t0, 0($sp)			#  Armazena o primeiro termo na pilha
    
    li		$v0, 4		
    la		$a0, output			#  Imprime a string -> "Lista de Termos" contida em input2
    syscall
    
    li		$v0, 1				
    move	$a0, $t0			#  Imprime primeiro termo em seguida da inicio ao calculo dos proximos termos
    syscall
 
    beq         $t0, 0  exit			#  Aqui evita que entre em um Loop infinito ao entrar com o numero 0
    beq		$t0, 1  exit		        #  Termina o programa se o primeiro termo lido ja for o numero 1
    
iteracao:
    
    jal		nextTermo			#  Função que calcula os proximos termos e os insere na pilha
    
    li		$v0, 4				
    la		$a0, input2			#  Coloca a virgula depois de imprimir um termo.
    syscall
    
    li		$v0, 1				
    lw		$s0, 0($sp)			#  Recebe o termo na pilha
    move	$a0, $s0			#  Imprime o termo contido na pilha
    syscall
    
    beq		$s0, 1	exit			#  Se o retorno da função nextTermo for 1, finaliza o programa
    jal iteracao				#  Se não for 1, ira repetir o calculo do proximo termo
   
   	# Aqui estão as funções auxiliares usadas para o calculo dos termos
    
nextTermo:

    lw		$t0, 0($sp)			#  Recebe o termo da pilha como argumento
    rem		$t1, $t0, 2			#  Armazena o resto da divisão do termo da pilha por 2, no registrador t1
    beqz	$t1, par			#  vericica se ele é par, pelo resto obtido
    
    	# Se for impar, então faz isso:
    mul		$s0, $a0, 3			#  Multiplica o termo por 3
    add		$s0, $s0, 1			#  Soma 1 ao termo que foi multiplicado por 3
    sw		$s0, 0($sp)			#  Coloca na pilha o termo calculado
    jr		$ra				#  Retorna esse termo através de s0
    
    	# Senão, a função par é chamada:
 par:
    move    $s0, $a0            #
    div		$s0, $a0, 2			#  Divide o termo por 2
    sw		$s0, 0($sp)			#  Coloca na pilha o termo Calculado
    jr		$ra    				#  Retorna através do registrador s0
    
exit: 						# Função unicamente para sair do programa no momento em que chegar no termo 1
    li		$v0, 10
    syscall
    
    
