section .data
    chocolat db 12
    newline db 10

section .text
    global _start

_start:

    mov rax, chocolat
    add rax, 4
    ; tenter de charger l'adresse mémoire de chocolat dans un registre
    mov rax, [chocolat]

    ; Terminer le programme
    mov eax, 1
    xor ebx, ebx
    int 0x80

function_retour:

    ADD rsp,2
    
