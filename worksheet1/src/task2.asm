%include "asm_io.inc"

segment .data
    msg1 db "Enter a number: ", 0
    msg2 db "The sum of ", 0
    msg3 db " and ", 0
    msg4 db " is: ", 0

segment .bss
    integer1 resd 1   ; space for first number
    integer2 resd 1   ; space for second number
    result   resd 1   ; space to store the result

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ;asking for the first number
    mov eax, msg1
    call print_string
    call read_int
    mov [integer1], eax  ; save it
    ;second number
    mov eax, msg1
    call print_string
    call read_int
    mov [integer2], eax  ; save it
    
    mov eax, [integer1];adding the two numbers up here
    add eax, [integer2]
    mov [result], eax

    ;printing the result
    mov eax, msg2
    call print_string
    mov eax, [integer1]
    call print_int
    mov eax, msg3
    call print_string
    mov eax, [integer2]
    call print_int
    mov eax, msg4
    call print_string

    mov eax, [result]
    call print_int
    call print_nl
    popa
    mov eax, 0
    leave
    ret
