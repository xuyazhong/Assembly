start:
mov ax, 0x7c0
mov ds, ax
mov bx, string

mov cx, string_end - string

mov ax, 0xb800
mov es, ax
mov si, 0

putc:
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    inc bx
    loop putc

inputc:
    mov ah, 0x0
    int 0x16

    mov ah, 0x0e
    int 0x10

    jmp inputc

    jmp $

string  db 'hello, this is test int function', 0x0d, 0x0a
        db 'Hello, friend!',0x0d,0x0a
        db 'This simple procedure used to demonstrate '
        db 'the BIOS interrupt.',0x0d,0x0a
        db 'Please press the keys on the keyboard ->'
string_end:

times 510-($-$$) db 0
                  db 0x55,0xaa