org 0x7c00
mov ax,3
int 0x10

;mov word [0x80 * 4], print
;mov word [0x80 * 4 + 2], 0

mov word [0x0 * 4], div_error ;根据中断号找到入口程序
mov word [0x0 * 4 + 2], 0
mov dx,0
mov ax,0
mov bx,0
div bx
halt:
    jmp halt
video:
    dw 0x0
print:
    push ax
    push es
    push bx
    mov ax,0xb800
    mov es,ax
    mov bx,[video]
    mov byte [es:bx],'|'
    add word [video],2
    pop bx
    pop es
    pop ax
    ;ret
    ;retf
    iret 
div_error:
    push ax
    push es
    push bx
    mov ax,0xb800
    mov es,ax
    mov ax,0
    mov ds,ax 
    mov si,message
    mov di,0;
    mov cx,(message_end-message);
    loop1:
        mov al,[ds:si];
        mov [es:di],al;
        inc si;
        add di,2;
        loop loop1
    pop bx
    pop es
    pop ax
    ;ret
    ;retf
    iret 
message:
    db "div is error",0
message_end:
times 510 -($-$$) db 0
db 0x55,0xaa