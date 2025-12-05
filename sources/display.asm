[BITS 64]

default rel

extern printf
extern scanf

global display

section .data
    morpion:         times 9 db 'X' ; TODO: Il faut l'enlever pour en faire un paramètre (LA STACK !!)
    format_sep:      db "%c | ", 0
    format_end_line: db "%c", 10, 0

section .text
display:
    push  rbp
    mov   rbp, rsp
    sub   rsp, 32    ; TODO: Il faut l'adapter au changment d'avant
    xor   rsi, rsi
    mov   qword[rbp - 8], 0
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
    mov   sil, byte[morpion + rcx]
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
