KERNEL_STACK_SIZE equ 4096        ; Size of stack in bytes (4 KB)

section .bss
    align 4                      
    kernel_stack:                  
        resb KERNEL_STACK_SIZE     
; Set up the stack pointer (esp)
    mov esp, kernel_stack + KERNEL_STACK_SIZE  

    extern sum_of_three         ; the function sum_of_three is defined in C
push dword 3                ; arg3
push dword 2                ; arg2
push dword 1                ; arg1
call sum_of_three           ; call the function, result is returned in eax
