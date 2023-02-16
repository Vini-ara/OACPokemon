.eqv T_OBJ 4 #tamanho de cada objeto
.data
.include "../data_files/dialog_box_battle.data"
.include "../data_files/battle_pokemon_stats.data"
.include "../data_files/options_battle.data"
.include "../data_files/pokemon_attacks_menu_bg.data"
.include "../data_files/lamar.data"
.include "objetos.s"
.include "../mapas/mapa.s"
.include "falas.s"

# BAG (Armazena os itens do jogador)
player_bag: .word I_POTION, 5

CURRENT_MAP: .word MAPA

LAB_OBJ: .word LAB
         .byte 10, 13

PKCTR_OBJ: .word PKCTR
           .byte 9, 13 

MAPA_OBJ: .word MAPA 
          .byte 23, 21

MALL_OBJ: .word LOJA
          .byte 9, 12

GYM_OBJ: .word GYM
         .byte 9, 12

WILL_BATTLE: .byte 0

# STRINGS
barra:  .string "/"
seta:   .string ">"
traco:  .string "-"
x:		.string "x"

# DI�?LOGOS DA BATALHA
dead_battle:        .string "O pokemon inimigo morreu!"
xp_battle1:         .string "O seu pokemon adquiriu"
xp_battle2:         .string "pontos de xp."
lvl_up_battle:      .string "O seu pokemon evoluiu para o level"
attack_battle:      .string "atacou com"
atk_down_battle:    .string "teve o ataque diminuido!"
use_potion_dial:	.string "O jogador utilizou uma marmita."
defeat:				.string "Todos os seus pokemons foram derrotados em batalha!"
revive_poke:		.string "Visite a curandeira para reviver seus pokemons."
dead:				.string "morreu!"
str_run:			.string "Voce fugiu com sucesso!"
covarde:			.string "Covarde kkkkkk"		

# POKEMON INIMIGO
P_INIMIGO: .word 0, 0, 0

# POKÉMON INICIAL DO JOGADOR
P_PLAYER: .word 0, 0, 0

# Dinheiro
creditos: .byte 200

# Diálogo do líder de ginásio
fala1:      .string "Calouro, chegou o momento de testar suas habilidades!"
fala2:      .string "Perca e seja reprovado,"
fala3:      .string "ou ganhe e passe com SS."
fuga:       .string "Nao tente fugir, covarde!"
fala4:      .string "Parabens, Calouro! Tome seu SS!"
fala5:  	.string "O inimigo utilizou uma potion."
turnos:     .byte 0
pot_usada:  .byte 0
sim:			.string "Sim"
nao:			.string "Nao"
menu_lvl: 		.string "Lvl."
menu_exp: 		.string "Exp."
menu_dinheiro:	.string "Dinheiro $"
menu_cura: 		.string "Cura"
menu_passe: 	.string "Passe"

passe: .byte 0

.text
.include "./libs/MACROSv21.s"

#iniciando mapa
SETUP:	
  	li s0, 0 # frame
    li s1,25 #linha
    li s2,19 #coluna

    li s3, 0 #direçao (0 = cima, 1 = baixo, 2 = direita, 3 = esquerda)
  	li t0, 0xFF200604 # troca o frame exibido para o frame qeu acabou de ser pintado 

    sb s0, 0(t0)
  	jal INTRODUCTION
    xori s0, s0, 1	
    
GAME_LOOP:
	xori s0, s0, 1

	li a0,0
	jal KEY2

	beqz a0, GAME_PRINT

	li t0, 'z'
	beq a0, t0, INTERACTION

	li t0, '1'
	beq a0, t0, Use_Cheat1

	li t0, '2'
	beq a0, t0, Use_Cheat2

	li t0, 'm'
	beq a0, t0, PAUSE

	mv a3,a0 #a3 = tecla
	mv a0,s1 #linha
	mv a1,s2 #coluna
	jal MOVE

	j GAME_PRINT

PAUSE:
	jal MENU

GAME_PRINT:
 	mv a0,s1
	mv a1,s2
	jal ra, CARREGA_MAPA

  jal PRINT_PLAYER

  j GAME_LOOP.END

Use_Cheat1:
	jal CHEAT_ADD_MONEY
	j GAME_LOOP.END

Use_Cheat2:
	jal CHEAT_LEVEL_UP
	j GAME_LOOP.END

INTERACTION:
	mv a0, s1
	mv a1, s2
	mv a2, s3
	jal CHECK_DIALOG

GAME_LOOP.END:
	jal CHECK_BATTLE

	la t0, WILL_BATTLE
	li t1, 0
	sb t1, 0(t0)

	jal TOCA_MUSICA

	li t0, 0xFF200604 # troca o frame exibido para o frame qeu acabou de ser pintado 
	sb s0, 0(t0)

	#li a0, 70
	#li a7, 32
	#ecall       # espera 70ms entre cada frame

	j GAME_LOOP
	
.include "intro.s"
.include "musica.s"
.include "menu.s"

.include "npc/curandeira.s"
.include "npc/vendedora.s"
.include "npc/professor.s"

.include "./libs/SYSTEMv21.s"
.include "print.s"
.include "check_interaction.s"

.include "battle/gym_battle.s"
.include "battle/battle.s"
.include "battle/pokemons.s"
.include "battle/ataques.s"
.include "battle/draw_battle_screen.s"
.include "battle/create_pokemon.s"
.include "battle/draw_pokemon.s"
.include "battle/draw_enemy_pokemon.s"
.include "battle/draw_player_pokemon.s"

.include "midisave.s"
.include "init_pokemon_inicial.s"
.include "sleep.s"
.include "print_save.s"
.include "dialog.s"
.include "move.s"
.include "print_player.s"
.include "draw.s"
.include "print_text_box.s"
.include "random_save.s"
.include "check_battle.s"
.include "items.s"
.include "end_game.s"
.include "cheats.s"
