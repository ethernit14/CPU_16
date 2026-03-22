# Zenith TX26 — 16-bit CPU

A 16-bit CPU designed from scratch in Verilog by Doruk (2026).

## Architecture
- 16-bit instruction width
- 8 general purpose registers (R0-R7)
- R0 is hardwired to 0
- 16 instructions
- Harvard architecture (separate instruction and data memory)
- Single-cycle execution

## Instruction Formats

### R-type (register operations)
```
[15:12] opcode | [11:9] rd | [8:6] ra | [5:3] rb | [2:0] reserved
```

### I-type (immediate operations)
```
[15:12] opcode | [11:9] rd | [8:6] ra | [5:0] immediate
```

### J-type (jump operations)
```
[15:12] opcode | [11:0] immediate
```

## Instruction Set

| Opcode | Type | Instruction | Operation |
|--------|------|-------------|-----------|
| 0000 | R | ADD rd, ra, rb | rd = ra + rb |
| 0001 | R | SUB rd, ra, rb | rd = ra - rb |
| 0010 | R | AND rd, ra, rb | rd = ra & rb |
| 0011 | R | OR rd, ra, rb | rd = ra \| rb |
| 0100 | R | XOR rd, ra, rb | rd = ra ^ rb |
| 0101 | R | SHL rd, ra | rd = ra << 1 |
| 0110 | R | SHR rd, ra | rd = ra >> 1 |
| 0111 | R | SLT rd, ra, rb | rd = (ra < rb) ? 1 : 0 |
| 1000 | I | LDI rd, imm | rd = imm |
| 1001 | I | ADDI rd, ra, imm | rd = ra + imm |
| 1010 | I | LD rd, ra, imm | rd = mem[ra + imm] |
| 1011 | I | ST ra, rb, imm | mem[ra + imm] = rb |
| 1100 | J | JMP imm | pc = imm |
| 1101 | J | BEQ ra, rb, imm | if ra==rb: pc = pc + imm |
| 1110 | J | BLT ra, rb, imm | if ra<rb: pc = pc + imm |
| 1111 | - | NOP | do nothing |

## Modules
| File | Description | Status |
|------|-------------|--------|
| alu.v | Arithmetic Logic Unit |
| program_counter.v | Program Counter |
| sign_extender.v | 6-bit to 16-bit sign extender |
| register_file.v | 8x16-bit register file |
| instruction_mem.v | Instruction ROM |
| data_memory.v | Data RAM |
| instruction_decoder.v | Instruction Decoder |
| control_unit.v | Control Unit FSM |
| cpu_top.v | Top Level |

## Tools
- Icarus Verilog — simulation
- GTKWave — waveform viewing
- VS Code — development