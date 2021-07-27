mov ax, 0xb800
mov es, ax
mov si, 0

mov ax, string
mov ds, ax
mov bx, 0

mov cx, string_end-string

mov ah, 0x70
show:
    mov al, [bx]
    mov [es: si], ax
    add si, 2
    inc bx
    loop show
jmp $
string db 'user mode OK.'
string_end:
