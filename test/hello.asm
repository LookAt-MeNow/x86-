[bits 32]
section .text ;这个是代码段
global main   ;这个是入口函数
main:
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, msg ; msg
    mov edx, msglen ; msglen
    int 80h ; syscall
    mov eax, 1 ; sys_exit
    mov ebx, 0 ; exit code
    int 80h

section .data
    msg db "Hello, World!", 10,13,0
    msglen equ $-msg