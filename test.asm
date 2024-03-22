section .data
    chocolat db 12
    newline db 10

section .text
    global _start

_start:

    mov rax, 3
    add rax, 4


    ; Terminer le programme
    mov eax, 1
    xor ebx, ebx
    int 0x80
    ret
