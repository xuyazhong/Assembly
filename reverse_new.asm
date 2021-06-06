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

;交换
mov ax, 0x7c0
mov ds, ax
; mov ax, cs
; mov ds, ax
mov bx, message
mov di, start-1

move:
    mov al, [bx]
    mov ah, [di]
    mov [di], al
    mov [bx], ah
    add bx, 1
    sub di, 1
    cmp bx, di
    jl move

mov ax, 0x07c0
mov ds, ax
mov di, message

mov ax, 0xb800
mov es, ax
mov si, 0xa0
mov cx, start-message

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