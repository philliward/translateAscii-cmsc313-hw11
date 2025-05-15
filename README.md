Phillip Ward

UMBC CMSC 313

Tues/Thurs 2:30 - 3:45 | 2025

Homework 11

### TranslateAscii

A program that takes in pure hexadecimal input and dumps it as readable ASCII.

### Instructions

To run, assemble and load using these commands:
`nasm - f elf32 -o translateAscii.o translateAscii.asm
ld -m elf_i386 -o translateAscii translateAscii.o`

Then, call it using this command:
`./translateAscii`
