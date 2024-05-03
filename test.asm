section .data
    max: dw 1
    arrayList: dw 1,3,8,20,90,11,23,-1 ; déclare un tableau dans la mémoire
section .bss
    buffer: resw 64 ; reserve array of 64 bytes
section .text 
    global _start
_start:
    
    lea rdi, arrayList
    call find_max
    mov max, cx
    ;on affiche maintenant le max

    mov eax, 4         ; Code pour l'appel système "write"
    mov ebx, 1         ; Descripteur de fichier (stdout)
    mov ecx, max       ; afficher le nombre maximal dans le vecteur
    mov edx, 1         ; Longueur de la chaîne (1 octet)
    int 0x80           ; Appel système

    ; Appel système pour quitter avec le code de sortie 0
    mov eax, 60         ; Code pour l'appel système "exit"
    xor edi, edi        ; Code de sortie 0
    syscall             ; Appel système

find_max:
    mov [rsp-8], rax ; on sauvegarde le contexte pour al
    sub rsp, 8 ; on met la pile a jour
    mov al, 0 ; on initialise alors le registre al

    ; on initialise la variable max qui contiendra la valeur
    mov [rsp-2], ax
    sub rsp, 2
    mov ax, 0

while:
    cmp word [rdi+rax], -1 
    je finwhile

if:
    cmp ax, [rdi+rax]
    jbe finif

    mov ax, [rdi+rax]
finif:

    inc al
    jmp while
finwhile:

    mov rax, qword [rsp]
    mov cx,ax
    mov ax, word [rsp+8]
    add rsp, 10
    ret
