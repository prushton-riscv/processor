init:
; end string characyer
	addi $t0 $c0 3
;relative address for char buf
	addi $c2 $c0 512
;last pressed key
	addi $t1 $c0 0
readchar:
; load char to reg
	lw $c1 $c0[1]
; beq current char equals previous char
	beq $t1 $c1 readchar
; store the current char as prev pressed character
	addi $t1 $c1 0
; beq 0 or if last character
	beq $c1 $c0 readchar

; save char to char buf in mem, increment buf
	sw $c2[0] $c1
	addi $c2 $c2 1

; go to end if char is end, else loop
	beq $c1 $t0 end
	beq $c0 $c0 readchar
end:
	beq $c0 $c0 255
