[org 0x1000]

mov ax,0XB800
mov es,ax
mov byte [es:0],"L"
jmp $