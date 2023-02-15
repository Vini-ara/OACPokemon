.data
# NOMES DOS ATAQUES
n_fire_ball:    .string "Revoada"
n_bubble:       .string "Dentada"
n_vine_whip:    .string "Patada"
n_slap:         .string "Tapasso"
n_nap:          .string "Cochilo"
n_look:         .string "Olhada"
n_stoned:       .string "Teniase"
n_prego:        .string "Prego"
n_capote:       .string "Capote"
lista_n_ataques: .word n_fire_ball, n_bubble, n_vine_whip, n_slap, n_nap, n_look, n_stoned, n_prego, n_capote

# LEGENDA DE TIPOS
# 0 --> �?GUA
# 1 --> GRAMA
# 2 --> FOGO
# 3 --> NORMAL
# 4 --> PEDRA


# ATAQUES DOS POKEMON
#   - 0xITPP
#       > I: 1 dígito simbolizando o index na lista de nomes dos ataques
#       > T: 1 dígitos simbolizando o tipo do ataque
#       > PP: 2 dígitos simbolizando o poder do ataque

#   - FIRE_BALL:
#       > Index: 0
#       > Tipo: fogo
#       > Poder: 40
FIRE_BALL: .half 0x0228

#   - BUBBLE:
#       > Index: 1
#       > Tipo: água
#       > Poder: 40
BUBBLE: .half 0x1028 

#   - VINE_WHIP:
#       > Index: 2
#       > Tipo: grama
#       > Poder: 40
VINE_WHIP: .half 0x2128

#   - SLAP:
#       > Index: 3
#       > Tipo: normal
#       > Poder: 40
SLAP: .half 0x3328

#   - NAP:
#       > Index: 4
#       > Tipo: normal
#       > Poder: 5
NAP: .half 0x4305

#   - LOOK:
#       > Index: 5
#       > Tipo: normal
#       > Poder: 0
LOOK: .half 0x5300

#   - LOOK:
#       > Index: 6
#       > Tipo: pedra
#       > Poder: 40
STONED: .half 0x6428

#   - Prego
#       > Index: 7
#       > Tipo: normal
#       > Poder: 0
PREGO: .half 0x7300

#   - Capote
#       > Index: 8
#       > Tipo: venenoso
#       > Poder: 40
CAPOTE: .half 0x8428

.align 2
#                    0x01       0x11    0x21       0x31  0x41 0x51  0x61    0x71    0x81
lista_ataques: .word FIRE_BALL, BUBBLE, VINE_WHIP, SLAP, NAP, LOOK, STONED, PREGO, CAPOTE
.text

# DAMAGE_ATTACK:
#   - Performa um ataque que causa dano em um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do ataque
#       > a1 ---> Endereço do pokémon atacante
#       > a2 ---> Endereço do pokémon defensor
DAMAGE_ATTACK:
    # Store na pilha
    addi sp, sp, -24
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)

    mv t0, a0                       # t0 = endereço do ataque
    mv t1, a1                       # t1 = endereço do pokémon atacante
    mv t2, a2                       # t2 = endereço do pokémon defensor
    
    # Adquirir o poder do ataque
    jal GET_ATTACK_POWER
    mv t3, a0                       # t3 = poder do ataque

    # Adquirir o tipo do ataque
    mv a0, t0
    jal GET_ATTACK_TYPE
    mv t4, a0                       # t3 = ataque do pokémon atacante 

    # Adquirir level do pokémon atacante
    mv a0, t1
    li a1, 0x02
    jal GET_POKEMON_STAT
    mv a2, a0

    # Aquirir ataque do pokémon atacante
    mv a0, t1
    li a1, 0x14
    jal GET_POKEMON_STAT
    mv a3, a0

    # Adquirir tipo do pokémon atacante
    mv a0, t1
    jal GET_ATTACK_TYPE
    mv a4, a0

    # Adquirir defesa do pokémon defensor
    mv a0, t2
    li a1, 0x00
    jal GET_POKEMON_STAT
    mv a5, a0

    # Adquirir tipo do pokémon defensor
    mv a0, t2
    jal GET_POKEMON_TYPE
    mv a6, a0

    # Mover valores
    mv a0, t3
    mv a1, t4

    # Calcular dano
    jal CALCULATE_DAMAGE
    mv t3, a0

    # Diminuir a vida do pokémon defensor
    mv a0, t2
    li a1, 0x10
    jal GET_POKEMON_STAT
    sub a2, a0, t3
    
    # Verificar se a vida do pokémon ficou negativa
    bgtz a2, Set_New_Life
    # Se sim, a2 = 0
    mv a2, zero
    
    # Setar vida do pkémon para a2
    Set_New_Life:
        mv a0, t2
        li a1, 0x10 
        jal SET_POKEMON_STAT
    
    # Load na pilha
    lw t4, 20(sp)
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 24
    ret 
#

# CALCULATE_DAMAGE
#   - Calcula e retorna o dano de um ataque
#   - Parâmetros
#       > a0 ---> Poder do ataque
#       > a1 ---> Tipo do ataque
#       > a2 ---> Level do pokémon atacante
#       > a3 ---> Ataque do pokémon atacante
#       > a4 ---> Tipo do pokémon atacante
#       > a5 ---> Defesa do pokémon defensor
#       > a6 ---> Tipo do pokémon defensor
#   - Retorno:
#       > a0 ---> Dano calculado
#   - Fórmula do dano:
#       > dano   = {[((2xlvl / 5) + 2) x Power x A/D] / 50 + 2} x Type1
#       > lvl    = level do pokémon atacante
#       > Power  = poder do ataque
#       > A      = ataque do pokémon atacante
#       > D      = defesa do pokémon defensor
#       > Type1  = 0,5 se o ataque não for eficaz, 1 se o ataque for normal, 2 se for super eficaz
CALCULATE_DAMAGE:
    # Store na pilha
    addi sp, sp, -32
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
    sw t5, 24(sp)
    sw t6, 28(sp)

    # Inicializando registradores
    mv t0, a0               
    mv t1, a1
    mv t2, a2
    mv t3, a3
    mv t4, a4
    mv t5, a5
    mv t6, a6

    # Calcular 2xlvl
    slli t2, t2, 1              # t2 = 2xt2 (2xlvl)

    # Calcular A/D
    div t3, t3, t5              # t3 = t3 / t5 (A/D)

    # Calcular 2xlvl / 5 + 2    
    li t5, 5                    # t5 = 5
    div t2, t2, t5              # t2 = t2 / t5 (2xlvl / 5)
    addi t2, t2, 2              # t2 = t2 + 2  (2xlvl / 5 + 2)

    # Calcular (2xlvl / 5 + 2) x Power x A/D
    mul t2, t2, t0              # t2 = t2 * t0 ((2xlvl / 5 + 2) x Power)
    mul t2, t2, t3              # t2 = t2 * t3 ((2xlvl / 5 + 2) x Power x A/D)
    
    # Calcular (2xlvl / 5 + 2) x Power x A/D / 50 + 2
    li t5, 50                   # t5 = 50
    div t2, t2, t5              # t2 = t2 / t5 ((2xlvl / 5 + 2) x Power x A/D / 50)
    addi t2, t2, 2              # t2 = t2 + 2  ((2xlvl / 5 + 2) x Power x A/D / 50 + 2)

    # Calcular Type1
    mv a0, a1
    mv a1, a6
    jal CALCULATE_EFFECTIVENESS
    beqz a0, Ineffective_Attack
    
    # Calular [(2xlvl / 5 + 2) x Power x A/D / 50 + 2] x Type1
    mul a0, t2, a0              # a0 = t2 * a0 ([(2xlvl / 5 + 2) x Power x A/D / 50 + 2] x Type1)
    j End_Calculate_Damage
    
    Ineffective_Attack:
        li t1, 2
        div a0, t2, t1

    End_Calculate_Damage:
    # Load na pilha
    lw t6, 28(sp)
    lw t5, 24(sp)
    lw t4, 20(sp)
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 32
    ret
#

# CALCULATE_EFFECTIVENESS
#   - Calcula e retorna a eficácia do ataque em um pokémon
#   - Parâmetros:
#       > a0 ---> Tipo do ataque
#       > a1 ---> Tipo do pokémon defensor
#   - Retorno:
#       > a0 ---> eficácia (0, se não é eficaz; 1, se a eficácia é normal; 2, se é super eficaz)
CALCULATE_EFFECTIVENESS:
    addi sp, sp, -4
    sw t0, 0(sp)
    # Verificar o tipo do ataque
    beq a0, zero, Water_Type        # Verifica se é do tipo água

    li t0, 1
    beq a0, t0, Grass_Type          # Verifica se é do tipo grama
    
    li t0, 2
    beq a0, t0, Fire_Type           # Verifica se é do tipo fogo

    li t0, 3
    beq a0, t0, Normal_Type         # Verifica se é do tipo normal

    # Se não é nenhum dos tipos acima, é do tipo pedra
    # Verificar o tipo do pokemon defensor
        # Verifica em relação ao tipo pedra
        beq a0, a1, Normal_Effective    # Verifica se é do tipo água
        
        li t0, 1
        beq a1, t0, Normal_Effective    # Verifica se é do tipo grama
        
        li t0, 2
        beq a1, t0, Super_Effective     # Verifica se é do tipo fogo

        li t0, 3
        beq a1, t0, Normal_Effective    # Verifica se é do tipo normal
        
        # Se não é nenhum dos tipos acima, é do tipo pedra
        j Normal_Effective

    Water_Type:
        mv t0, zero
        beq t0, a1, Ineffective         # Verifica se é do tipo água
        
        li t0, 1
        beq a1, t0, Ineffective         # Verifica se é do tipo grama
        
        li t0, 2
        beq a1, t0, Super_Effective     # Verifica se é do tipo fogo

        li t0, 3
        beq a1, t0, Normal_Effective    # Verifica se é do tipo normal
        
        # Se não é nenhum dos tipos acima, é do tipo pedra
        j Super_Effective

    Grass_Type:
        mv t0, zero
        beq t0, a1, Super_Effective     # Verifica se é do tipo água
        
        li t0, 1
        beq a1, t0, Ineffective         # Verifica se é do tipo grama
        
        li t0, 2
        beq a1, t0, Ineffective         # Verifica se é do tipo fogo

        li t0, 3
        beq a1, t0, Normal_Effective    # Verifica se é do tipo normal
        
        # Se não é nenhum dos tipos acima, é do tipo pedra
        j Super_Effective

    Fire_Type:
        mv t0, zero
        beq t0, a1, Ineffective         # Verifica se é do tipo água
        
        li t0, 1
        beq a1, t0, Super_Effective     # Verifica se é do tipo grama
        
        li t0, 2
        beq a1, t0, Ineffective         # Verifica se é do tipo fogo

        li t0, 3
        beq a1, t0, Normal_Effective    # Verifica se é do tipo normal
        
        # Se não é nenhum dos tipos acima, é do tipo pedra
        j Ineffective

    Normal_Type:
        mv t0, zero
        beq t0, a1, Normal_Effective    # Verifica se é do tipo água
        
        li t0, 1
        beq a1, t0, Normal_Effective    # Verifica se é do tipo grama
        
        li t0, 2
        beq a1, t0, Normal_Effective    # Verifica se é do tipo fogo

        li t0, 3
        beq a1, t0, Normal_Effective    # Verifica se é do tipo normal
        
        # Se não é nenhum dos tipos acima, é do tipo pedra
        j Ineffective

    Ineffective:
        mv a0, zero
        j End_Calculate_Effectiveness

    Normal_Effective:
        li a0, 1
        j End_Calculate_Effectiveness
        
    Super_Effective:
        li a0, 2

    End_Calculate_Effectiveness:
        lw t0, 0(sp)
        addi sp, sp, 4
        ret
#

# GET_ATTACK_POWER
#   - Retorna o poder de um ataque
#   - Parâmetros:
#       > a0 ---> Endereço do ataque
GET_ATTACK_POWER:
    # Store na pilha
    addi sp, sp, -4
    sw t0, 0(sp)
    
    # Adquirir o poder 
    lh t0, 0(a0)            # t0 = half word de stats do ataque
    andi a0, t0, 0x0FF      # a0 = t0 and 0x0FF (extrair PP)

    # Load na pilha
    lw t0, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret
#

# GET_ATTACK_TYPE
#   - Retorna o tipo de um ataque
#   - Parâmetros:
#       > a0 ---> Endereço do ataque
GET_ATTACK_TYPE:
    # Store na pilha
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    
    # Adquirir o tipo 
    lh t0, 0(a0)            # t0 = half word de stats do ataque
    li t1, 0x00000F00       # t1 = 0x00000F00
    and a0, t0, t1          # a0 = t0 and t1 (extrair T)
    srli a0, a0, 8

    # Load na pilha
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 8

    # Retornar
    ret
#

# GET_ATTACK_NAME
#   - Retorna o endereço do nome de um ataque
#   - Parâmetros:
#       > a0 ---> Endereço do ataque
GET_ATTACK_NAME:
    # Store na pilha
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    
    # Adquirir o nome 
    lh t0, 0(a0)            # t0 = half word de stats do ataque
    li t1, 0x0000F000
    and a0, t0, t1          # a0 = t0 and t1 (extrair I)
    srli a0, a0, 12

    # Calcular o endereço
    slli a0, a0, 2          # a0 = a0 * 4
    la t1, lista_n_ataques  # t1 = Endereço da lista de nomes dos ataques
    add a0, a0, t1          # t0 = t0 + t1 (Endereço do ponteiro do nome)
    lw a0, 0(a0)            # a0 = Endereço do nome

    # Load na pilha
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 8

    # Retornar
    ret
#

# DECODE_ATTACK
#   - Dado o número, retorna o endereço do ataque correspondente
#   - Parâmetros/ Retorno:
#       > a0 ---> Número
#           % a0 = 0 ---> FIRE_BALL 
#           % a0 = 1 ---> BUBBLE 
#           % a0 = 2 ---> VINE_WHIP 
#           % a0 = 3 ---> SLAP 
#           % a0 = 4 ---> NAP 
#           % a0 = 5 ---> LOOK 
#           % a0 = 6 ---> STONED
DECODE_ATTACK:
    # Store na pilha
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)

    # Adquirir o endereço do ataque
    la t0, lista_ataques
    li t1, 4
    mul t1, t1, a0
    add t0, t0, t1
    lw a0, 0(t0)
    
    # Load na pilha
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 8

    # Retornar
    ret
#

# RUN_ATTACK:
#   - Executa um ataque.
#   - Paraâmetros:
#       > a0 ---> Ataque a ser executado
#       > a1 ---> Endereço do pokémon atacante
#       > a2 ---> Endereço do pokémon defensor
RUN_ATTACK:
    # Store na pilha
    addi sp, sp, -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)

    # Inicializar registradores
    mv t0, a0
    mv t1, a1
    mv t2, a2

    # Verificar se o ataque é FIRE_BALL
    beqz a0, Run_Damage_Attack
    
    # Verificar se o ataque é BUBBLE
    li t3, 1
    beq t3, a0, Run_Damage_Attack
    
    # Verificar se o ataque é VINE_WHIP
    li t3, 2
    beq t3, a0, Run_Damage_Attack
    
    # Verificar se o ataque é SLAP
    li t3, 3
    beq t3, a0, Run_Damage_Attack

    # Verificar se o ataque é NAP
    li t3, 4
    beq t3, a0, NAP_ATTACK

    # Verificar se o ataque é LOOK
    li t3, 5
    beq t3, a0, Run_Look_Attack

    # Verificar se o ataque é STONED
    li t3, 6
    beq t3, a0, Run_Damage_Attack

    # Verificar se o ataque é o PREGO
    li t3, 7
    beq t3, a0, Run_Prego_Attack

    # Verificar se o ataque é o CAPOTE
    li t3, 8
    beq t3, a0, Run_Damage_Attack

    Run_Damage_Attack:
        jal DECODE_ATTACK
        jal DAMAGE_ATTACK
        
        # Printar mensagem de ataque            
        mv a0, t1
        mv a1, t0
        jal PRINT_DAMAGE_ATTACK
            
    j End_Run_Attack

    Run_Look_Attack:
        mv a0, t2
        jal LOOK_ATTACK
        mv a0, t1
        mv a1, t2
        mv a2, zero
        jal PRINT_LOOK_ATTACK
        j End_Run_Attack

    Run_Nap_Attack:
        jal DECODE_ATTACK
        jal NAP_ATTACK
        j End_Run_Attack

    Run_Prego_Attack:
        mv a0, t2
        jal LOOK_ATTACK
        mv a0, t1
        mv a1, t2
        li a2, 1
        jal PRINT_LOOK_ATTACK
        j End_Run_Attack

    End_Run_Attack:
        # Load na pilha
        lw t3, 16(sp)
        lw t2, 12(sp)
        lw t1, 8(sp)
        lw t0, 4(sp)
        lw ra, 0(sp)
        addi sp, sp, 20
        # Retornar
        ret
#

# PRINT_ATTACK
#   - Printa uma mensagem indicando que pokémon atacou usando o que
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
#       > a1 ---> Ataque
PRINT_DAMAGE_ATTACK:
    # Store na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1

    # Adquirir o nome do pokémon
    jal GET_POKEMON_NAME

    # Printar o nome do pokémon
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar a string attack_battle
    la a0, attack_battle
    li a1, 16
    li a2, 220
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Adquirir o nome do ataque
    mv a0, t1
    jal DECODE_ATTACK
    jal GET_ATTACK_NAME

    # Printar o nome do ataque
    li a1, 116
    li a2, 220
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG 

    # Load na pilha
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12

    # Retornar
    ret
#

# LOOK_ATTACK
#   - Promove o ataque olhada, o qual diminui o ataque do pokémon defensor em 1. 
#   - Parâmtros:
#       > a0 ---> Endereço do pokémon defensor
LOOK_ATTACK:
    # Store na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw t0, 4(sp)

    # Adquirir o ataque do pokémon defensor
    mv t0, a0
    li a1, 0x14
    jal GET_POKEMON_STAT

    # Subtrair 1 do ataque e setar novo ataque
    addi a2, a0, -1
    mv a0, t0
    li a1, 0x14
    jal SET_POKEMON_STAT

    # Load na pilha
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    
    # Retornar
    ret
#

NAP_ATTACK:
    ret
#

# PRINT_LOOK_ATTACK
#   - Printa uma mensagem no log de mensagens informando que um pokémon usou olhada e que 
#     o ataque do outro pokémon diminuiu
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon atacante
#       > a1 ---> Endereço do pokémon defensor
#       > a2 ---> 0 se for olhada, 1 se for o prego
PRINT_LOOK_ATTACK:
    # Store na pilha
    addi sp, sp, -16
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)

    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv t2, zero
    mv t3, a2

    # Adquirir o nome do pokémon atacante
    jal GET_POKEMON_NAME
    mv t2, a0

    # Printar o nome do pokémon atacante
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar a string attack_battle
    la a0, attack_battle
    li a1, 16
    li a2, 222
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar o nome do ataque
    beqz t3, Atq_Olhada
    la a0, n_prego
    j Print_Nome
    Atq_Olhada:
    la a0, n_look

    Print_Nome:
    li a1, 116
    li a2, 220
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG 
    
    # Desenhar a caixa de diálogo
    la a0, dialog_box_battle
    mv a1, zero
    li a2, 180
    mv a3, s0
    jal DRAW_IMAGE
    
    # Adquirir o nome do pokémon defensor
    mv a0, t1
    jal GET_POKEMON_NAME

    # Printar o nome do pokémon defensor
    li a1, 16
    li a2, 200
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Printar a string atk_battle
    la a0, atk_down_battle
    li a1, 16
    li a2, 220
    li a3, 0x000051FF
    mv a4, s0
    jal PRINT_STRING_SAVE

    # Esperar o jogador apertar a tecla z
    jal CONFIRM_DIALOG 
    
    # Load na pilha
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16

    # Retornar
    ret
