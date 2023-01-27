.eqv T_OBJ 4 #tamanho de cada objeto
.data
.include "objetos.s"
.include "mapas/mapa.s"

.text
#iniciando mapa
SETUP:	
  	li s0, 0 # frame
	li s1,31 #linha
	li s2,30 #coluna
	li s3, 0 #direçao (0 = cima, 1 = baixo, 2 = direita, 3 = esquerda)
	
GAME_LOOP:
	xori s0, s0, 1

	li a0,0
	call KEY2

	beqz a0,GAME_PRINT

	mv a3,a0 #a3 = tecla
	mv a0,s1 #linha
	mv a1,s2 #coluna
	jal MOVE

GAME_PRINT:
	mv a0,s1
	mv a1,s2
	jal ra, CARREGA_MAPA

	jal PRINT_PLAYER

  jal PRINT_TEXT_BOX

  li t0, 0xFF200604 # troca o frame exibido para o frame qeu acabou de ser pintado 
  sb s0, 0(t0)

  li a0, 70
  li a7, 32
  ecall       # espera 70ms entre cada frame

	jal GAME_LOOP




.include "draw.s"
.include "print.s"
.include "print_player.s"
.include "move.s"
