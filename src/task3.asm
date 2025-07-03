%include "asm_io.inc"

segment .data
    prompt_name     db "What is your name: ", 0
    prompt_count    db "How many times to print the welcome message? ", 0
    msg_too_low     db "Number is too low", 0
    msg_too_high    db "Number is too high", 0
    welcome_prefix  db "Welcome, ", 0

segment .bss
    name resb 64         ; buffer for user name
    i    resd 1          ; general loop counter
    count resd 1         ; number of times to print
    name_len resd 1      ; number of characters entered for name

segment .text
    global asm_main

asm_main:
    enter 0, 0
    pusha

    ;reading the name

    mov eax, prompt_name
    call print_string

    mov dword [i], 0

.read_loop:
    call read_char            
    cmp al, 10                
    je .done_read

    ; store character into name[i]
    mov ebx, [i]
    mov [name + ebx], al

    ; i++
    inc dword [i]
    cmp dword [i], 63         ; prevent overflow (64 bytes max)
    jl .read_loop

.done_read:
    ; add null terminator to make it a proper string
    mov ebx, [i]
    mov byte [name + ebx], 0
    mov [name_len], ebx       ; store actual name length

    ; ------------------------
    ; Ask for print count
    ; ------------------------
    mov eax, prompt_count
    call print_string
    call read_int
    mov [count], eax

    ; Validate count (must be >50 and <100)
    cmp eax, 51
    jl too_low
    cmp eax, 99
    jg too_high

    ; ------------------------
    ; Print "Welcome, [name]" [count] times
    ; ------------------------
    mov dword [i], 0

.print_loop:
    mov eax, [i]
    cmp eax, [count]
    jge done

    ; print welcome message
    mov eax, welcome_prefix
    call print_string
    mov eax, name
    call print_string
    call print_nl

    ; i++
    inc dword [i]
    jmp .print_loop

; ------------------------
too_low:
    mov eax, msg_too_low
    call print_string
    call print_nl
    jmp done

too_high:
    mov eax, msg_too_high
    call print_string
    call print_nl

done:
    popa
    mov eax, 0
    leave
    ret
