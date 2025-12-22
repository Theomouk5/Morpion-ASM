[BITS 64]

default rel

extern printf
extern display
extern get_player_name

global main

section .data
    morpion: times 9 db 'X'

section .bss
    player_1_name: resb 16
    player_2_name: resb 16

section .text
main:
    sub   rsp, 8
    lea   rdi, [player_1_name]
    lea   rsi, [player_2_name]
    call  get_player_name
    add   rsp, 8
    mov   rax, 0x3C
    xor   rdi, rdi
    syscall