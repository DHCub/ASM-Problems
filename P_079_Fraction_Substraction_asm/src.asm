%include "io.inc"

section .data
    a dw 2
    b dw 6
    c dw 3
    d dw 15
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    xor ecx, ecx
    mov cx, [b]
    mov bx, [d]
    call gcd_cx_bx_to_cx
    
    xor eax, eax ; clear registers
    xor edx, edx
    mov ax, [d]
    div cx ; put d/(b, d) in ax
    mov si, [a] 
    mul si ; put a*d/(b, d) in dx:ax
    shl edx, 16
    add eax, edx ; we have a*d/(b, d) in eax
    mov esi, eax ; we have x in esi
    
    xor eax, eax ; clear registers
    xor edx, edx
    mov ax, [b]
    div cx ; put b/(b, d) in ax
    mov di, [c] 
    mul di ; put c*b/(b, d) in dx:ax
    shl edx, 16
    add eax, edx ; we have c*b/(b, d) in eax
    mov edi, eax ; we have y in edi
    
    sub esi, edi ; we have x - y in esi
    
    xor eax, eax ; clear registers
    xor edx, edx
    mov ax, [b]
    ; d is still in bx
    mul bx
    shl edx, 16
    add eax, edx ; we have b*d in eax
    div ecx
    
    PRINT_DEC 4, esi
    NEWLINE
    PRINT_DEC 4, eax
    

    xor eax, eax
    ret

gcd_cx_bx_to_cx:
    push eax
    push edx
    push ebx
    
    cmp cx, bx
    je END2
    jc INVERSE_CALL2
    
    cmp bx, 0
    je END2
    
    WHILE2:
        mov ax, cx
        xor edx, edx
        div bx
        
        cmp dx, 0
        jne GCD_NOT_FOUND2
        
        mov cx, bx
        jmp END2
        
        
        GCD_NOT_FOUND2:
        mov cx, bx
        mov bx, dx
        jmp WHILE2
    
    INVERSE_CALL2:
        xchg cx, bx
        
        call gcd_cx_bx_to_cx
    
    
    END2:
    pop ebx
    pop edx
    pop eax
    ret