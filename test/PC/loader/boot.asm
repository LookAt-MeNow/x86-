org 0x7c00
mov ax,3
int 0x10

mov ax,0;
mov ds,ax  
mov ss,ax
mov sp,0x7c00

mov edi,0x1000
mov ecx,2
mov bl,4
call read_disk
jmp 0:0x1000 ;跳转到0x1000处执行
read_disk:
    pushad ;将a,b,c,d,si,di,sp,bp压栈
    ;读取硬盘
    ; edi --> 存储内存位置
    ; edi是di的扩展，就是32位的di
    ; ecx --> 读取的扇区位置
    ; bl  --> 读取扇区的数量

    mov dx,0x1f2
    mov al,bl
    out dx,al ; 扇区数量

    mov al,cl ;扇区位置低8位
    inc dx; 0x1f3
    out dx,al  ;扇区位置低8位
    
    shr ecx,8  ;ecx右移8位。扇区中间8位位置就到了低8位
    inc dx; 0x1f4
    mov al,cl
    out dx,al  ;中间8位
    
    shr ecx,8  ;ecx右移8位。高8位就到了低8位
    inc dx; 0x1f5
    mov al,cl
    out dx,al
    
    shr ecx,8
    and cl,0b0000_1111 ;只取低4位
    inc dx; 0x1f6
    mov al,0b1110_0000 ;
    or al,cl 
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
    
    xor eax,eax
    mov al,bl
    mov dx,256
    mul dx; ax = bl * 256

    mov dx,0x1f0
    mov cx,ax
    .read_loop:
        nop
        nop
        nop
        in ax,dx
        mov [edi],ax
        add di,2
        loop .read_loop
    popad
    ret

jmp $
times 510 -($-$$) db 0
db 0x55,0xaa