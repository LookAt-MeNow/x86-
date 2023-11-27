org 0x7c00
mov ax,3
int 0x10

mov ax,0;
mov ds,ax  
mov ss,ax
mov sp,0x7c00
mov dx,0x1f2
mov al,1
out dx,al
mov al,0
inc dx; 0x1f3
out dx,al
inc dx; 0x1f4
out dx,al
inc dx; 0x1f5
out dx,al
inc dx;
mov al,0b1110_0000
out dx,al
inc dx;0x1f7
mov al,0x20 ;读硬盘
out dx,al
.check_read_state:
    nop
    nop
    nop ;加延迟 ATA的要求

    in al,dx
    and al,0b1000_1000
    cmp al,0b0000_1000
    jnz .check_read_state
mov ax,0x100
mov es,ax
mov di,0
mov dx,0x1f0

read_loop:
    nop
    nop
    nop
    in ax,dx
    mov [es:di],ax
    add di,2
    cmp di,512
    jnz read_loop

mov dx,0x1f2
mov al,1
out dx,al
mov al,2
inc dx; 0x1f3
out dx,al
mov al,0 
inc dx; 0x1f4
out dx,al
inc dx; 0x1f5
out dx,al
inc dx;
mov al,0b1110_0000
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
    mov ax,[es:di]
    out dx,ax
    add di,2
    cmp di,512
    jnz write_loop
mov dx,0x1f7 
.check_write_state:
    nop
    nop
    nop ;加延迟 ATA的要求

    in al,dx
    and al,0b1000_0000
    cmp al,0b1000_0000
    jz .check_write_state
jmp $
times 510 -($-$$) db 0
db 0x55,0xaa