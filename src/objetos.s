.data
.include "dataIncludes.s"

#                   0,    1,      2,     3,     4,     5,     6,     7,     8,     9,     A,     B,     C
OBJETOS: .word BLACK,GRASS1,GRASS2,GRASS3,GRASS4,GRASS5,GRASS6,RIVER1,RIVER2,RIVER3,RIVER4,RIVER5,RIVER6,
#              D,     E,    F,    10,   11,   12,   13,   14,   15,   16,   17,   18,    19,   1A
          RIVER7,RIVER8,RIVER9,TREE1,TREE2,TREE3,TREE4,TREE5,TREE6,TREE7,TREE8,TREE9,TREE10, BUS1
#            1B, 1C,  1D,  1E,  1F,  20,  21,  22,   23,   24,   25,   26,   27,   28,   29
          BUS2,BUS3,BUS4,BUS5,BUS6,BUS7,BUS8,BUS9,BUS10,BUS11,BUS12,BUS13,BUS14,BUS15, LAB1,
#           2A,  2B,  2C,  2D,  2E,  2F,  30,  31,   32,   33,   34,   35,   36,   37,   38,   39
          LAB2,LAB3,LAB4,LAB5,LAB6,LAB7,LAB8,LAB9,LAB10,LAB11,LAB12,LAB13,LAB14,LAB15,LAB16,LAB17
#            3A,   3B,   3C,  3D,    3E,   3F,   40,   41,   42,   43,     44,    45,    46,
          LAB18,LAB19,LAB20,LAB21,LAB22,LAB23,LAB24,LAB25,LAB26,PKCTR1,PKCTR2,PKCTR3,PKCTR4,
#             47,   48,     49,    4A,    4B,     4C,     4D,     4E,     4F,     50
          PKCTR5,PKCTR6,PKCTR7,PKCTR8,PKCTR9,PKCTR10,PKCTR11,PKCTR12,PKCTR12,PKCTR13,PKCTR14,
#              51,     52,     53,     54,     55,     56,    57,   58,   59,   5A,   5B,   5C,   5D
          PKCTR15,PKCTR16,PKCTR17,PKCTR18,PKCTR19,PKCTR20,MALL1,MALL2,MALL3,MALL4,MALL5,MALL6,
#            5E,   5F,   60,    61,    62,    63,    64,    65,    66,    67,     68,     69,     6A
          MALL7,MALL8,MALL9,MALL10,MALL11,MALL12,MALL13,MALL14,MALL15,MALL16,IN_LAB1,IN_LAB2,IN_LAB3,
#              6B,     6C,       6D,       6E,       6F,       70,       71,      72,      73,      74,  
          IN_LAB4,IN_LAB5,IN_PKCTR1,IN_PKCTR2,IN_PKCTR3,IN_PKCTR4,IN_PKCTR5,IN_MALL1,IN_MALL2,IN_MALL3,
#               75,      76,     77,     78,     79,     7A,     7B,  
          IN_MALL4,IN_MALL5,IN_GYM1,IN_GYM2,IN_GYM3,IN_GYM4,IN_GYM4


BLACK:  .word black
        .byte 0
        .byte 0
        .byte 0

GRASS1: .word grass1 # endereço do sprite
        .byte 1      # andavel
        .byte 0      # espelhado
        .byte 0      # interagivel

GRASS2: .word grass2 # endereço do sprite
        .byte 1      # andavel
        .byte 0      # espelhado
        .byte 2      # interagivel

GRASS3: .word grass3 # endereço do sprite
        .byte 0      # andavel
        .byte 0      # espelhado
        .byte 0      # interagivel

GRASS4: .word grass4 # endereço do sprite
        .byte 0      # andavel
        .byte 0      # espelhado
        .byte 0      # interagivel

GRASS5: .word grass5 # endereço do sprite
        .byte 0      # andavel
        .byte 0      # espelhado
        .byte 0      # interagivel

GRASS6: .word grass5 # endereço do sprite
        .byte 0      # andavel
        .byte 1      # espelhado
        .byte 0      # interagivel

RIVER1:  .word river1 # endereco do sprite
        .byte 0     # andavel
        .byte 0     # espelhado
        .byte 0     #interagivel

RIVER2: .word river1 # endereco do sprite
        .byte 0     # andavel
        .byte 1     # espelhado
        .byte 0     #interagivel

RIVER3:  .word river2 # endereco do sprite
        .byte 0     # andavel
        .byte 0     # espelhado
        .byte 0     #interagivel

RIVER4:  .word river3 # endereco do sprite
        .byte 0     # andavel
        .byte 0     # espelhado
        .byte 0     #interagivel

RIVER5:  .word river4 # endereco do sprite
        .byte 0     # andavel
        .byte 0     # espelhado
        .byte 0     #interagivel

RIVER6:  .word river4 # endereco do sprite
        .byte 0     # andavel
        .byte 1     # espelhado
        .byte 0     #interagivel

RIVER7:  .word river5 # endereco do sprite
        .byte 0     # andavel
        .byte 0     # espelhado
        .byte 0     # interagivel

RIVER8:  .word river5 # endereco do sprite
        .byte 0     # andavel
        .byte 1     # espelhado
        .byte 0     # interagivel

RIVER9:  .word river7 # endereco do sprite
        .byte 0     # andavel
        .byte 0     # espelhado
        .byte 0     # interagivel

TREE1:  .word tree1 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

TREE2:  .word tree1 # endereco do sprite
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

TREE3:  .word tree2 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

TREE4:  .word tree2 # endereco do sprite
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

TREE5:  .word tree3 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

TREE6:  .word tree3 # endereco do sprite
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

TREE7:  .word tree4 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

TREE8:  .word tree4 # endereco do sprite
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

TREE9:  .word tree5 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

TREE10:  .word tree5 # endereco do sprite
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

BUS1:  .word bus1 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS2:  .word bus2 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS3:  .word bus3 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS4:  .word bus4 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS5:  .word bus5 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS6:  .word bus6 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS7:  .word bus7 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS8:  .word bus8 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS9:  .word bus9 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS10:  .word bus10 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS11:  .word bus11 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS12:  .word bus12 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS13:  .word bus13 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 4   # interagivel
        .word GYM_OBJ

BUS14:  .word bus14 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

BUS15:  .word bus15 # endereco do sprite
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB1:  .word lab1
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB2:  .word lab2
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB3:  .word lab3
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB4:  .word lab4
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB5:  .word lab5
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB6:  .word lab6
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB7:  .word lab7
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB8:  .word lab8
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB9:  .word lab9
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB10:  .word lab10
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB11:  .word lab11
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB12:  .word lab12
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB13:  .word lab13
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB14:  .word lab13
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

LAB15:  .word lab14
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB16:  .word lab14
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

LAB17:  .word lab15
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB18:  .word lab15
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

LAB19:  .word lab16
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB20:  .word lab17
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB21:  .word lab17
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

LAB22:  .word lab18
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB23:  .word lab18
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

LAB24:  .word lab19
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 0   # interagivel

LAB25:  .word lab19
        .byte 0     # andavel
        .byte 1   # espelhado
        .byte 0   # interagivel

LAB26:  .word lab20
        .byte 0     # andavel
        .byte 0   # espelhado
        .byte 1   # interagivel
        .word LAB_OBJ

PKCTR1: .word pkctr1
        .byte 0
        .byte 0
        .byte 0

PKCTR2: .word pkctr1
        .byte 0
        .byte 1
        .byte 0

PKCTR3: .word pkctr2
        .byte 0
        .byte 0
        .byte 0

PKCTR4: .word pkctr3
        .byte 0
        .byte 0
        .byte 0

PKCTR5: .word pkctr3
        .byte 0
        .byte 1
        .byte 0

PKCTR6: .word pkctr4
        .byte 0
        .byte 0
        .byte 0

PKCTR7: .word pkctr4
        .byte 0
        .byte 1
        .byte 0

PKCTR8: .word pkctr5
        .byte 0
        .byte 0
        .byte 0

PKCTR9: .word pkctr6
        .byte 0
        .byte 0
        .byte 0

PKCTR10: .word pkctr7
        .byte 0
        .byte 0
        .byte 0

PKCTR11: .word pkctr8
        .byte 0
        .byte 0
        .byte 0

PKCTR12: .word pkctr8
        .byte 0
        .byte 1
        .byte 0

PKCTR13: .word pkctr9
        .byte 0
        .byte 0
        .byte 0

PKCTR14: .word pkctr9
        .byte 0
        .byte 1
        .byte 0

PKCTR15: .word pkctr10
        .byte 0
        .byte 0
        .byte 0

PKCTR16: .word pkctr11
        .byte 0
        .byte 0
        .byte 0

PKCTR17: .word pkctr12
        .byte 0
        .byte 0
        .byte 0

PKCTR18: .word pkctr13
        .byte 0
        .byte 0
        .byte 1
        .word PKCTR_OBJ

PKCTR19: .word pkctr14
        .byte 0
        .byte 0
        .byte 0

PKCTR20: .word pkctr15
        .byte 0
        .byte 0
        .byte 0

MALL1: .word mall1
        .byte 0
        .byte 0
        .byte 0

MALL2: .word mall1
        .byte 0
        .byte 1
        .byte 0

MALL3: .word mall2
        .byte 0
        .byte 0
        .byte 0

MALL4: .word mall2
        .byte 0
        .byte 1
        .byte 0

MALL5: .word mall3
        .byte 0
        .byte 0
        .byte 0

MALL6: .word mall3
        .byte 0
        .byte 1
        .byte 0

MALL7: .word mall4
        .byte 0
        .byte 0
        .byte 0

MALL8: .word mall4
        .byte 0
        .byte 1
        .byte 0

MALL9: .word mall5
        .byte 0
        .byte 0
        .byte 0

MALL10: .word mall5
        .byte 0
        .byte 1
        .byte 0

MALL11: .word mall6
        .byte 0
        .byte 0
        .byte 0

MALL12: .word mall6
        .byte 0
        .byte 1
        .byte 0

MALL13: .word mall7
        .byte 0
        .byte 0
        .byte 0

MALL14: .word mall8
        .byte 0
        .byte 0
        .byte 0

MALL15: .word mall9
        .byte 0
        .byte 0
        .byte 1
        .word MALL_OBJ

MALL16: .word mall10
        .byte 0
        .byte 0
        .byte 0

IN_LAB1: .word in_lab1
          .byte 1
          .byte 0
          .byte 0

IN_LAB2: .word in_lab2
          .byte 0
          .byte 0
          .byte 3
          .byte 2 # professor

IN_LAB3: .word in_lab3
          .byte 1
          .byte 0
          .byte 1 
          .word MAPA_OBJ

IN_LAB4: .word in_lab4
          .byte 0
          .byte 0
          .byte 0

IN_LAB5: .word in_lab5
          .byte 0
          .byte 0
          .byte 0

IN_PKCTR1: .word in_pkctr1
           .byte 1
           .byte 0
           .byte 0

IN_PKCTR2: .word in_pkctr2
           .byte 0
           .byte 0
           .byte 3
           .byte 0 # curandeira

IN_PKCTR3: .word in_pkctr3
           .byte 1
           .byte 0
           .byte 1
           .word MAPA_OBJ

IN_PKCTR4: .word in_pkctr4
           .byte 0
           .byte 0
           .byte 0

IN_PKCTR5: .word in_pkctr5
           .byte 0
           .byte 0
           .byte 0

IN_MALL1: .word in_mall1
          .byte 1
          .byte 0
          .byte 0

IN_MALL2: .word in_mall2
          .byte 0
          .byte 0
          .byte 3
          .byte 1 # vendedor

IN_MALL3: .word in_mall3
          .byte 1
          .byte 0
          .byte 1
          .word MAPA_OBJ

IN_MALL4: .word in_mall4
          .byte 0
          .byte 0
          .byte 0

IN_MALL5: .word in_mall5
          .byte 0
          .byte 0
          .byte 0

IN_GYM1: .word in_gym1
          .byte 1
          .byte 0
          .byte 0

IN_GYM2: .word in_gym2
          .byte 0
          .byte 0
          .byte 3
          .byte 3 # adversario

IN_GYM3: .word in_gym4
          .byte 0
          .byte 0
          .byte 0

IN_GYM4: .word in_gym5
          .byte 0
          .byte 0
          .byte 0
