;; 4-30-2025 Phillip Ward
;; CMSC 313 | Mon-Wen 2:30-3:45 | HW 11

SECTION .data
inputBuf	db	0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputSize   dd  8

SECTION .bss
outputBuf   resb 80

SECTION .text
global	_start



;; Accepts an argument in edx, which is the byte to be turned into an ASCII character.
;; Only accesses the four least significant bits.
;; Returns its value in ebx.
translateByte:
        mov ecx, edx
        and ecx, 0x0F           ;; Masks the input stored at ecx to the lowest 4 bits.
        mov ebx, 0x30           ;; ebx is the return register. This is initialized as 30.
        cmp ecx, 0x09
        jle exitTranslate
        or ebx, 0x37            ;; If hex value exceeds 9, change the value in ebx to 37.
exitTranslate:
        add ebx, ecx            ;; Add the masked input to ebx, which is holding the ascii offset
                                ;; for the given hex value.
        ret



_start:
        mov eax, [inputSize]    ;; eax holds the input size, which is decremented until it reaches
        mov esi, inputBuf       ;; zero over the course of the program.
        mov edi, outputBuf
        jmp process

                                ;; step performs a step of the iteration. Each byte is seperated
                                ;; into its most and least significant bits, then those are passed
                                ;; to the translateByte function before being added to the output buffer.
step:
        mov edx, [esi]
        shr edx, 4              ;; The four most significant bits of the byte are used first.
        call translateByte

        mov [edi], ebx
        inc edi

        mov edx, [esi]
        call translateByte

        mov [edi], ebx
        inc edi

        mov byte [edi], 0x20    ;; A space is added to the output buffer after every step.
        inc edi

        inc esi

process:
        dec eax                 ;; eax holds the current step of the iteration process.
        cmp eax, 0              ;; Once it reaches zero, the iteration ends.
        jge step

term:
        mov byte [edi], 0x0A    ;; 0A and 0D are added to the end of the buffer to properly align the text.
        inc edi
        mov byte [edi], 0x0D
        inc edi

        mov edx, [inputSize]    ;; The actual length of the output buffer is calculated.
        shl edx, 1              ;; (3 characters per byte * number of bytes) + 2 extra characters.
        add edx, [inputSize]
        add edx, 2

        mov ecx, outputBuf      ;; Performs the print instruction using outputBuf and the result of our edx calculation.
        mov ebx, 1
        mov eax, 4
        int 80h

	    mov ebx, 0
	    mov eax, 1
	    int 80h