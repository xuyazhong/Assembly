jmp start

message: db 'abcdefghijklmnopqrstuvwxyz'

start:

    mov ax, 0xb800
    mov es, ax
    mov cx, start-message
    mov si, 0

    mov ax, 0x7c0
    mov ds, ax
    mov di, message

showdb:
    mov al, [ds: di]
    inc di
    mov [es: si], al
    inc si
    mov byte [es: si], 0x07
    inc si
    loop showdb

mov ax, 0
mov ss, ax
mov sp, 0

mov ax, 0x7c0
mov ds, ax
mov di, message

mov cx, start-message

reverse:
    mov al, [ds: di]
    inc di
    xor ah, ah
    push ax
    loop reverse    

mov di, message
popback:
    pop ax
    mov [ds: di], al
    inc di
    cmp sp, 0
    jne popback


    mov ax, 0xb800
    mov es, ax
    mov cx, start-message
    mov si, 0xa0

    mov ax, 0x7c0
    mov ds, ax
    mov di, message

showdb2:
    mov al, [ds: di]
    inc di
    mov [es: si], al
    inc si
    mov byte [es: si], 0x07
    inc si
    loop showdb2

jmp $

times (510-($-$$)) db 0

db 0x55, 0xaa