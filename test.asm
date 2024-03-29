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
    call plusGrandEntier
    ; Appel système pour quitter avec le code de sortie 0
    mov eax, 60         ; Code pour l'appel système "exit"
    xor edi, edi        ; Code de sortie 0
    syscall             ; Appel système


plusGrandEntier:
    add rsp, 2 ; déclare une variable i
    mov word [rsp], 0 ; initialise a 0 cette variable

tq:    
    cmp word [rsp],64
    jae fintq

    mov ax, word [rsp]
    mov word [rdi], ax

    ; Afficher le saut de ligne
    mov eax, 4         ; Code pour l'appel système "write"
    mov ebx, 1         ; Descripteur de fichier (stdout)
    mov ecx, newline   ; Adresse de la chaîne de caractères contenant le saut de ligne
    mov edx, 1         ; Longueur de la chaîne (1 octet)
    int 0x80           ; Appel système

    add rdi, 2
    inc word [rsp]
    jmp tq
fintq:
    sub rsp, 2
    ret
