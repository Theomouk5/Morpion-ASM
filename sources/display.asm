[BITS 64]

default rel

extern printf
extern scanf

global display

section .data
    format_sep:      db "%c | ", 0
    format_end_line: db "%c", 10, 0

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
    lea   rdi, [format_end_line]
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
