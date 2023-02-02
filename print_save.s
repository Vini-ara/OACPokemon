.text
# PRINT_STRING_SAVE:
#   - Printa uma string na tela SALVANDO OS REGISTRADORES TEMPORÁRIOS
#   - Parâmetros:
#       > a0 ---> Endereço da string
#       > a1 ---> Coordenada x
#       > a2 ---> Coordenada y
#       > a3 ---> Cor (0x0000BBFF --> BB = background e FF = cor da letra)
#       > a4 ---> Freame
PRINT_STRING_SAVE:
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

    jal printString
    
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

# PRINT_STRING_SAVE:
#   - Printa uma string na tela SALVANDO OS REGISTRADORES TEMPORÁRIOS
#   - Parâmetros:
#       > a0 ---> Endereço da string
#       > a1 ---> Coordenada x
#       > a2 ---> Coordenada y
#       > a3 ---> Cor (0x0000BBFF --> BB = background e FF = cor da letra)
#       > a4 ---> Frame
PRINT_INT_SAVE:
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

    jal printIntUnsigned

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
