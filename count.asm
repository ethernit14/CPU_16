# Counting from 0 to 10
LDI R1, 0        # pc=0: counter = 0
LDI R2, 10       # pc=1: limit = 10
ADDI R1, R1, 1   # pc=2: counter++
BLT R1, R2, -2   # pc=3: if R1<10 jump to pc=2
NOP              # pc=4: done, R1=10