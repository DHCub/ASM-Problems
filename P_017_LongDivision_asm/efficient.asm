%include "io.inc"

section .data
    a db 255
    b db 17
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    cmp BYTE [b], 0
    je FALSE
    
    cmp BYTE [a], 0
    je TRUE


    mov cl, [a]
    cmp cl, [b]
    jc FALSE ; we use jc for unsigned comparison
   
    ; we will take [b] and shift it left to meet [a] on the first bit, then substract and shift it right
    ; as with long division, but without keeping the quotient, this will produce the remainder in O(n) time
    ; where n is the amount of bits in the input, subsequent substractions would take O(2^n) time
   
    mov bl, [a]
    call LEADING_ZEROES_bl
    mov cl, bl
    
    mov bl, [b]
    call LEADING_ZEROES_bl
    sub bl, cl
    
    mov al, [b]
    call SHIFTL_al_BY_bl ; in al, there is a shifted version of the divisor
    mov cl, bl ; we store by how much the divisor was shifted 
    
    mov dl, [a] ; store the value of a in dl for work
    
    WHILE:
        cmp dl, al
        jc NSUB ; jc for unsigned cmp
        
        sub dl, al
        cmp dl, 0
        je TRUE
        
        NSUB:
        shr al, 1
        dec cl
        cmp cl, 0
        jl FALSE
        jmp WHILE
    
    

    TRUE:
        PRINT_STRING "T"
        jmp END
    FALSE:
        PRINT_STRING "F"
    
    END:
    xor eax, eax
    ret    

LEADING_ZEROES_bl:
    push ecx
    
    mov ecx, 0
    WHILE1:
        shl bl, 1
        jc END1
        inc cl
        jmp WHILE1
    
    
    END1:
    mov bl, cl
    pop ecx
    ret
    
SHIFTL_al_BY_bl:
    push ebx
    cmp bl, 0
    je END2
    
    WHILE2:
        shl al, 1
        dec bl
        jnz WHILE2
    
    END2:
    pop ebx
    ret
    