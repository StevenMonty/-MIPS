Steven Montalbano
smm285
smm285@pitt.edu
As far as I can see, all of the instructions supported have run without error, including the provided test files and my own. (add, sub, and, nor, addui, addi, div, mul, slrv, dllv, lw, st, li, bp, nb, bx, bz, jr, jal, j imm, halt, put)

This however, does not guarantee that my tests have reached every test case and that it is 100% bug free. 

Control Signals:
halt - Halts PC
Reg W/E - Register File Write Enable
LED Enable - allows the incoming data to be stored in the display buffer
MemWrite - RAM Write Enable
Carry Out - allows 2 registers to be written to in the case of multiplication or devision of two 16 bit numbers that result in a 32 bit number to be stored
PC Source - Controls the PC mux that accepts in the immediate value at select bit 0, and the contents of $rs at select bit 1.
Branch - Output of this pin & the last bit of the ALU result are used to control the PC source mux from a branch command 
Jump - Output of this pin is  used to control the PC source mux from a jump command
Zero Extend - controls if the immediate value is zero extended or sign extended
i Type - used to determine an I vs and R type instruction to parse instruction correctly
Li - tells the Register File to read from memory
ALU Op - translates the OpCode to the appropriate ALU Op select bit. 