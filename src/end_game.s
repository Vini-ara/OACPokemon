.text
END_GAME:
    mv a0, zero
    mv a1, s0
    jal COLOR_SCREEN

    infinity_loop:
    j infinity_loop