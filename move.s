.text 
#Movimenta o persogem pelo mapa
#argumentos:
# a0 = linha atual
# a1 = coluna atual
# a3 = tecla pressionada
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

# TILE_ANDAVEL
#   - checa se o tile eh andavel
#   Parametros:
#     > a0 = linha
#     > a1 = coluna
#   Retorno: 
#     > a0 = andavel ? 1 : 0
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
