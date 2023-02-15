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
	jal ra, CHECK_TILE

  # checa se nao pode se mover na tile
	beqz a0,FIM_MOVE

  # checa se mudou de mapa
  	bne a1, zero, FIM_MOVE

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

	la t3,CURRENT_MAP
  	lw t2, 0(t3)
	lw t2,4(t2)
	beq t0,t2,FIM_MOVE
	addi t0,t0,1

MUDA_DIRECAO_BAIXO:
	li s3, 1
	jal zero, VOLTA_MOVE
	
MOVE_DIR:
	li t3, 2 # direçao baixo
	bne s3, t3, MUDA_DIRECAO_DIR

	la t3,CURRENT_MAP
  	lw t2, 0(t3)
	la t2,MAPA
	lw t2,0(t2)
	beq t2,t1,FIM_MOVE
	addi t1,t1,1

MUDA_DIRECAO_DIR:
	li s3, 2
	jal zero, VOLTA_MOVE


# CHECK_TILE
#   - checa se o tile eh andavel
#   Parametros
#     > a0 = linha
#     > a1 = coluna
#   Retorno: 
#     > a0 = andavel ? 1 : 0
#     > a1 = mudou o mapa ? 1 : 0
CHECK_TILE:
	addi sp,sp,-16
	sw ra,12(sp)
  	sw t2,8(sp)
	sw t1,4(sp)
	sw t0,0(sp)

	mv t0,a0
	mv t1,a1
  
  	la t2, CURRENT_MAP
	lw a0,0(t2)
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
	lb t0, 6(t1) # t0 recebe se o tile tem alguma acao

	# muda de mapa
	li t2, 1
	beq t0, t2, CHECK_TILE.CHANGE

	# se for uma grama alta, verifica se vai batalhar ou nao
	li t2, 2
	beq t0, t2, CHECK_TILE.SET_BATTLE

	li t2, 4
	beq t0, t2, CHECK_TILE.VALID_PASSE

	li a1, 0
	j CHECK_TILE.FIM

  # muda de mapa para o mapa da tile
  CHECK_TILE.CHANGE:
    lw a0, 8(t1)
    jal CHANGE_MAP

    li a0, 1
    li a1, 1

    j CHECK_TILE.FIM

  CHECK_TILE.VALID_PASSE:
	jal CHECK_PASSE

	li a1, 0
	beqz a0, CHECK_TILE.FIM

	lw a0, 8(t1)
    jal CHANGE_MAP

    li a0, 1
    li a1, 1

    j CHECK_TILE.FIM

  # gera um numero aleatorio e ve se o pokemon vai batalhar ou nao
  CHECK_TILE.SET_BATTLE:
	la t0, P_PLAYER
	lw t0, 0(t0)

	li a0, 1
    li a1, 0
	beqz t0, CHECK_TILE.FIM

    la t0, WILL_BATTLE

    jal RANDOM_SAVE

    li t1, 7
    and t1, t1, a0

    li a0, 1
    li a1, 0
    beqz t1, CHECK_TILE.CONFIRM_BATTLE

    jal CHECK_TILE.FIM

    # salva 1 em WILL_BATTLE, o que vai gerar uma batalha no fim do loop
    CHECK_TILE.CONFIRM_BATTLE:
      li t1, 1 
      sb t1, 0(t0)

CHECK_TILE.FIM:
	lw t0,0(sp)
	lw t1,4(sp)
  	lw t2,8(sp)
	lw ra,12(sp)
	addi sp,sp,16
	ret

# CHANGE_MAP
#   -- muda o CURRENT_MAP para o novo mapa passado, mundando tambem as coordenadas do player para o
#   comeco desse mapa
#   > a0 = objeto do novo mapa

CHANGE_MAP:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw t2, 8(sp)
	sw t1, 4(sp)
	sw t0, 0(sp)

  la t0, CURRENT_MAP
  lw t1, 0(a0)
  sw t1, 0(t0)

  la t0, MAPA
  beq t0, t1, CHANGE_MAP.FIM  

  la t0, MAPA_OBJ
  sb s1, 4(t0)
  sb s2, 5(t0)

  CHANGE_MAP.FIM:
    lb s1, 4(a0)
    lb s2, 5(a0)
  
    lw t0,0(sp)
    lw t1,4(sp)
    lw t2,8(sp)
    lw ra,12(sp)
    addi sp,sp,16

    ret

# retorna se o jogador tem ou nao o passe e caso nao tenha printa a fala
# retorna > a0 = 1 ou 0
CHECK_PASSE:
	addi sp, sp, -8
	sw ra, 0(sp)
	sw t0, 4(sp)

	la t0, passe
	lb t0, 0(t0)

	li a0, 1
	bne t0, zero, CHECK_PASSE.FIM

	xori s0, s0, 1

	la a0, GIN0
	mv a1, s0
	la a2, GIN2 
	jal PRINT_TEXT_BOX

	li a0, 0

	CHECK_PASSE.FIM:
	lw t0, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, 8
	ret



# retorna em a0 a tecla pressionada
KEY2:	
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)

    li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			    # Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
    beq t0,zero,FIM  	   	# Se não há tecla pressionada então vai para FIM
    lw a0,4(t1)  			# le o valor da tecla tecla
FIM:	
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 8
    ret				    # retorna
