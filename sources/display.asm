[BITS 64]

default rel

extern printf
extern scanf

global display
global get_player_name
global ask_which_case

section .data
    format_sep:            db "%c | ", 0
    format_sep_endline:    db "%c", 10, 0
    format_string:         db "%s", 0
    format_string_endline: db "%s", 10, 0
    format_player_name:    db "Joueur %d entrez votre prénom : %s", 0
    format_int:            db "%lld", 0

section .rodata
    format_ask_column:     db "Entrez le n° de la colonne (1 - 3) : ", 0
    format_ask_row:        db "Entrez le n° de la ligne (1 - 3) : ", 0

section .text
display:
    push  rbp
    mov   rbp, rsp
    sub   rsp, 32  

    ; Initialisation Morpion
    mov   rsi, rdi        ; Source
    lea   rdi, [rbp - 32] ; Destination
    mov   rcx, 9          ; 8 répétitions => 8 bytes
    rep   movsb           ; Copie tout

    ; Mise à zéro variable locale (RCX) et RSI
    mov   qword[rbp - 8], 0
    xor   rsi, rsi

first_line:
    mov   qword[rbp - 16], first_line
    mov   rcx, qword[rbp - 8]
    cmp   rcx, 2
    je    eq
    jg    second_line
less:
    lea   rdi, [format_sep]
    jmp   result
eq:
    lea   rdi, [format_sep_endline]
result:
    lea   rax, [rbp - 32]
    mov   sil, byte[rax + rcx]
    xor   rax, rax
    call  printf
    inc   qword[rbp - 8]
    jmp   qword[rbp - 16]
second_line:
    mov   qword[rbp - 16], second_line
    mov   rcx, qword[rbp - 8]
    cmp   rcx, 5
    je    eq
    jl    less
third_line:
    mov   qword[rbp - 16], third_line
    mov   rcx, qword[rbp - 8]
    cmp   rcx, 8
    je    eq
    jl    less
end_display:
    add   rsp, 8
    mov   rsp, rbp
    pop   rbp
    ret


get_player_name:
    push  rbp
    mov   rbp, rsp
    sub   rsp, 32
    mov   [rbp - 8], rdi      ; Variable contenant l'adresse de player_1_name
    mov   [rbp - 16], rsi     ; Variable contenant l'adresse de player_2_name
    mov   [rbp - 24], 1     ; Variable compteur
pl_start:
    cmp   [rbp - 24], 2
    jg    player_end
    lea   rdi, [format_player_name]
    mov   rsi, [rbp - 24]
    xor   rax, rax

    ; Condition Pour Savoir quelle joueur N°1
    cmp   [rbp - 24], 2                
    je    pl_eq_1
    mov   rdx, qword[rbp - 8]
    jmp   pl_end_1
pl_eq_1:
    mov   rdx, qword[rbp - 16]
pl_end_1:

    ; Fin condition n°1
    call  printf
    lea   rdi, [format_string]
    
    ; Condition Pour Savoir quelle joueur N°2
    cmp   [rbp - 24], 2
    je    pl_eq_2
    mov   rsi, qword[rbp - 8]
    jmp   pl_end_2
pl_eq_2:
    mov   rsi, qword[rbp - 16]
pl_end_2:
    
    ; Fin condition n°2
    call  scanf
    inc   [rbp - 24]
    jmp   pl_start
player_end:
    add   rsp, 16
    mov   rsp, rbp
    pop   rbp
    ret


ask_which_case:
    push  rbp
    mov   rbp, rsp
    sub   rsp, 16

    lea   rdi, [format_ask_column]
    xor   rax, rax
    call  printf
    lea   rdi, [format_int]
    lea   rsi, [rbp - 8]
    call  scanf

    lea   rdi, [format_ask_row]
    xor   rax, rax
    call  printf
    lea   rdi, [format_int]
    lea   rsi, [rbp - 16]
    call  scanf

    mov   rax, [rbp - 8]
    mov   rdi, [rbp - 16]
    add   rsp, 16
    mov   rsp, rbp
    pop   rbp
    ret