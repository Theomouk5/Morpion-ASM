[BITS 64]

default rel

extern printf
extern display
extern get_player_name
extern ask_which_case

global main

section .data
    morpion: times 9 db 'X'

section .bss
    player_1_name: resb 16
    player_2_name: resb 16

section .text
main:
    sub   rsp, 8
    call  ask_which_case
    add   rsp, 8
    mov   rax, 0x3C
    xor   rdi, rdi
    syscall