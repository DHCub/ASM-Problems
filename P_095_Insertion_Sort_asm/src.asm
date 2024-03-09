%include "io.inc"

section .data
    n dd 10
    array dd 5, 3, 8, 1, 9, 99, 11, 11, 11, 11, 11
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    call SHOW_ARRAY
    NEWLINE

    call INSERTION_SORT_ARRAY
    
    call SHOW_ARRAY
    
    xor eax, eax
    ret
    
INSERTION_SORT_ARRAY:
    pushA

    
    mov ebx, [n] ; for efficiency
    mov ecx, 1
    cmp ecx, ebx
    je END1 ; if there is only one element, nothing to do
    
    WHILE1:
         mov eax, [array + ecx*4 - 4]
         cmp eax, [array + ecx*4] ; compare arr[i - i] w/ arr[i]
         
         jge NXT_CYCLE
         
         push ecx ; j = i
         INSERT_ORDERED1:
            mov edx, [array + ecx*4]
            mov [array + ecx*4 - 4], edx
            mov [array + ecx*4], eax
            
            dec ecx
            je END_INSERT_ORDERED1 ; we've reached the beginning of the array
            
            mov eax, [array + ecx*4 - 4] ; store arr[j - 2] in eax
            cmp eax, [array + ecx*4]
            jge END_INSERT_ORDERED1
            jmp INSERT_ORDERED1
           
         END_INSERT_ORDERED1:
         pop ecx
         
         NXT_CYCLE:
            inc ecx
            cmp ecx, ebx
            je END1
            jmp WHILE1
         
    
    
    
    END1:
    popA
    ret
    
SHOW_ARRAY:
    push ecx
    
    mov ecx, 0
    WHILE2:
    
        PRINT_UDEC 4, [array + ecx*4]
        NEWLINE
        inc ecx
        cmp ecx, [n]
        jl WHILE2
    
    
    pop ecx
    ret