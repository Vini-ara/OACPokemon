.text 
# MOVE
#   -Movimenta o persogem pelo mapa
#     -argumentos:
#        >a0 = linha atual
#        >a1 = coluna atual
#        >a3 = tecla pressionada

MOVE:
	addi sp, sp, -20
	sw ra, 16(sp)
	sw t3, 12(sp)
	sw t2, 8(sp)
	sw t1, 4(sp)
	sw t0, 0(sp)

	mv t0, a0
	mv t1, a1

  li t2,'w'
	beq a3,t2,MOVE_CIMA
	li t2,'a'
	beq a3,t2,MOVE_ESQ
	li t2,'s'
	beq a3,t2,MOVE_BAIXO
	li t2,'d'
	beq a3,t2,MOVE_DIR
	ret
	
VOLTA_MOVE:	
  	mv a0, t0
  	mv a1, t1
	jal ra, TILE_ANDAVEL

	beqz a0,FIM_MOVE

	mv s1,t0
	mv s2,t1

FIM_MOVE:
	lw t0, 0(sp)
	lw t1, 4(sp)
	lw t2, 8(sp)
	lw t3, 12(sp)
	lw ra, 16(sp)
	addi sp, sp, 20

	ret
	
MOVE_CIMA:
	li t3, 0 # direçao para cima
	bne s3, t3, MUDA_DIRECAO_CIMA # checa se a direcao ja esta certa. se nao so muda a direçao

	beqz t0,FIM_MOVE # se estiver na primeira linha nao pode subir mais
	addi t0,t0,-1

MUDA_DIRECAO_CIMA:
	li s3, 0
	jal zero, VOLTA_MOVE
	
MOVE_ESQ:
	li t3, 3 # direçao esquerda
	bne s3, t3, MUDA_DIRECAO_ESQ

	beqz t1,FIM_MOVE
	addi t1,t1,-1
	jal zero, VOLTA_MOVE

MUDA_DIRECAO_ESQ:
	li s3, 3
	jal zero, VOLTA_MOVE
	
MOVE_BAIXO:
	li t3, 1 # direçao baixo
	bne s3, t3, MUDA_DIRECAO_BAIXO

	la t2,MAPA
	lw t2,4(t2)
	beq t0,t2,FIM_MOVE
	addi t0,t0,1

MUDA_DIRECAO_BAIXO:
	li s3, 1
	jal zero, VOLTA_MOVE
	
MOVE_DIR:
	li t3, 2 # direçao baixo
	bne s3, t3, MUDA_DIRECAO_DIR

	la t2,MAPA
	lw t2,0(t2)
	beq t2,t1,FIM_MOVE
	addi t1,t1,1

MUDA_DIRECAO_DIR:
	li s3, 2
	jal zero, VOLTA_MOVE


# TILE_ANDAVEL
#   - checa se o tile eh andavel
#   Parametros:
#     > a0 = linha
#     > a1 = coluna
#   Retorno: 
#     > a0 = andavel ? 1 : 0
TILE_ANDAVEL:
	addi sp,sp,-16
	sw ra,12(sp)
  sw t2,8(sp)
	sw t1,4(sp)
	sw t0,0(sp)

	mv t0,a0
	mv t1,a1

	la a0,MAPA
	mv a1,t0
	mv a2,t1
	li a3,1
	jal ra, AJUSTA_XY

	lbu t0,0(a0) # t0 = codigo do objeto
	la t2,OBJETOS
	
	addi t1,zero,T_OBJ
	mul t1,t1,t0 #quantidade de bytes que serao adicionados ao endereco objetos
	add t1,t2,t1 #t1 recebe o endereco do objeto requisitado
	lw t1,0(t1) # t1 recebe o endereco do objeto
  lb a0, 4(t1) # a0 recebe se o tile e andavel ou nao

	lw t0,0(sp)
	lw t1,4(sp)
  lw t2,8(sp)
	lw ra,12(sp)
	addi sp,sp,16

	ret

# retorna em a0 a tecla pressionada
KEY2:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
  beq t0,zero,FIM  	   	# Se não há tecla pressionada então vai para FIM
  lw a0,4(t1)  			# le o valor da tecla tecla
FIM:	ret				# retorna
