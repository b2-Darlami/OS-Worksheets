KERNEL_STACK_SIZE equ 4096        ; Size of stack in bytes (4 KB)

section .bss
    align 4                        ; Align stack memory to 4-byte boundaries
    kernel_stack:                  ; Label pointing to the beginning of the stack
        resb KERNEL_STACK_SIZE     ; Reserve 4 KB of uninitialized memory for the stack
; Set up the stack pointer (esp)
    mov esp, kernel_stack + KERNEL_STACK_SIZE  ; Point esp to the end of the reserved stack memory

    extern sum_of_three         ; the function sum_of_three is defined in C
push dword 3                ; arg3
push dword 2                ; arg2
push dword 1                ; arg1
call sum_of_three           ; call the function, result is returned in eax
