li $r1, -1
put $r1
addi $r1, 4
put $r1
bp $r1, cont
halt

cont:
	li $r2, 10
	put $r2
	halt