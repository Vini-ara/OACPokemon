.text
# SLEEP:
#   - Para o programa por alguns milisegundos
#   - Parâmetros:
#       > a0 ---> tempo de espera em milisegundos
#       > a1 ---> tempo inicial
SLEEP:
    # Store na pilha
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)

    # Loop
    Loop_Sleep:
        csrr t1, 3073           # Adquiri o tempo atual
        sub t0, t1, a1          # Calcula a variação do tempo
        blt t1, a0, Loop_Sleep  # Se a variação de tempo for menor que a0, repetir o processo
    
    # Load na pilha
    lw t1, 4(sp)
    lw t0, 0(sp)
    addi sp, sp, 8

    # Retornar
    ret
