%include "io.inc"

section .data
    A db 16
    n db 6
    m db "1277FF"


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor esi, esi ; we will store the result here
    
    xor eax, eax
    mov al, [A]
    mov edi, eax
    
    xor ecx, ecx
    mov cl, [n]
    cmp cl, 0
    je END
    dec cl
    
    
    mov eax, 1 ; this will be our A^i
    xor ebx, ebx
    
    
    WHILE:
        mov bl, [m + ecx]
        call getValue_bl
        
        push eax
        
        mul ebx
        add esi, eax
        
        pop eax
        
        mul edi
        
        
        dec cl
        cmp cl, 0
        jnl WHILE
        
    
    END:
        PRINT_UDEC 4, esi
        
    xor eax, eax
    ret
     
getValue_bl:
    push eax
    
    mov al, bl
    sub al, '0'
    cmp al, 9
    jle END11
    sub bl, 'A'
    add bl, 10
    jmp END12
    
    
    END11:
        mov bl, al
        
    END12:
    
    pop eax
    ret