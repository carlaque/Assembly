.data
	msgInserir:   .asciiz"\n\n Digite um numero octal entre 1 e 10000: "
	msgResultado: .asciiz"\n O Equivalente Decimal deste numero eh: "
	msgErrado: .asciiz"\n Numero invalido \n"
	
.text
main:

	#mostra msg  de inserção
	li $v0, 4 
	la $a0 , msgInserir
	syscall
	
	#ler variavel 
	li $v0, 5 
	syscall 
	add $t0, $v0,   $zero 			#colocando o numero digitado no t0 
	
	add $t1, $t0,   $zero 
	add $t2, $zero, $zero 			#contator
	
	bge $t0, 0, SE
	j invalido
	SE: 
		ble $t0, 10000, Valido
		j invalido
		Valido:
			
		enquanto:
			add $t3, $t2,   $zero 		#contator da potencia 
			add $t4, $zero, 1   		#armaneza a potencia de 8
			rem $t6, $t1, 10
			
			bgt $t6, 7, invalido		#verifica se o numeral eh maior que 7 por ser octal 
			
			bgt $t3, $zero, potencia 	#verifica executa ou nao a potencia de oito
			
			j pula
			
			potencia:
				mul $t4, $t4, 8
				sub $t3, $t3, 1
			bgt $t3, $zero, potencia 
			
			pula:
			
			mul $t5, $t6, $t4 			#t5 = numero em octal * potencia de oito [t5==decimal]
			add $t7, $t7, $t5			#soma dos numerais do octal ja mul pela potencia de oito
		
			div $t1, $t1, 10
			add $t2, $t2, 1				#contador t2++
		bne $t2, 4, enquanto
		
		#escrever numero decimal 
		li $v0, 4
		la $a0, msgResultado
		syscall
		
		#mostra decimal
		li $v0 , 1
		add $a0 , $t7, $zero
		syscall
	
	j fim
	invalido:
		#mostra msg de erro
		li $v0, 4 
		la $a0 , msgErrado
		syscall
	fim:
		add $t0, $zero, $zero
		add $t1, $zero, $zero
		add $t2, $zero, $zero
		add $t3, $zero, $zero
		add $t4, $zero, $zero
		add $t5, $zero, $zero
		add $t6, $zero, $zero
		add $t7, $zero, $zero
		
		j main