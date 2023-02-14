.text
CONFIRM_DIALOG:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw t0, 4(sp)

    Loop_Confirm_Dialog:
        jal KEY2
        li t0, 'z'
        beq a0, t0, End_Confirm_Dialog
        j Loop_Confirm_Dialog
        
    End_Confirm_Dialog:
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    ret
