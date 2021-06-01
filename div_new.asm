jmp start

labs: db 'L', 0x07, 'a', 0x07, 'b', 0x07, 'e', 0x07, 'l', 0x07, ' ', 0x07, 'b', '0x07'

start:

mov ax, 0xb800
mov es, ax
mov di, 0

mov ax, 0x07c0
mov ds, ax
mov si, labs

mov cx, 0xc

; std
cld

rep movsb

mov ax, 65535
mov si, 10
mov bx, datas
mov cx, 5

func:
    xor dx, dx
    div si
    add dl, 0x30
    mov [bx], dl
    inc bx
    loop func

mov cx, 5
mov bx, datas
add bx, cx
show:
    dec bx
    mov al, [bx]
    mov byte [es: di], al
    inc di
    mov byte [es: di], 0x07
    inc di
    loop show

jmp $

datas db 0, 0, 0, 0, 0

times (510-($-$$)) db 0

db 0x55, 0xaa