[org 0x1000]

check_memory:
    mov ax,0
    mov es,ax
    xor ebx,ebx
    mov edx,0x534D4150
    mov edi,ards_buffer
.next:
    mov eax,0xe820
    mov ecx,20
    int 0x15
    
    jc .error
    add di,cx
    inc word [ards_count]
    cmp ebx,0
    jnz .next
    mov cx,[ards_count]
    mov si,0
.show:  ;显示内存信息
    mov eax,[ards_buffer+si]
    mov ebx,[ards_buffer+si+8]
    mov edx,[ards_buffer+si+16]
    add si,20
    loop .show
.error:
jmp $

ards_count:
    dw 0
ards_buffer:   

