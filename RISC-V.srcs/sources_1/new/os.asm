	addi $t0 $c0 4
	addi $t1 $c0 4
main:
	subi $t0 $t0 1
	add $t3 $t3 $t1
	beq $t0 $c0 end
	beq $c0 $c0 main
end:
	addi $v0 $c0 1
