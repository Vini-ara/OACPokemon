.data
# SPRITES DOS POKÉMONS
.include "../../data_files/s_squirtle.data"
.include "../../data_files/s_bulbasaur.data"
.include "../../data_files/s_vulpix.data"
.include "../../data_files/s_pidgey.data"
.include "../../data_files/s_geodude.data"
.include "../../data_files/caramelo.data"
.include "../../data_files/sarue.data"
.include "../../data_files/pombo.data"
.include "../../data_files/larva.data"
.include "../../data_files/gato.data"
.include "../../data_files/sinuca.data"
lista_sprites: .word sarue, caramelo, larva, pombo, gato, sinuca

# NOMES DOS POKÉMONS
n_squirtle:  .string "Pedro Sarue"
n_bulbasaur: .string "Caramelo"
n_vulpix:    .string "Pombo do Bebedouro"
n_pidgey:    .string "Gato"
n_geodude:   .string "Larva do RU"
n_sinuca:    .string "Sinuca Cacomp"

lista_nomes: .word n_squirtle, n_bulbasaur, n_geodude, n_vulpix, n_pidgey, n_sinuca

# POKEMONS:
#   - Um pokemon preceisa ter os atributos vida, vida_max, ataque, velocidade, defesa, tipo1, level, xp, xp para subir de lvl, sprite, nome 
#       > .word 0xITXXLLDD, 0xSSAAMMVV, 0xA1A2A3A4
#       > Cada dois dígitos da word em hexadecimal representam um atributo, com exceção do dois primeiro dígito da primeira word (I e T)
#       > I  ---> Index na lista de nomes e sprites (1 dígito)
#       > T  ---> Tipo do pokémon (1 dígito)
#       > XX ---> Experiência do pokémon (2 dígitos)
#       > LL ---> Level do pokémon (2 dígitos)
#       > DD ---> Defesa do pokémon (2 dígitos)
#       > SS ---> Velocidade do pokémon (2 dígitos)
#       > AA ---> Ataque do pokémon (2 dígitos)
#       > MM ---> Vida máxima do pokémon (2 dígitos)
#       > VV ---> Vida atual do pokémon (2 dígitos)
#       > A1 ---> Representa o primeiro ataque (2 dígitos)
#       > A2 ---> Representa o segundo ataque (2 dígitos)
#       > A3 ---> Representa o terceiro ataque (2 dígitos)
#       > A4 ---> Representa o quarto ataque (2 dígitos)

# LEVEL UP:
#   - vida aumenta em 2
#   - ataque, defesa, velocidade aumentam em 1
#   - A quantidade de xp necessária para o próximo lvl up dobra 

# LEGENDA DE TIPOS
# 0 --> Atirador
# 1 --> Lutador
# 2 --> Voador
# 3 --> NORMAL
# 4 --> Venenoso

# $ SQUIRTLE
#   > Vida = 12
#   > Vida_max = 12
#   > Ataque = 6
#   > Velocidade = 6
#   > Defesa = 6
#   > Level = 1
#   > Xp = 0
#   > Tipo1 = 0 ()
#   > Index = 0
P_SARUE: .word 0x00000106, 0x06060C0C, 0x31511100    

# $ BULBASAUR
#   > Vida = 12
#   > Vida_max = 12
#   > Ataque = 6
#   > Velocidade = 6
#   > Defesa = 6
#   > Level = 1
#   > Xp = 0
#   > Tipo1 = 1 (grama)
#   > Index = 1     
P_CARAMELO: .word 0x11000106, 0x06060C0C, 0x31512100

# $ GEODUDE
#   > Vida = 11
#   > Vida_max = 11
#   > Ataque = 6
#   > Velocidade = 5
#   > Defesa = 7
#   > Level = 1
#   > Xp = 0
#   > Tipo1 = 3 (voador)
#   > Index = 4                          
P_LARVA: .word 0x24000106, 0x05060B0B, 0x31516100

# $ VULPIX
#   > Vida = 11
#   > Vida_max = 11
#   > Ataque = 5
#   > Velocidade = 6
#   > Defesa = 5
#   > Level = 1
#   > Xp = 0 
#   > Tipo1 = 2 (fogo)
#   > Index = 3                          
P_POMBO: .word 0x32000106, 0x06060C0C, 0x31510100

# $ PIDGEY
#   > Vida = 11
#   > Vida_max = 11
#   > Ataque = 5
#   > Velocidade = 6
#   > Defesa = 5
#   > Level = 1
#   > Xp = 0 
#   > Tipo1 = 3 (voador)
#   > Index = 4                          
P_GATO: .word 0x43000105, 0x06050B0B, 0x31510000

# $ PIDGEY
#   > Vida = 11
#   > Vida_max = 11
#   > Ataque = 6
#   > Velocidade = 7
#   > Defesa = 6
#   > Level = 1
#   > Xp = 0 
#   > Tipo1 = 4 (voador)
#   > Index = 5 
P_SINUCA: .word 0x54000106, 0x07060B0B, 0x71810000

.text
# GET_POKEMON_STAT
#   - Retorna um stat de um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
#       > a1 ---> stat 
#           % 0x00 = DD
#           % 0x02 = LL
#           % 0x04 = XX
#           % 0x06 = IT
#           % 0x10 = VV
#           % 0x12 = MM
#           % 0x14 = AA
#           % 0x16 = SS
#   - Retorno:
#       > a0 ---> Stat selecionado
GET_POKEMON_STAT:
    # Store na pilha
    addi sp, sp, -12
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)

    # Determinar qual word acessar
    slti t0, a1, 16             # t0 = 1, se a1 < 0x010, 0 se a1 >= 0x010 
    beq t0, zero, Second_Word   # Se t0 = 0, pular para Second_Word
    
    # Se t0 = 1, então a1 < 16. Logo, ler a primeira a primeira word
    lw t0, 0(a0)
    j Access_Stat 
    Second_Word:
        lw t0, 4(a0)
    
    Access_Stat:
        andi t1, a1, 0x00F      # t1 = a1 and 0x00F (Adquirir o dígito menos significativo de a1) 
        slli t1, t1, 2          # t1 = t1 * 4 (Calcular quantas bits shifitar)
        li t2, 0x000000FF       # t2 = 0x000000FF
        sll t2, t2, t1          # t2 = t2 shifiitado t1 bits a esquerda
        and t2, t2, t0          # t2 = t2 and t0 (adquirir o stat selecionado)
        srl a0, t2, t1          # a0 = t2 shifitado t1 bits a direita (normalizando o número)

    # Load na pilha
    lw t2, 8(sp)
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 12
    ret
#

# GET_POKEMON_NAME
#   - Retorna o endereço do nome de um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
GET_POKEMON_NAME:
    # Store na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)

    # Adquirir o index da lista de nomes
    li a1, 0x06
    jal GET_POKEMON_STAT    # a0 = IT
    andi t0, a0, 0x0F0      # t0 = a0 and 0x0F0 (extrair o I)
    srli t0, t0, 4          # t0 = t0 shifitado 4 bits para a direita (normalizar o número) (t0 = I)

    # Adquirir o endereço
    slli t0, t0, 2          # t0 = t0 * 4
    la t1, lista_nomes      # t1 = Endereço da lista de nomes
    add t0, t0, t1          # t0 = t0 + t1 (Endereço do ponteiro do nome)
    lw a0, 0(t0)            # a0 = Endereço do nome

    # Load na pilha
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    # Retornar
    ret  
#

# GET_POKEMON_SPRITE
#   - Retorna o endereço da sprite de um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
GET_POKEMON_SPRITE:
    # Store na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)

    # Adquirir o index da lista de nomes
    li a1, 0x06
    jal GET_POKEMON_STAT    # a0 = IT
    andi t0, a0, 0x0F0      # t0 = a0 and 0x0F0 (extrair o I)
    srli t0, t0, 4          # t0 = t0 shifitado 4 bits para a direita (normalizar o número) (t0 = I)
    
    # Adquirir o endereço
    slli t0, t0, 2          # t0 = t0 * 4
    la t1, lista_sprites    # t1 = Endereço da lista de sprites
    add t0, t0, t1          # t0 = t0 + t1 (Endereço do ponteiro do nome)
    lw a0, 0(t0)            # a0 = Endereço do nome

    # Load na pilha
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    # Retornar
    ret
#

# GET_POKEMON_TYPE
#   - Retorna o tipo de um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
GET_POKEMON_TYPE:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)

    # Adquirir o index da lista de nomes
    li a1, 0x06
    jal GET_POKEMON_STAT    # a0 = IT
    andi a0, a0, 0x00F      # t0 = a0 and 0x0F0 (extrair o T)

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret
#

# GET_NUM_ATTACKS
#   - Retorna o números de ataques que um pokémon aprendeu
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
#   - Retorno:
#       > a0 ---> Número de ataques (1 a 4)
GET_NUM_ATTACKS:
    # Store na pilha
    addi sp, sp, -16
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)

    # Inicializando registradores
    lw t0, 8(a0)                        # t0 = word de ataques do pokémon
    li t1, 0xFF000000                   # t1 = 0xFF000000
    mv t2, zero                         # t2 = 0
    mv a0, zero                         # a0 = 0

    Loop_Get_Num_Attacks:
        li t3, 24                       # t3 = 24
        beq t2, t3, End_Get_Num_Attacks # Se t2 = t3, acabar com o loop
        srl t3, t1, t2                  # t3 = t1 shifitado t2 bits para a direita
        and t3, t3, t0                  # t3 = t3 and t0
        addi t2, t2, 8                  # t2 += 8
        beqz t3, Loop_Get_Num_Attacks   # Se t3 = 0, o slot de ataque está vazio
        addi a0, a0, 1                  # Se t3 != 0, o slot de ataque está preenchido
        j Loop_Get_Num_Attacks          # Voltar ao início do loop

    End_Get_Num_Attacks:
        # Load na pilha
        lw t3, 12(sp)
        lw t2, 8(sp)
        lw t1, 4(sp)
        lw t0, 0(sp)
        addi sp, sp, 16
        # Retornar
        ret
#

# SET_POKEMON_STAT
#   - Seta um stat de um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
#       > a1 ---> stat 
#           % 0x00 = DD
#           % 0x02 = LL
#           % 0x04 = XX
#           % 0x06 = IT
#           % 0x10 = VV
#           % 0x12 = MM
#           % 0x14 = AA
#           % 0x16 = SS
#       > a2 ---> Novo valor do stat
SET_POKEMON_STAT:
    # Store na pilha
    addi sp, sp, -12
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)

    # Determinar qual word acessar
    slti t0, a1, 16             # t0 = 1, se a1 < 0x010, 0 se a1 >= 0x010 
    beq t0, zero, Second_Word2  # Se t0 = 0, pular para Second_Word2
    
    # Se t0 = 1, então a1 < 16. Logo, ler a primeira a primeira word
    lw t0, 0(a0)
    j Access_Stat2 
    Second_Word2:
        addi a0, a0, 4
        lw t0, 0(a0)
    
    Access_Stat2:
        andi t1, a1, 0x00F      # t1 = a1 and 0x00F (Adquirir o dígito menos significativo de a1) 
        slli t1, t1, 2          # t1 = t1 * 4 (Calcular quantas bits shifitar)
        li t2, 0x000000FF       # t2 = 0x000000FF
        sll t2, t2, t1          # t2 = t2 shifitado t1 bits a esquerda
        and t2, t2, t0          # t2 = t2 and t0 (adquirir o stat selecionado)
        sub t0, t0, t2          # t1 = word de stats - stat
        sll t2, a2, t1 
        add t0, t0, t2
        sw t0, 0(a0)

    # Load na pilha
    lw t2, 8(sp)
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 12
    ret
#

# CHECK_LIFE
#   - Verifica se a vida de um pokémon é igual a zero
#   - Parâmetros:
#       > a0 ---> ENdereço do pokémon
#   - Retorno:
#       > a0 ---> 1 se vida = 0, 0 se vida != 0
CHECK_LIFE:
    # Store na pilha
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # Adquirir vida
    li a1, 0x10
    jal GET_POKEMON_STAT

    # Verificar se a vida = 0
    beqz a0, Dead
    
    # Pokémon está vivo
    mv a0, zero
    j End_Check_Life
    
    Dead:
        # Pokémon esta morto --> a0 = 1
        li a0, 1

    End_Check_Life:
    # Load na piha
    lw ra, 0(sp)
    addi sp, sp, 4
    
    # Retornar
    ret
#

# CHECK_LEVEL_UP:
#   - Verifica se o pokémon do jogador precisa aumentar o level
#   - Para aumentar o level em 1, a xp do pokémon precisa ser igual ou maior que 5 vezes o level atual
#   - Retorno:
#       > a0 ---> 1 se o pokémon precisa dar level up, 0 caso contrário
CHECK_LEVEL_UP:
    # Store na pilha
    addi sp, sp, -8
    sw ra, 0(sp)
    sw t0, 4(sp)

    # Adquirir o level do pokémon
    la a0, P_PLAYER
    li a1, 0x02
    jal  GET_POKEMON_STAT
    li t0, 5
    mul t0, t0, a0

    # Adquirir a xp atual do pokémon
    la a0, P_PLAYER
    li a1, 0x04
    jal GET_POKEMON_STAT

    # Verifica se a xp é igual ou maior que 5 x level
    bge a0, t0, Need_Level_Up
    
    # Se não, a0 = 0
    mv a0, zero
    j End_Check_Level_Up
    Need_Level_Up:
    # Se sim, a0 = 1
        li a0, 1
    
    End_Check_Level_Up:
    # Load na pilha
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    # Retornar
    ret
#

# LEVEL_UP
#   - Promove um level up no pokémon do jogador
LEVEL_UP:
    # Store na pilha
    addi sp, sp, -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)

    # Inicializar registradores
    la t0, P_PLAYER

    # Adquirir o level do pokémon
    mv a0, t0
    li a1, 0x02
    jal GET_POKEMON_STAT
    mv t1, a0

    # Adquirir a xp do pokémon
    mv a0, t0
    li a1, 0x04
    jal GET_POKEMON_STAT
    mv t2, a0

    # Subtrair a xp e setar nova xp
    li t3, 5
    mul t3, t3, t1
    sub t2, t2, t3
    mv a2, t2
    mv a0, t0
    jal SET_POKEMON_STAT

    # Aumentar o level e setar o novo level
    mv a0, t0
    li a1, 0x02
    addi a2, t1, 1
    jal SET_POKEMON_STAT

    # Aumentar os outros stats
    ## Vida
    mv a0, t0
    li a1, 0x10
    jal GET_POKEMON_STAT

    addi a2, a0, 3
    mv a0, t0
    jal SET_POKEMON_STAT

    ## Vida_máx
    mv a0, t0
    li a1, 0x12
    jal GET_POKEMON_STAT

    addi a2, a0, 3
    mv a0, t0
    jal SET_POKEMON_STAT

    ## Ataque
    mv a0, t0
    li a1, 0x14
    jal GET_POKEMON_STAT

    addi a2, a0, 2
    mv a0, t0
    jal SET_POKEMON_STAT

    ## Velocidade
    mv a0, t0
    li a1, 0x16
    jal GET_POKEMON_STAT

    addi a2, a0, 1
    mv a0, t0
    jal SET_POKEMON_STAT

    ## Defesa
    mv a0, t0
    li a1, 0x00
    jal GET_POKEMON_STAT

    addi a2, a0, 2
    mv a0, t0
    jal SET_POKEMON_STAT

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

# WILD_POKEMON_DECISION
#   - Escolhe aleatoriamente um ataque para o pokémon inimigo usar
#   - Retorno:
#       > a0 ---> index do ataque escolhido (0 a 6)
WILD_POKEMON_DECISION:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)

    # Número aleatório
    jal Random.DE1
    mv t0, a0           # t0 = número aleatório

    # Verificar quantos slots de ataque não estão vazios
    la a0, P_INIMIGO
    jal GET_NUM_ATTACKS

    # Subtrair 1 do número de ataques (restringir o interval para 0 a 3 --> Index dos ataques)
    addi a0, a0, -1

    # Ajustar o número aleatório ao número de ataques disponíveis
    and t0, t0, a0

    # Extrair o index do ataque escolhido
    la t1, P_INIMIGO
    lw t1, 8(t1)
    li t2, 8
    mul t0, t0, t2
    li t2, 28
    sub t0, t2, t0
    srl a0, t1, t0

    # Load na pilha
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16

    # Retornar
    ret
#

# LEARN_ATTACK:
#   - Ensina um ataque a um pokémon
#   - Parâmetros:
#       > a0 ---> Endereço do pokémon
#       > a1 ---> Código do ataque
LEARN_ATTACK:
    # Store na pilha
    addi sp, sp, -16
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)

    # Inicializando registradores
    lw t0, 8(a0)                        # t0 = word de ataques do pokémon
    li t1, 0xFF000000                   # t1 = 0xFF000000
    mv t2, zero                         # t2 = 0
    Loop_Learn_Attack:
        srl t3, t1, t2                  # t3 = t1 shifitado t2 bits para a direita
        and t3, t3, t0                  # t3 = t3 and t0
        beqz t3, End_Learn_Attack       # Se t3 = 0, o slot de ataque está vazio
        addi t2, t2, 8                  # t2 += 8
        j Loop_Learn_Attack             # Voltar ao início do loop

    End_Learn_Attack:
        li t3, 24
        sub t3, t3, t2
        sll a1, a1, t3
        add t0, t0, a1
        sw t0, 8(a0)
        # Load na pilha
        lw t3, 12(sp)
        lw t2, 8(sp)
        lw t1, 4(sp)
        lw t0, 0(sp)
        addi sp, sp, 16
        # Retornar
        ret 
