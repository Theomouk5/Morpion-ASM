[BITS 64]

extern display
extern get_player_name
extern ask_which_case

global game

section .rodata
    player_1_symbol: db 'X'
    player_2_symbol: db 'O'

section .data
    morpion:        times 9 db ' '
    who_is_playing: db 1
    format:         db "%d", 10, 0

section .bss
    player_1_name: resb 16
    player_2_name: resb 16

section .text
before_game:
    sub   rsp, 8
    lea   rdi, [player_1_name]
    lea   rsi, [player_2_name]
    call  get_player_name
    add   rsp, 8
    ret

one_game:
    push  rbp
    mov   rbp, rsp
    sub   rsp, 16

    mov   r8, rdi
    lea   rdi, [morpion]
    call  display
ask:
    cmp   byte[who_is_playing], 1
    jg    its_player_2
its_player_1:
    lea   rdi, [player_1_name]
    jmp   ask_question
its_player_2:
    lea   rdi, [player_2_name]
ask_question:
    call  ask_which_case
    cmp   rax, 9
    jg    ask
    cmp   rax, 0
    jl    ask

    dec   rax
    mov   r10, rax

    ; Regarde encore c'est qui qui joue
    cmp   byte[who_is_playing], 1
    jne case_player_2
case_player_1:
    mov   al, byte[player_1_symbol]
    mov   byte[morpion + r10], al
    jmp   end
case_player_2:
    mov   al, byte[player_2_symbol]
    mov   byte[morpion + r10], al
end:
    add   rsp, 16
    mov   rsp, rbp
    pop   rbp
    ret


game:
    push  rbp    
    mov   rbp, rsp
    call  before_game
    call  one_game
    lea   rdi, [morpion]
    call  display
    mov   rsp, rbp
    pop   rbp
    ret