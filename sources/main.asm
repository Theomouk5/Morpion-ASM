[BITS 64]

default rel

extern printf
extern display

global main

section .data
    morpion: times 9 db 'X'

section .text
main:
    sub   rsp, 8
    mov   rdi, morpion
    call  display
    add   rsp, 8
    mov   rax, 0x3C
    xor   rdi, rdi
    syscall