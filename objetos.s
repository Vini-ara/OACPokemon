.data
OBJETOS: .space 584

.include "dataIncludes.s"

.text

inicia_objetos:
	la t0,OBJETOS
#GRASS0
	la t1,grass0
	sw t1,0(t0) #endereco da imagem
	li t1,1
	sw t1,4(t0) #andavel
	
#PROXIMO OBJETO
	addi t0,t0,8
#TREE0
	la t1,tree0
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel
	
	addi t0,t0,8
#TREE1
	la t1, tree1
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE2
	la t1,tree2
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE3
	la t1,tree3
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE4
	la t1,tree4
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE5
	la t1,tree5
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE6
	la t1,tree6
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE7
	la t1,tree7
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE8
	la t1,tree8
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE9
	la t1,tree9
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE10
	la t1,tree10
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#TREE11
	la t1,tree11
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

#indice 13
	addi t0,t0,8
#HOUSE0
	la t1,house0
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE1
	la t1,house1
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE2
	la t1,house2
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE3
	la t1,house3
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE4
	la t1,house4
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE5
	la t1,house5
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE6
	la t1,house6
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE7
	la t1,house7
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE8
	la t1,house8
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE9
	la t1,house9
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE10
	la t1,house10
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE11
	la t1,house11
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE12
	la t1,house12
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE13
	la t1,house13
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE14
	la t1,house14
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE15
	la t1,house15
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE16
	la t1,house16
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE17
	la t1,house17
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE18
	la t1,house18
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE19
	la t1,house19
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE20
	la t1,house20
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE21
	la t1,house21
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE22
	la t1,house22
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE23
	la t1,house23
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#HOUSE24
	la t1,house24
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

# 38
	addi t0,t0,8
#LAB0
	la t1,lab0
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB1
	la t1,lab1
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB2
	la t1,lab2
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB3
	la t1,lab3
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB4
	la t1,lab4
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB5
	la t1,lab5
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB6
	la t1,lab6
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB7
	la t1,lab7
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB8
	la t1,lab8
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB9
	la t1,lab9
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB10
	la t1,lab10
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB11
	la t1,lab11
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB12
	la t1,lab12
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB13
	la t1,lab13
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB14
	la t1,lab14
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB15
	la t1,lab15
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB16
	la t1,lab16
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB17
	la t1,lab17
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB18
	la t1,lab18
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB19
	la t1,lab19
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB20
	la t1,lab20
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB21
	la t1,lab21
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB22
	la t1,lab22
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB23
	la t1,lab23
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB24
	la t1,lab24
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB25
	la t1,lab25
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB26
	la t1,lab26
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB27
	la t1,lab27
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB28
	la t1,lab28
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB29
	la t1,lab29
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB30
	la t1,lab30
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB31
	la t1,lab31
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB32
	la t1,lab32
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB33
	la t1,lab33
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

	addi t0,t0,8
#LAB34
	la t1,lab34
	sw t1,0(t0) #endereco da imagem
	li t1,0
	sw t1,4(t0) #não andavel

#FIM
	ret
