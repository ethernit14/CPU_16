# Test program for CPU16
ADD R1, R0, R0    # R1 = 0
LDI R2, 10        # R2 = 10
ADDI R3, R2, 8    # R3 = 18
ST R0, R3, 0      # mem[R0 + 0] = R3
LD R4, R0, 0      # R4 = mem[0] = 18
BEQ R1, R4, 1     # if R1 == R4, skip next instruction
JMP 0             # loop forever
NOP               # do nothing until 256