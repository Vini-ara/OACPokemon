.data
# ESTADO DO PROFESSOR
#	Se for 0, exibir diálogo de escolha dos pokémons, se for 1, exibir diálogo do passe, e se for 2 exibir diálogo padrão
estado_prof: .byte 0
.text
PROFESSOR:
    # Store na pilha
    addi sp, sp, -12
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    
    # Xori no s0
    xori s0, s0, 1

    la t0, estado_prof
    lb t0, 0(t0)

    beqz t0, Escolha_Pokemons
    
    li t1, 1
    beq t0, t1, Dialog_Passe

    li t1, 2
    beq t0, t1, Dialog_Padrao

    Escolha_Pokemons:
        jal ESCOLHA_POKEMONS_INICIAL
        j End_Professor

    Dialog_Passe:
        jal DIALOGO_PASSE
        j End_Professor

    Dialog_Padrao:
        jal DIALOGO_PADRAO

    End_Professor:
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    ret

ESCOLHA_POKEMONS_INICIAL:

    # Printar string vendedora_fala1
    la a0, vendedora_fala1
    mv a1, s0
    jal PRINT_TEXT_BOX

    # Printar string venddedora_fala2
    la a0, vendedora_fala2
    mv a1, s0
    jal PRINT_TEXT_BOX

    # Menu de compra
    jal VENDEDORA_MENU

    # Load na pilha
    lw ra, 0(sp)
    addi sp, sp, 4

    # Retornar
    ret