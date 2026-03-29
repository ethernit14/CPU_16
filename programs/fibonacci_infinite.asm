# Infinite Fibonacci loop for Zenith TX26
# R1 = current, R2 = next, R3 = temp
LDI R1, 0        # pc=0: R1 = 0
LDI R2, 1        # pc=1: R2 = 1
NOP              # pc=2: loop starts here
ADD R3, R1, R2   # pc=3: temp = R1 + R2
NOP              # pc=4
ADD R1, R2, R0   # pc=5: R1 = R2
NOP              # pc=6
ADD R2, R3, R0   # pc=7: R2 = temp
JMP 2            # pc=8: jump back to pc=2