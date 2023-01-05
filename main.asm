.eqv T_OBJ 8
.data
.include "mapa.data"
.include "imagens/house0.data"


.text

#iniciando mapa
SETUP:	call inicia_objetos
	li s0,30 #linha
	li s1,30 #coluna
	mv a0,s0
	mv a1,s1
	call CARREGA_MAPA
	
GAME_LOOP:
	li a0,0
	call KEY2
	beqz a0,GAME_LOOP
	mv a3,a0 #a3 = tecla
	mv a0,s0 #linha
	mv a1,s1 #coluna
	jal ra,MOVE
	jal zero,GAME_LOOP
	
	
	

	
	
	
	



#recebe a0 e a1
#a0 = linha do jogador, a1 = coluna do jogador
#apenas printa o mapa
CARREGA_MAPA:
	mv t0,a1
	addi a1,a0,-7 #ajusta a0(linha) para a primeira linha do display   
	la a0,mapa
	addi a2,t0,-10 # ajusta a1(coluna) para a primeira coluna do display
	li a3,1
	addi sp,sp,-4
	sw ra,0(sp)
	call AJUSTA_XY
	lw ra,0(sp)
	addi sp,sp,4
	mv a2,a0
	li a0,0 #a0 = contador coluna
	li a1,0 #a1 = contador linha
	la a3,OBJETOS #a3 = comecco do vetor objetos
LOOP_CARREGA_MAPA:
	lb t0,0(a2) #recebe o byte da matriz do mapa
	addi t1,zero,T_OBJ # tamanho de cada objeto(VAI MUDAR)
	mul t1,t1,t0 #quantidade de bytes que serao adicionados ao endereco objetos
	add t1,a3,t1 #t1 recebe o endereco do objeto requisitado
	lw t0,0(t1) #t0 recebe o endereco do sprite do objeto
	#aqui é colocado os argumentos e ra na pilha
	addi sp,sp,-20
	sw ra,16(sp)
	sw a0,12(sp)
	sw a1,8(sp)
	sw a2,4(sp)
	sw a3,0(sp)
	#ajustando argumentos para funcao print
	li t2, 16
	mv t3,a1
	mul a1,t2,a0 #a1 = coluna
	mul a2,t2,t3 #a2 = linha
	mv a0,t0 #a0 = endereco do sprite
	li a3,0
	call DRAW_IMAGE
	lw a3,0(sp)
	lw a2,4(sp)
	lw a1,8(sp)
	lw a0,12(sp)
	lw ra,16(sp)
	addi sp,sp,20
	


	li t0,20
	addi a2,a2,1
	addi a0,a0,1 #adiciona 1 ao contador coluna
	blt a0,t0,LOOP_CARREGA_MAPA
	la t0,mapa
	lw t0,0(t0)
	addi a2,a2,-20
	add a2,a2,t0
	li a0,0
	addi a1,a1,1
	li t0,15
	blt a1,t0,LOOP_CARREGA_MAPA
	
	addi sp,sp,-20
	sw ra,16(sp)
	sw a0,12(sp)
	sw a1,8(sp)
	sw a2,4(sp)
	sw a3,0(sp)
	
	la a0,house0
	li a1,160
	li a2,112
	li a3,0
	call DRAW_IMAGE
	lw a3,0(sp)
	lw a2,4(sp)
	lw a1,8(sp)
	lw a0,12(sp)
	lw ra,16(sp)
	addi sp,sp,20
	
	ret

#retorna em a0 a tecla usada	
KEY2:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se não há tecla pressionada então vai para FIM
  	lw a0,4(t1)  			# le o valor da tecla tecla
	#sw t2,12(t1)  			# escreve a tecla pressionada no display
FIM:	ret				# retorna
	
MOVE:
	li t0,'w'
	beq a3,t0,MOVE_CIMA
	li t0,'a'
	beq a3,t0,MOVE_ESQ
	li t0,'s'
	beq a3,t0,MOVE_BAIXO
	li t0,'d'
	beq a3,t0,MOVE_DIR
	ret
	
	
VOLTA_MOVE:	
	addi sp,sp,-12
	sw ra,8(sp)
	sw a1,4(sp)
	sw a0,0(sp)
	call TILE_ANDAVEL
	mv t0,a0
	lw a0,0(sp)
	lw a1,4(sp)
	lw ra,8(sp)
	addi sp,sp,12
	beqz t0,FIM_MOVE
	mv s0,a0
	mv s1,a1
	addi sp,sp,-4
	sw ra,0(sp)
	call CARREGA_MAPA
	lw ra,0(sp)
	addi sp,sp,4
	
	
	
FIM_MOVE:
	ret
	
MOVE_CIMA:
	beqz a0,FIM_MOVE
	addi a0,a0,-1
	j VOLTA_MOVE
	
MOVE_ESQ:
	beqz a1,FIM_MOVE
	addi a1,a1,-1
	j VOLTA_MOVE
	
MOVE_BAIXO:
	la t0,mapa
	lw t0,4(t0)
	beq a0,t0,FIM_MOVE
	addi a0,a0,1
	j VOLTA_MOVE
	
MOVE_DIR:
	la t0,mapa
	lw t0,0(t0)
	beq t0,a1,FIM_MOVE
	addi a1,a1,1
	j VOLTA_MOVE

	
	

#recebe a0 = linha, a1 = coluna
#caso não seja andavel retona 0 em a0	
TILE_ANDAVEL:
	mv t0,a0
	mv t1,a1
	la a0,mapa
	mv a1,t0
	mv a2,t1
	li a3,1
	addi sp,sp,-4
	sw ra,0(sp)
	call AJUSTA_XY
	lw ra,0(sp)
	addi sp,sp,4
	lb t0,0(a0) # t0 = codigo do objeto
	la t2,OBJETOS
	
	addi t1,zero,T_OBJ # tamanho de cada objeto(VAI MUDAR)
	mul t1,t1,t0 #quantidade de bytes que serao adicionados ao endereco objetos
	add t1,t2,t1 #t1 recebe o endereco do objeto requisitado
	lw a0,4(t1)
	ret
	
#a0 = endereco data, a1 = linha, a2 = coluna, a3 = tamanho do conteudo(4 = word, 1 = byte ...)
#retorno : a0 = posicao x,y
AJUSTA_XY:
	lw t0,0(a0)
	mul t1,t0,a1
	mul t1,t1,a3
	mul t2,a3,a2
	add a0,a0,t1
	add a0,a0,t2
	addi a0,a0,8
	
	ret
	

		
	
		
				
	
	
	
	
	
	
	
	
	
	
	















.include "print.s"
.include "objetos.asm"



