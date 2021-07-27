SECTION header vstart=0                     ;定义用户程序头部段 
    ; program_length  dd program_end          ;程序总长度[0x00]
    
    ;用户程序入口点
    code_entry      dw start                ;偏移地址[0x04]
                    dd section.main.start ;段地址[0x06] 
    
    realloc_tbl_len dw (header_end-data_1_segment)/4 ;段重定位表项个数[0x0a]
    ;段重定位表           
    data_1_segment  dd section.data1.start ;[0x0c]
    data_2_segment  dd section.data2.start ;[0x10]
    data_3_segment  dd section.data3.start ;[0x14]
    
    header_end:                

section data1 align=16 vstart=0
lba db 0x55, 0xf0
section data2 align=16 vstart=0
lbb db 0x00, 0x99
lbc dw 0xf000
section data3 align=16 vstart=0
lbd dw 0xfff0, 0xfffc

section main align=16 vstart=0
start:
    mov ax, lba
    mov ax, lbb
    mov ax, lbc
    mov ax, lbd

jmp $

times (510-($-$$)) db 0

db 0x55, 0xaa