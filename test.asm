section .data
    newline db '1'
section .bss
    buffer: resb 64 ; reserve array of 64 bytes
    wordvar: resw 1 ; reserve a word
section .text 
    global _start
_start:
    ; utiliser la pile pour cela 
    ; RSP est le registre de pile
    lea rdi, [buffer]
    call initArray
    ; pas d'argument passé à la pile donc pas de remise en état initial
    ;sauvegarde de contexte pour parcourir le tableau
    lea rdi, [buffer]
    mov cx, 3
    push cx
    call paroursArray
    add rsp,2
    ; Appel système pour quitter avec le code de sortie 0
    mov eax, 60         ; Code pour l'appel système "exit"
    xor edi, edi        ; Code de sortie 0
    syscall             ; Appel système

initArray:
    add rsp, 2 ; déclare une variable i
    mov word [rsp], 0 ; initialise a 0 cette variable

tq:    
    cmp word [rsp],64
    jae fintq

    mov ax, word [rsp]
    mov word [rdi], ax

    add rdi, 2
    inc word [rsp]
    jmp tq
fintq:
    sub rsp, 2
    ret


paroursArray:
    