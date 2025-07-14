%include "asm_io.inc"

segment .data
    prompt_name     db "Enter your name: ", 0
    prompt_count    db "How many times to print the welcome message? ", 0
    msg_too_low     db "Number is too low!", 0
    msg_too_high    db "Number is too high!", 0
    welcome_prefix  db "Welcome, ", 0
    msg_total       db "The sum of numbers 1 to 100 is: ", 0
    msg_start       db "Enter start index (1–100): ", 0
    msg_end         db "Enter end index (1–100): ", 0
    msg_invalid     db "Invalid range entered!", 0
    msg_range       db "The sum of your selected range is: ", 0

segment .bss
    name     resb 64
    i        resd 1
    count    resd 1
    name_len resd 1
    array    resd 100
    sum      resd 1
    start    resd 1
    end      resd 1

segment .text
    global asm_main
asm_main:
    enter 0, 0
    pusha
;ask name
    mov eax, prompt_name
    call print_string

    mov dword [i], 0
.read_name:
    call read_char
    cmp al, 10
    je .done_read
    mov ebx, [i]
    mov [name + ebx], al
    inc dword [i]
    cmp dword [i], 63
    jl .read_name
.done_read:
    mov ebx, [i]
    mov byte [name + ebx], 0
    mov [name_len], ebx
;asking for count
    mov eax, prompt_count
    call print_string
    call read_int
    mov [count], eax
;calidate: 51 ≤ count ≤ 99
    cmp eax, 51
    jl .too_low
    cmp eax, 99
    jg .too_high

    mov dword [i], 0
.print_loop:
    mov eax, [i]
    cmp eax, [count]
    jge .done_welcome
    mov eax, welcome_prefix
    call print_string
    mov eax, name
    call print_string
    call print_nl
    inc dword [i]
    jmp .print_loop

.too_low:
    mov eax, msg_too_low
    call print_string
    call print_nl
    jmp .after_welcome

.too_high:
    mov eax, msg_too_high
    call print_string
    call print_nl
.done_welcome:
.after_welcome:

;Fill array 1–100
    mov dword [i], 0
.fill_array:
    mov eax, [i]
    add eax, 1
    mov ebx, [i]
    mov [array + ebx*4], eax
    inc dword [i]
    cmp dword [i], 100
    jl .fill_array

;Sum entire array
    mov dword [i], 0
    mov dword [sum], 0
.sum_array:
    mov ebx, [i]
    mov eax, [array + ebx*4]
    add [sum], eax
    inc dword [i]
    cmp dword [i], 100
    jl .sum_array
    ;output full sum
    mov eax, msg_total
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl

    ;range sum
    mov eax, msg_start
    call print_string
    call read_int
    mov [start], eax
    mov eax, msg_end
    call print_string
    call read_int
    mov [end], eax
;alidate: 1 ≤ start ≤ end ≤ 100
    mov eax, [start]
    cmp eax, 1
    jl .invalid_range
    cmp eax, 100
    jg .invalid_range

    mov eax, [end]
    cmp eax, 1
    jl .invalid_range
    cmp eax, 100
    jg .invalid_range
    mov eax, [start]
    cmp eax, [end]
    jg .invalid_range

;sum range: i = start - 1
    mov eax, [start]
    dec eax
    mov [i], eax
    mov dword [sum], 0

.range_loop:
    mov eax, [i]
    cmp eax, [end]
    jge .done_range

    mov ebx, [i]
    mov eax, [array + ebx*4]
    add [sum], eax
    inc dword [i]
    jmp .range_loop
.done_range:
    mov eax, msg_range
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl
    jmp .exit
.invalid_range:
    mov eax, msg_invalid
    call print_string
    call print_nl
.exit:
    popa
    mov eax, 0
    leave
    ret
