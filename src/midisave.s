MIDI_SAVE:
    # Store na pilha
    addi sp, sp, -52
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw t4, 20(sp)
    sw t5, 24(sp)
    sw t6, 28(sp)
    sw s0, 32(sp)
    sw s1, 36(sp)
    sw s2, 40(sp)
    sw s3, 44(sp)
    sw s4,48(sp)

    jal midiOutDE2 

    # Load na pilha
    lw s4, 48(sp)
    lw s3, 44(sp)
    lw s2, 40(sp)
    lw s1, 36(sp)
    lw s0, 32(sp)
    lw t6, 28(sp)
    lw t5, 24(sp)
    lw t4, 20(sp)
    lw t3, 16(sp)
    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 52
    ret
