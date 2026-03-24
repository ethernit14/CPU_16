# Fibonacci sequence
# R1 = current, R2 = next, R3 = temp, R4 = counter, R5 = limit
LDI R1, 0        # current = 0
LDI R2, 1        # next = 1
LDI R4, 0        # counter = 0
LDI R5, 10       # limit = 10 iterations
# loop:
ADD R3, R1, R2   # temp = current + next
NOP
ADD R1, R2, R0   # current = next
NOP
ADD R2, R3, R0   # next = temp
ADDI R4, R4, 1   # counter++
BLT R4, R5, -7   # if counter < 10, loop back
NOP              # done! R2 = 10th fibonacci number