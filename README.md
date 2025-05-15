Phillip Ward

UMBC CMSC 313

Tues/Thurs 2:30 - 3:45 | 2025

Homework 11

### TranslateAscii

A program that takes in pure hexadecimal input and dumps it as readable ASCII. Input is declared in the inputBuf buffer and inputSize value.

The program, when run using its current output, prints the following:
```
83 6A 88 DE 9A C3 54 9A
```

### Instructions

First, download the file named `translateAscii.asm` from the repository. Next, place it into a folder, then run the following commands in the terminal to assemble and load the program:

```
nasm -f elf32 -o translateAscii.o translateAscii.asm
```

```
ld -m elf_i386 -o translateAscii translateAscii.o
```

Then, call it using this command:

```
./translateAscii
```
