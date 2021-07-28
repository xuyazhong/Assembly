read_disk_start equ 100 

mov ax, 0x07c0
mov ds, ax

;输入：DI:SI=起始逻辑扇区号
xor di, di
mov si, read_disk_start

;输出：ES:BX=目标缓冲区地址
mov ax, [mem_cs]
mov dx, [mem_ip]

mov es, ax
mov bx, dx
call read_hard_disk_0

; jmp far [mem_cs]
jmp 0x1000:0

read_hard_disk_0:
    mov al, 1		;读取/写入的扇区数目
    mov ch, 0		;磁道号
    mov cl, 38		;（起始）扇区号
    mov dh, 1		;磁头号（对于软盘来说就是面号，因为一个面用一个磁头来读写）
    mov dl, 0x80		;驱动器号：	软驱从 0 开始：  0，软驱 A ； 1，软驱 B。
                                ; 硬盘从 80h 开始：  80h，硬盘 C ； 81h，硬盘 D 。
    mov ah, 0x2		;int 13h 的功能号（常用的：2 表示读扇区；3 表示写扇区）

    int 0x13
    jnc loadSuccess
 
    mov si, string_error
    call putc
    jmp load_end
 
loadSuccess:
    mov si, string_success
    call putc

load_end:
    ret

putc:
    mov ah, 0x0e
    mov al, [si]
    test al, al
    je return
    int 0x10
    inc si
    jmp putc
return:
    ret

mem_cs   dw 0x1000
mem_ip   dw 0x0
string_ok: db 'ok',0x0d,0x0a, 0
string_error: db 'read error', 0x0d, 0x0a, 0
string_success: db 'read success', 0x0d, 0x0a, 0
string_end: db 'progress end', 0x0d, 0x0a, 0

times 510-($-$$) db 0
                 db 0x55,0xaa