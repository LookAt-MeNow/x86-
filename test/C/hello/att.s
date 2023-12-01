.section .text
.globl main
main:

    movl $4,%eax
    movl $1,%ebx
    movl $msg,%ecx
    movl $(msg_end-msg),%edx
    int  $0x80

    movl $1,%eax
    movl $0,%ebx
    int  $0x80

.section .data
msg:
    .asciz "hello world!\n"
msg_end: #注释是#号并且前面有空格
