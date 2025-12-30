[BITS 64]

default rel

extern printf
extern game

global main

section .text
main:
    sub   rsp, 8
    call  game
    add   rsp, 8
    mov   rax, 0x3C
    xor   rdi, rdi
    syscall