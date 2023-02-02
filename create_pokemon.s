.text
# CREATE_POKEMON
#   - Cria o uma instância de um pokemon para a batalha e salva as informações do pokémon na label ´P_INIMIGO´
#   - Parâmetros:
#       > a0 ---> Endereço do pokemon base
#       > a1 ---> lvl do pokémon
#       > a2 ---> Endereço a ser armazenado o pokémon

CREATE_POKEMON:
    # Store na pilha
    addi sp, sp, -28
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    sw t6, 24(sp)

    # Inicializando registradores
    mv t0, a0           # t0 = a0
    mv t1, a1           # t1 = a1
    mv t2, a2           # t2 = a2
    mv t3, zero         # Armazena os stats para salvar

    # Load a primeira word de stats do pokémon
    lw t4, 0(t0)
    
    # Index
    li t6, 0xF0000000
    and t3, t4, t6

    # Tipo
    li t6, 0x0F000000
    and t5, t4, t6
    add t3, t3, t5

    # Xp
    li t6, 0x00FF0000
    and t5, t4, t6
    slli t6, t1, 16
    add t5, t5, t6
    add t3, t3, t5

    # Level
    slli t5, t1, 8
    add t3, t3, t5

    # Defesa
    li t6, 0x000000FF
    and t5, t4, t6
    add t5, t5, t1
    add t3, t3, t5

    # Salvar a primeira word no endereço t2
    sw t3, 0(t2)
    mv t3, zero
    
    # Load na segunda word de stats
    lw t4, 4(t0)

    # Velocidade
    li t6, 0xFF000000
    and t5, t4, t6
    slli t6, t1, 24
    add t5, t5, t6
    add t3, t3, t5

    # Ataque
    li t6, 0x00FF0000
    and t5, t4, t6
    slli t6, t1, 16
    add t5, t5, t6
    add t3, t3, t5

    # Vida e vida_máx
    li t6, 0x000000FF
    and t5, t4, t6
    slli t6, t1, 1
    add t5, t5, t6
    mv t6, t5
    slli t5, t5, 8
    add t5, t5, t6
    add t3, t3, t5

    # Salvar segunda string de stats em t2 + 4
    sw t3, 4(t2)  

    # Load na terceira word (ataques)
    lw t4, 8(t0)

    # Salvar a word de ataque em t2 + 8
    sw t4, 8(t2)

    # Load na pilha
    lw t6, 24(sp)
    lw t5, 20(sp)
    lw t4, 16(sp)
    lw t3, 12(sp)
    lw t2, 8(sp)
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 28
    
    # Retorna
    ret


CREATE_POKEMON_BULBASAUR:


CREATE_POKEMON_VULPIX:


CREATE_POKEMON_GEODUDE:


CREATE_POKEMON_PIDGEY:
