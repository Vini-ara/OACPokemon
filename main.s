.eqv T_OBJ 8 #tamanho de cada objeto
.data
.include "mapa.data"
.include "mapa2.data"
.include "imagens/house0.data"

.text
#iniciando mapa
SETUP:	
  call inicia_objetos

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

# -CARREGA_MAPA
#   Apenas printa o mapa
#     Parametros: 
#     > ao = linha do jogador
#     > a1 = coluna do jogador
CARREGA_MAPA:
	mv t0,a1 # t0 = coluna do jogador

	addi a1,a0,-7 #ajusta a0(linha) para a primeira linha do display   
	addi a2,t0,-10 # ajusta a1(coluna) para a primeira coluna do display
	la a0,mapa2 # endereco da matriz do mapa
	li a3,1 # offset da funcao AJUSTA_XY

	addi sp,sp,-4
	sw ra,0(sp)
	call AJUSTA_XY # retorna o endereco do mapa para printar somente a parte em que o jogador esta
	lw ra,0(sp)
	addi sp,sp,4

	mv a2,a0  
	li a0,0 #a0 = contador coluna
	li a1,0 #a1 = contador linha
	la a3,OBJETOS #a3 = comecco do vetor objetos

LOOP_CARREGA_MAPA:
	lb t0,0(a2) # recebe o byte da matriz do mapa
	addi t1,zero,T_OBJ # tamanho de cada objeto(VAI MUDAR)
	mul t1,t1,t0 # quantidade de bytes que serao adicionados ao endereco objetos
	add t1,a3,t1 # t1 recebe o endereco do objeto requisitado
	lw t0,0(t1) # t0 recebe o endereco do sprite do objeto

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
	la t0,mapa2
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
	
	la a0,house0 #suposto personagem
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
	
# --- AJUSTA_XY 
#  - Retorna o endereco de um objeto em um .data, dadas suas coordenadas
#     Parametros:
#     > a0 = endereco .data
#     > a1 = linha 
#     > a2 = coluna
#     > a3 = tamanho do conteudo(4 = word, 1 = byte ...)
#     Retorno: 
#     > a0 = endereco do .data em que o objeto esta
AJUSTA_XY:
	lw t0,0(a0) #t0 = tamanho X do .data

	mul t1,t0,a1 #t1 = t0 (largura do .data) * a2 (linha)
	mul t1,t1,a3 #t1 = t1 * a3 (offset/tamanho do passo que eu tenho que dar)

	mul t2,a3,a2 #t2 = a3 * a2 (coluna em que meu ojeto esta)

	add a0,a0,t1 #a0 = a0 (endereco do .data) + t1 (o Y do meu objeto)
	add a0,a0,t2 #a0 = a0 + t2 (o X do meu objeto)

	addi a0,a0,8 #corrige um offset, mas isso n era p estar aqui (n tem relacao direta com a funcao)!!
	
	ret

.include "print.s"
.include "objetos.s"
.include "move.s"
