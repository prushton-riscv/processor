0init:
	addi $t0 $c0 3
	addi $c2 $c0 512
readchar:
	lw $c1 $c0[1]
	beq $c1 $c0 readchar
	sw $c2[0] $c1
	addi $c2 $c2 1
	beq $c1 $t0 end
	beq $c0 $c0 readchar
end:
	beq $c0 $c0 255
