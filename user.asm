; SECTION header vstart=0                     ;定义用户程序头部段 
;     program_length  dd program_end          ;程序总长度[0x00]
    
;     ;用户程序入口点
;     code_entry      dw start                ;偏移地址[0x04]
;                     dd section.code.start ;段地址[0x06] 
    
;     realloc_tbl_len dw (header_end-code_1_segment)/4
;                                             ;段重定位表项个数[0x0a]
    
;     ;段重定位表           
;     code_1_segment  dd section.code.start ;[0x0c]
;     ; code_2_segment  dd section.code_2.start ;[0x10]
;     ; data_1_segment  dd section.data_1.start ;[0x14]
;     ; data_2_segment  dd section.data_2.start ;[0x18]
;     ; stack_segment   dd section.stack.start  ;[0x1c]
    
;     header_end:   

; SECTION code vstart=0 align=16                     ;定义用户程序头部段 
; start:                                             ;程序入口点
mov ax, 0xb800
mov es, ax
mov si, 0

mov al, 0x70

mov byte [es: si], 'o'
inc si
mov [es: si], al
inc si
mov byte [es: si], 'k'
inc si
mov [es: si], al
inc si
mov byte [es: si], '.'
inc si
mov [es: si], al

jmp $

; SECTION trail align=16
; program_end: