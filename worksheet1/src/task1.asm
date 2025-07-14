%include "asm_io.inc"

segment .data
    num1    dd 15
    num2    dd 6

segment .bss
    result  resd 1

segment .text
    global asm_main
    extern print_int
    extern print_nl

asm_main:
    enter 0,0
    pusha

    mov eax, [num1]
    add eax, [num2]
    mov [result], eax
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
