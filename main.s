.eqv T_OBJ 4 #tamanho de cada objeto
.data
.include "objetos.s"
.include "mapas/mapa.data"
.include "mapas/mapa2.data"

.text
#iniciando mapa
SETUP:	
	li s0,30 #linha
	li s1,30 #coluna

  li s2, 0 # frame
	
GAME_LOOP:
  xori s2, s2, 1

	li a0,0
	call KEY2

	beqz a0,GAME_PRINT

	mv a3,a0 #a3 = tecla
	mv a0,s0 #linha
	mv a1,s1 #coluna
	jal MOVE

GAME_PRINT:
	mv a0,s0
	mv a1,s1
	jal ra, CARREGA_MAPA

	la a0,hero0 #suposto personagem
	li a1,160
	li a2,112 ### (TO DO) Desse jeito ele comeca a ser printado pela cabeca nessa posicao, mas essa eh a posicao do pe dele
	mv a3, s2
	jal ra, DRAW_IMAGE

  li t0, 0xFF200604 # troca o frame exibido para o frame qeu acabou de ser pintado 
  sb s2, 0(t0)

  li a0, 70
  li a7, 32
  ecall       # espera 70ms entre cada frame

	jal GAME_LOOP

# -CARREGA_MAPA
#   Apenas printa o mapa
#     Parametros: 
#     > ao = linha do jogador
#     > a1 = coluna do jogador
CARREGA_MAPA:
  addi sp, sp, -28
  sw ra, 24(sp)
  sw t5, 20(sp)
  sw t4, 16(sp)
  sw t3, 12(sp)
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw t0, 0(sp)

	mv t0,a1 # t0 = coluna do jogador

	addi a1,a0,-7 #ajusta a0(linha) para a primeira linha do display   
	addi a2,t0,-10 # ajusta a1(coluna) para a primeira coluna do display
	la a0,mapa2 # endereco da matriz do mapa
	li a3,1 # .data do mapa em byte

	jal AJUSTA_XY # retorna o endereco do mapa para printar somente a parte em que o jogador esta

	li t0,0 #a0 = contador coluna
	li t1,0 #a1 = contador linha
	mv t2,a0  #t2 = endereco do .data
	la t3,OBJETOS #a3 = comecco do vetor objetos

LOOP_CARREGA_MAPA:
	lb t4,0(t2) # t4 recebe o byte da matriz do mapa (indice)
	addi t5,zero,T_OBJ # t5 = tamanho de cada objeto(VAI MUDAR)
	mul t5,t5,t4 # quantidade de bytes que serao adicionados ao endereco objetos
	add t5,t3,t5 # t5 recebe o endereco do objeto requisitado
	lw t4,0(t5) # t4 recebe o endereco do objeto daquele tile
  lw t4, 0(t4) # t4 receve o endereco do sprite daquele tile
	
	#ajustando argumentos para funcao print
	mv a0,t4 #a0 = endereco do sprite
	li t5, 16
	mul a1,t5,t0 #a1 = coluna
	mul a2,t5,t1 #a2 = linha
	mv a3, s2
	jal DRAW_IMAGE
	
	li t5,20     # tamanho da tela 
	addi t2,t2,1 # incrementa endereco do mapa
	addi t0,t0,1 # adiciona 1 ao contador coluna
	blt t0,t5,LOOP_CARREGA_MAPA # verifica se acabaram as colunas

	la t5,mapa2 
	lw t5,0(t5) # largura do mapa
	addi t2,t2,-20 
	add t2,t2,t5 # vai para a proxima linha

	li t0,0 # reinicia o contador de colunas
	addi t1,t1,1  # incrementa o contador de linhas
	li t5,15 
	blt t1,t5,LOOP_CARREGA_MAPA # verifica se acabaram as linhas
	
  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw t3, 12(sp)
  lw t4, 16(sp)
  lw t5, 20(sp)
  lw ra, 24(sp)
  addi sp, sp, 28

	ret

#retorna em a0 a tecla usada	
KEY2:	li t1,0xFF200000		# carrega o endere??o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
  beq t0,zero,FIM   	   	# Se n??o h?? tecla pressionada ent??o vai para FIM
  lw a0,4(t1)  			# le o valor da tecla tecla
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
  addi sp, sp, -16
  sw ra, 12(sp)
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw t0, 0(sp)

	lw t0,0(a0) #t0 = tamanho X do .data

	mul t1,t0,a1 #t1 = t0 (largura do .data) * a2 (linha)
	mul t1,t1,a3 #t1 = t1 * a3 (offset/tamanho do passo que eu tenho que dar)

	mul t2,a3,a2 #t2 = a3 * a2 (coluna em que meu ojeto esta)

	add a0,a0,t1 #a0 = a0 (endereco do .data) + t1 (o Y do meu objeto)
	add a0,a0,t2 #a0 = a0 + t2 (o X do meu objeto)

	addi a0,a0,8 #corrige as duas words do tamanho do .data

  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw ra, 12(sp)
  addi sp, sp, 16
	
	ret


.include "print.s"
.include "move.s"
