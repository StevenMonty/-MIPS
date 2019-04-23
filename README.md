# μMIPS
##### A Single-Cycle 16 Bit MIPS Processor
&nbsp;
µMIPS is a simplified MIPS architecture with a native word size of 16-bits. That is, the instructions and data values are 16-bits wide. µMIPS immediates can be both unsigned and signed using two’s complement. The processor is made up of many sub-circuits: The Program Counter (PC), The Register File, The Arithmetic Logic Unit (ALU), Field Splitter, Instruction Decoder, and an LED Display. 

### Instructions
µMIPS has a limited instruction set with the following operations (grouped by purpose): 

| Opcode | Subop | Format |    Instruction   | Definition                             |
|--------|-------|--------|------------------|----------------------------------------|
| 0000   | 0     | R      |  add $rs, $rt    | $rs ← $rs + $rt                        |
| 0000   | 1     | R      |  sub $rs, $rt    | $rs ← $rs - $rt                        |
| 0001   | 0     | R      |  and $rs, $rt    | $rs ← $rs & $rt                        |
| 0001   | 1     | R      |  nor $rs, $rt    | $rs ← !($rs \| $rt)                    |
| 1000   | 0     | I      |  addui $rs, imm  | $rs ← $rs + zero_extend(imm)           |
| 1000   | 1     | I      |  addi $rs, imm   | $rs ← $rs + sign_extend(imm)           |
|        |       |        |                  |                                        |
| 0010   | 0     | R      |  div $rs, $rt    | $rs ← $rs ÷ $rt; $rs+1 ← $rs mod $rt   |
| 0010   | 1     | R      |  mul $rs, $rt    | $rs+1:$rs ← $rs × $rt                  |
| 0011   | 0     | R      |  srlv $rs,$rt    | $rs ← $rs \>\> ($rt & 0x0F)            |
| 0011   | 1     | R      |  sllv $rs,$rt    | $rs ← $rs \<\< ($rt & 0x0F)            |
|        |       |        |                  |                                        |
| 0100   | 0     | R      |  lw $rs, $rt     | $rs ← MEM[$rt & 0xFF]                  |
| 0100   | 1     | R      |  sw $rs, $rt     | MEM[$rt & 0xFF] ← $rs                  |
| 1001   | X     | I      |  li $rs, imm     | $rs ← zero_extend(imm)                 |
|        |       |        |                  |                                        |
| 1010   | 0     | I      |  bp $rs, imm     | PC ← ($rs > 0 ? imm : PC + 1)          |
| 1010   | 1     | I      |  bn $rs, imm     | PC ← ($rs < 0 ? imm : PC + 1)          |
| 1011   | 0     | I      |  bx $rs, imm     | PC ← ($rs ≠ 0 ? imm : PC + 1)          |
| 1011   | 1     | I      |  bz $rs, imm     | PC ← ($rs = 0 ? imm : PC + 1)          |
|        |       |        |                  |                                        |
| 0101   | X     | R      |  jr $rs          | PC ← $rs                               |
| 1100   | X     | I      |  jal $rs, imm    | $rs ← PC + 1; PC ← imm                 |
| 1101   | X     | I      |  j imm           | PC ← imm                               |
|        |       |        |                  |                                        |
| 0110   | X     | R      |  halt            | stop fetching and set halt LED to red  |
| 0111   | X     | R      |  put $rs         | output $rs to Hex LED display          |

### Instruction Format

µMIPS has two instruction formats: R and I. R is used for instructions that have only registers
and I is used for instructions with an immediate. The formats are:

<table>
  <tr>
    <th colspan="6"><span style="font-weight:bold">I Format Instruction</span></th>
  </tr>
  <tr>
    <td>Bit position</td>
    <td>15-12</td>
    <td>11-9</td>
    <td colspan="2">8-1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>Field</td>
    <td><span style="font-style:italic">Opcode</span></td>
    <td><span style="font-style:italic">Rs</span></td>
    <td colspan="2"><span style="font-style:italic">Imm</span></td>
    <td><span style="font-style:italic">Subop</span></td>
  </tr>
</table>

<table>
  <tr>
    <th colspan="6"><span style="font-weight:bold">R Format Instruction</span></th>
  </tr>
  <tr>
    <td>Bit position</td>
    <td>15-12</td>
    <td>11-9</td>
    <td>8-6</td>
    <td>5-1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>Field</td>
    <td><span style="font-style:italic">Opcode</span></td>
    <td><span style="font-style:italic">Rs</span></td>
    <td><span style="font-style:italic">Rt</span></td>
    <td><span style="font-style:italic">unused</span></td>
    <td><span style="font-style:italic">Subop</span></td>
  </tr>
</table>


$rs is the first source register and $rt is the second source register. $rs is also the destination register for the result to be stored in.

Imm is an 8-bit immediate. The immediate is signed in addi and unsigned in addui, bn, bx, bp, bz, jal, and j. For the addition instructions with an immediate (i.e., addi and addui), the bit Subop controls whether the immediate is sign or zero extended. When Subop is 0, then Imm is zero extended to implement the addui instruction. Otherwise, Imm is sign extended to implement addi. Imm is zero extended for branches and jump (j).

In branches, jal and j, Imm specifies the target address. Both branches and jumps use absolute addressing for the target address. So, for example, if a branch is taken and Imm is 0x1a, then the target address for the branch is 0x1a.

Rs is the first source register and Rt is the second source register. Rs is the destination register.

Imm is an 8-bit immediate. The immediate is signed in addi and unsigned in addui, bn, bx, bp, bz, jal, and j. For the addition instructions with an immediate (i.e., addi and addui), the bit Subop controls whether the immediate is sign or zero extended. When Subop is 0, then Imm is zero extended to implement the addui instruction. Otherwise, Imm is sign extended to implement addi. Imm is zero extended for branches and jump (j).

In branches, jal and j, Imm specifies the target address. Both branches and jumps use absolute addressing for the target address. So, for example, if a branch is taken and Imm is 0x1a, then the target address for the branch is 0x1a.

## Sub-Circuits:

### The Program Counter
The program counter is a register that holds an 8-bit instruction address. It specifies the instruction to fetch from the instruction memory. It is updated every clock cycle with PC + 1 or the target address of a taken branch (or jump).

### The Register File
For the general-purpose registers, µMIPS has 8 registers. An R-format instruction can read 2 source registers and write 1 destination register. Thus, the register file has 2 read ports and 2 write ports (the second write port is used for multiplication and division.) 

### The Arithmetic Logic Unit
The ALU is used to execute the arithmetic instructions. It may also be used to do branch comparison. The ALU is capable of performing AND, NOR, Addidtion, Subtraction, Multiplcation, Division, Logical Right and Left shifts, and greater than, less than, and equal to 0 comparisons.  

### Field Splitter
The field splitter takes in the instruction from ROM and parses it into the opcode, $rs, $rt, and immediate value. 

### Instruction Decoder
The decoder takes the opcode from the field splitter and generates the appropriate control signals to allow data to flow to the appropriate components inside the CPU. 

### LED Display
Displays the contents of the register specified in the ```put $rs``` command. 

### The Compiler


