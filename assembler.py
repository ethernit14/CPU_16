#!/usr/bin/env python3
"""
CPU16 Assembler
Converts assembly code to 16-bit machine code for the Zenith TX26 CPU.
"""

import sys
import re

# Instruction opcodes
opcodes = {
    'ADD':  '0000',
    'SUB':  '0001',
    'AND':  '0010',
    'OR':   '0011',
    'XOR':  '0100',
    'SHL':  '0101',
    'SHR':  '0110',
    'SLT':  '0111',
    'LDI':  '1000',
    'ADDI': '1001',
    'LD':   '1010',
    'ST':   '1011',
    'JMP':  '1100',
    'BEQ':  '1101',
    'BLT':  '1110',
    'NOP':  '1111'
}

# Register mapping
registers = {
    'R0': '000', 'R1': '001', 'R2': '010', 'R3': '011',
    'R4': '100', 'R5': '101', 'R6': '110', 'R7': '111',
}

def parse_register(reg_str):
    """Convert register string to 3-bit binary."""
    if reg_str not in registers:
        raise ValueError(f"Invalid register: {reg_str}")
    return registers[reg_str]

def parse_immediate(imm_str, bits):
    """Parse immediate value and convert to binary."""
    if imm_str.startswith('0x'):
        value = int(imm_str, 16)
    elif imm_str.startswith('0b'):
        value = int(imm_str, 2)
    else:
        value = int(imm_str)

    # Check range
    max_val = (1 << bits) - 1
    min_val = -(1 << (bits - 1))

    if value < min_val or value > max_val:
        raise ValueError(f"Immediate value {value} out of range for {bits}-bit field")

    # Convert to unsigned binary representation
    if value < 0:
        value = (1 << bits) + value

    return format(value, f'0{bits}b')

def assemble_instruction(line, line_num):
    """Assemble a single instruction line."""
    line = line.strip()
    if not line or line.startswith('#'):
        return None

    # Remove comments
    line = line.split('#')[0].strip()

    # Split instruction and operands
    parts = re.split(r'[,\s]+', line)
    mnemonic = parts[0].upper()

    if mnemonic not in opcodes:
        raise ValueError(f"Unknown instruction: {mnemonic}")

    opcode = opcodes[mnemonic]

    # R-type instructions: opcode rd, ra, rb
    if mnemonic in ['ADD', 'SUB', 'AND', 'OR', 'XOR', 'SLT']:
        if len(parts) != 4:
            raise ValueError(f"R-type instruction {mnemonic} requires 3 operands")
        rd = parse_register(parts[1])
        ra = parse_register(parts[2])
        rb = parse_register(parts[3])
        instruction = opcode + rd + ra + rb + '000'  # 3 reserved bits

    # Shift instructions: opcode rd, ra (rb ignored)
    elif mnemonic in ['SHL', 'SHR']:
        if len(parts) != 3:
            raise ValueError(f"Shift instruction {mnemonic} requires 2 operands")
        rd = parse_register(parts[1])
        ra = parse_register(parts[2])
        instruction = opcode + rd + ra + '000000'  # rb and reserved bits

    # I-type instructions: opcode rd, ra, imm (6-bit immediate)
    elif mnemonic in ['ADDI', 'LD', 'ST']:
        if len(parts) != 4:
            raise ValueError(f"I-type instruction {mnemonic} requires 3 operands")
        rd = parse_register(parts[1])
        ra = parse_register(parts[2])
        imm = parse_immediate(parts[3], 6)
        instruction = opcode + rd + ra + imm

    # LDI instruction: opcode rd, imm (6-bit immediate, ra=0)
    elif mnemonic == 'LDI':
        if len(parts) != 3:
            raise ValueError("LDI instruction requires 2 operands")
        rd = parse_register(parts[1])
        imm = parse_immediate(parts[2], 6)
        instruction = opcode + rd + '000' + imm  # ra = R0

    # J-type instructions: opcode imm (12-bit immediate)
    elif mnemonic in ['JMP']:
        if len(parts) != 2:
            raise ValueError(f"J-type instruction {mnemonic} requires 1 operand")
        imm = parse_immediate(parts[1], 12)
        instruction = opcode + imm

    # Branch instructions: opcode imm (12-bit immediate) - ra, rb checked by control unit
    elif mnemonic in ['BEQ', 'BLT']:
        if len(parts) != 4:
            raise ValueError(f"Branch instruction {mnemonic} requires 3 operands")
        ra = parse_register(parts[1])  # Not used in encoding, but validate
        rb = parse_register(parts[2])  # Not used in encoding, but validate
        imm = parse_immediate(parts[3], 12)
        instruction = opcode + imm

    # NOP
    elif mnemonic == 'NOP':
        if len(parts) != 1:
            raise ValueError("NOP requires no operands")
        instruction = opcode + '000000000000'  # 12 zeros

    return instruction

def main():
    if len(sys.argv) != 2:
        print("Usage: python assembler.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = input_file.rsplit('.', 1)[0] + '.mem'

    instructions = []

    try:
        with open(input_file, 'r') as f:
            for line_num, line in enumerate(f, 1):
                try:
                    instr = assemble_instruction(line, line_num)
                    if instr is not None:
                        instructions.append(instr)
                except ValueError as e:
                    print(f"Error on line {line_num}: {e}")
                    sys.exit(1)

        # Write output in hex format for Verilog ROM initialization
        with open(output_file, 'w') as f:
            for instr in instructions:
                f.write(instr + '\n')
            for i in range(256 - len(instructions)):
                f.write('1111000000000000\n')

        print(f"Successfully assembled {len(instructions)} instructions to {output_file}")

    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found")
        sys.exit(1)

if __name__ == "__main__":
    main()


