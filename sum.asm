jmp start

message: db '1+2+3+4+.....+98+99+100='

start:

mov cx, start-message

mov ax, 0x07c0
mov ds, ax
mov si, message

mov ax, 0xb800
mov es, ax
mov di, 0

show:
    mov dl, [ds: si]
    mov [es: di], dl
    inc si
    inc di
    mov byte [es: di], 0x07
    inc di
    loop show

mov cx, 100
mov ax, 0
sum:
    add ax, cx
    loop sum

mov cx, 0x07c0
mov ss, cx
mov sp, 0

mov bx, 10
mov cx, 0

subdiv:
    xor dx, dx
    div bx
    add dl, 0x30
    push dx
    inc cx
    cmp ax, 0
    jne subdiv
;ds: si
;es: di

shownumber:
    pop dx
    mov [es: di], dl
    inc di
    mov byte [es: di], 0x07
    inc di
    cmp sp, 0
    jne shownumber

jmp $

times (510-($-$$)) db 0

db 0x55, 0xaa