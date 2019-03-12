#     Arquitetura e Organizacao de Computadores 1     
#                 PC - 1 (Divisao)                    
#                                                     
#  Aluno: Luis Gabriel Maximo:                        
#  Matricula: 11721BCC027 
#  Periodo: 3� (terceiro)      

#  Especificacao:                                     
#       Programa que faz a divisão entre dois números 
#   inteiros(fornecidos pelo usuário via teclado) e   
#   imprime na tela o quociente e o resto.            


    # strings de entrada e saida do programa
.data                                        
greet_str: .asciiz "\t** Divisao **\n\n"
input_str: .asciiz "Digite dois numeros inteiros:\n"
out_str_A: .asciiz "\nQuociente: "
out_str_B: .asciiz "\nResto: "
out_error: .asciiz "\nNao e possivel dvidir por 0\n"
    
 .text
    
main:                                             # o programa
    # inicio do programa
    li		$v0, 4		                  # carrega o syscall print em $v0
    la		$a0, greet_str                    # carrega 'greet_str' em $a0
    syscall				          # executa
    
    li		$v0, 4		                  # carrega o syscall print em $v0
    la		$a0, input_str                    # carrega 'input_str' em $a0
    syscall				          # executa

    # leitura do primeiro inteiro
    li      $v0, 5                                # carrega o syscall read_int em $v0
    syscall                                       # faz a chamada de sistema
    move    $t0, $v0                              # transfere o valor lido para o registrador $t0
    
    # leitura do segundo inteiro
    li      $v0, 5                                # carrega o syscall read_int em $v0
    syscall                                       # faz a chamada de sistema
    move    $t1, $v0                              # transfere o valor lido para o registrador $t1
    
    # processo da divisao
    beqz    $t1, erro                             # se o divisor for 0, exibir msg de erro do programa
    div	    $t0, $t1			          # divide $t0 por $t1
    mflo    $t2					  # registrador que contem o quociente 
    mfhi    $t3					  # registrador que contem o resto 
    
    # imprimindo os resultados
    
        #imprimindo o quociente
    li		$v0, 4		                  # carrega o syscall print em $v0
    la		$a0, out_str_A                    # carrega 'out_str_A' em $a0
    syscall				          # executa
    
    li		$v0, 1		                  # carrega o syscall print em $v0
    move	$a0, $t2                          # carrega $t2 em $a0
    syscall				          # executa 
        #imprimindo o resto
    li		$v0, 4		                  # carrega o syscall print em $v0
    la		$a0, out_str_B                    # carrega 'out_str_A' em $a0
    syscall				          # executa
    
    li		$v0, 1		                  # carrega o syscall print em $v0
    move	$a0, $t3                          # carrega $t3 em $a0
    syscall				          # executa 
    
 erro:    			                  # menssagem de erro para denominador = 0
    li $v0, 4
    la $a0, out_error
    syscall