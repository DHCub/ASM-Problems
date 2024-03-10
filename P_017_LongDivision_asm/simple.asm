%include "io.inc"

section .data
    a db 26
    b db 13
    
section .text
global CMAIN
CMAIN:
    cmp BYTE [b], 0
    je FALSE
    
    cmp BYTE [a], 0
    je TRUE
    
    xor eax, eax
    mov al, [a]
    cmp al, [b]
    jc FALSE
    
    xor ebx, ebx
    mov bl, [b]
    
    WHILE:
        sub al, bl
        jz TRUE
        cmp al, bl
        jc FALSE
        jmp WHILE
    
    TRUE:
        PRINT_STRING "T"
        jmp END 
    
    FALSE:
        PRINT_STRING "F"
    
    END:
    
    xor eax, eax
    ret