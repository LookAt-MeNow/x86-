org 0x7c00 ; 0x7c00是BIOS将要加载的地址
mov ax,3   ; 设置显存模式
int 0x10   ; 调用BIOS中断

mov ax,0   ; 设置段寄存器  
mov ds,ax  ; 设置ds寄存器
mov ss,ax  ; 设置ss寄存器
mov sp,0x7c00 ; 设置栈指针
mov dx,0x1f2  ; 设置硬盘扇区数
mov al,1   ; 设置读取扇区数
out dx,al  ; 写入端口,读取一个扇区
mov al,0   ; 设置读取扇区的低8位
inc dx; 0x1f3 ;0x1f3是读取扇区的低8位
out dx,al  ; 写入端口
inc dx; 0x1f4 ;0x1f4是读取扇区的中8位
out dx,al   ; 写入端口
inc dx; 0x1f5 ;0x1f5是读取扇区的高8位
out dx,al   ; 写入端口
inc dx;     ; 将dx指向0x1f6
mov al,0b1110_0000 ; LBA模式
out dx,al   ; 写入端口
inc dx;0x1f7 
mov al,0x20 ;读硬盘
out dx,al   ; 写入端口
.check_read_state: ;然后开始读取状态
    nop
    nop 
    nop ;加延迟 ATA的要求

    in al,dx ;读取端口 dx --> 1f7
    and al,0b1000_1000 ; 读取状态,判断是否读取完成
    cmp al,0b0000_1000 ; 硬盘是否读取完成,如果没有完成,则继续读取
    jnz .check_read_state ;
mov ax,0x100 ;要读取的内存地址
mov es,ax    ;设置段寄存器
mov di,0     
mov dx,0x1f0 ;1f0是读写的端口

read_loop: ;循环读取
    nop
    nop
    nop

    in ax,dx ;读取端口 dx --> 1f0
    mov [es:di],ax ;将读取的数据写入内存
    add di,2    ;di指针加2
    cmp di,512  ;判断是否读取完成
    jnz read_loop ;如果没有读取完成,则继续读取

;---------------------------------------
mov dx,0x1f2
mov al,1    
out dx,al
mov al,2    ;需要写入的扇区
inc dx; 0x1f3
out dx,al
mov al,0 
inc dx; 0x1f4
out dx,al
inc dx; 0x1f5
out dx,al
inc dx;
mov al,0b1110_0000 ; LBA模式
out dx,al
inc dx;0x1f7
mov al,0x30 ;写硬盘
out dx,al

mov ax,0x100
mov es,ax
mov di,0
mov dx,0x1f0

write_loop:
    nop
    nop
    nop
    mov ax,[es:di];读取内存数据
    out dx,ax     ;写入端口
    add di,2      ;di指针加2
    cmp di,512    ;判断是否写入完成
    jnz write_loop 
mov dx,0x1f7 
.check_write_state:
    nop
    nop
    nop ;加延迟 ATA的要求

    in al,dx
    and al,0b1000_0000 ;
    cmp al,0b1000_0000 ;检查硬盘是否繁忙
    jz .check_write_state
jmp $
times 510 -($-$$) db 0
db 0x55,0xaa