read_disk_start equ 100 

mov ax, 0x07c0
mov ds, ax

;输入：DI:SI=起始逻辑扇区号
;输出：ES:BX=目标缓冲区地址
xor di, di
mov si, read_disk_start

mov ax, [mem_src]
mov dx, [mem_src+0x2]
mov bx, 16
div bx
mov es, ax
mov bx, dx
call read_hard_disk_0

jmp far [mem_cs]
; jmp far [bx]
; jmp 0x1000:0

read_hard_disk_0:
                    ;从硬盘读取一个逻辑扇区
                    ;输入：DI:SI=起始逻辑扇区号
                    ;输出：ES:BX=目标缓冲区地址
    mov dx,0x1f2
    mov al,1
    out dx,al                       ;读取的扇区数

    inc dx                          ;0x1f3
    mov ax,si
    out dx,al                       ;LBA地址7~0

    inc dx                          ;0x1f4
    mov al,ah
    out dx,al                       ;LBA地址15~8

    inc dx                          ;0x1f5
    mov ax,di
    out dx,al                       ;LBA地址23~16

    inc dx                          ;0x1f6
    mov al,0xe0                     ;LBA28模式，主盘
    or al,ah                        ;LBA地址27~24
    out dx,al

    inc dx                          ;0x1f7
    mov al,0x20                     ;读命令
    out dx,al

  .waits:
    in al,dx
    and al,0x88
    cmp al,0x08
    jnz .waits                      ;不忙，且硬盘已准备好数据传输 

    mov cx,256                      ;总共要读取的字数
    mov dx,0x1f0
  .readw:
    in ax,dx
    mov [es: bx], ax
    add bx, 2
    loop .readw

    ret
mem_cs   dw 0x0
mem_ip   dw 0x1000

mem_test dd 0x9999
mem_src  dd 0x10000              ;内存起始地址
times 510-($-$$) db 0
                 db 0x55,0xaa