mov ax, 1024
mov bx, -512
idiv bx

mov cx, 1024
neg cx

times (510-($-$$)) db 0

db 0x55, 0xaa