Operating System Worksheet 1

Task 1: Adding two Integers in Assembler

I was tasked to implement an assembler program that contains a function asm_main, which adds two integers stored in global memory and then outputs the result.

%include "asm_io.inc"

As you can see, i have put this at the top. What it does is this line includes the contents of asm_io.inc. Including this file allows us to use some functions without re-writing them in the currunt code.

segment .data
    num1    dd 15
    num2    dd 6

The segment is used to define diffrent sections of the program. The initialized data, so the num1 and num2 variables are held the section .data. 

 mov eax, [num1]
    add eax, [num2]
    mov [result], eax

You can see here we are using the addition logic. mov eax, [num1] loads the value of num1 we defined earlier into the eax register. and then we add the values of num2 to the eax register using "add eax, [num2]. Storing the result into the memory location of result.

call print_int
    call print_nl

which at the end we call the print_int function to print the integer value in the eax register which was 21.

I was then tasked to create the file task2.asm to build and run a program that asks the user to input two integer numbers and then add them up and give the result of the sum.

We were asked to implament a program that is able to handle the user input which after be able to add the number up to get the result.

segment .data
    msg1 db "Enter a number: ", 0
    msg2 db "The sum of ", 0
    msg3 db " and ", 0
    msg4 db " is: ", 0
As you can see we start off we start making strings (msg1,msg2,msg3,msg4) which will be printed to the users.

segment .bss
    integer1 resd 1 
    integer2 resd 1   
    result   resd 1   
This command is to store each of the answers from the user so for example integer 1 will store the first number.


mov eax, [integer1]
    add eax, [integer2]
    mov [result], eax

here is the arthmitic process which the addition will happen. Which then later on, the result will be printed using the:

 mov eax, msg2
call print_string

So overall i manage to make the program to ask the user for two integers which they are able to input. The program then adds them together and then prints the formatted message showing the result of the two integers they picked.
 

Task 2 - write an assembler program that asks the user for their name and the number of times to
print a welcome message. Test that the value is less than 100 and greater than 50 and then finally print
out a welcome string that many times. Pretty an error message if the number if two large or small.
Write an assembler program that defines an array of 100 elements, initialize the array to the numbers
1 to 100, and then sum the that array, outputing the result.
Finally, extend the previous program so that it asks the user to enter a range to sum, checking the
range is valid, and then display the sum of that range.

I started off by doing the first part of the task which was to ask the user for their name and number times it to be printed. I first coded that prepares the prompt, messages and variables that is needed for the program.
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

    As it first needed to ask the user for its name, "mov eax, promp_name" was used to ask this so the user would be able to enter their name. The following code "call print_string" calls the function that prints the string pointed to by eax on the screen.

    The worksheet says that the number they have to pick has to be greater than 50 and smaller than 100, so i added "cmp eax, 51 + jl .too_low" and "cmp eax, 99 + jg .too_high" which sets the limit. Either if the number is too high or low, it will jump to the .too low or .too_high label which we defin later in the code to say "too low" or "too high" when the user enters number not within the range.

    .fill_array:
    mov eax, [i]
    add eax, 1
    mov ebx, [i]
    mov [array + ebx*4], eax
    inc dword [i]
    cmp dword [i], 100
    jl .fill_array

    Here we use a loop to initalise an array with number from 1 - 100. It uses loop controlled by the variable i. The purpose of this code block is so the array can be filled with values 1 through 100, which later in the code we will start to use for summing. The code then goes onto asking for the user to pick a number 1-100 to start index and end which then will find the sum of the selected range.

    a part of a range sum operation that i used was a loop that iterates from a given start index up to the end index. Also during each iteration, it will add the value from the array into the sum.
    mov eax, [i]
    cmp eax, [end]
    jge .done_range

    mov ebx, [i]
    mov eax, [array + ebx*4]
    add [sum], eax
    inc dword [i]
    jmp .range_loop

    Worksheet 1- task 3

    This task required me to create a makfile and program it build all the assembly programs i just did. It also has clean feature where it deletes the files incase of any problems and to test the file.

    First i ensure that the files that we used are in the rigtht directory which then i went onto making the makfile as i knew the paths to the files.
    We implemented rules into the makfile
    - First assemble the .asm files with NASM into .o objext files:%.o: %.asm
	$(ASM) -f elf32 $< -o $@
    - Make the driver.c compile with proper flags
    - linking both the .o files together with the asm_io.o so it can create excutables.
    - Also appilied the clean rile to remove all the generated files if needed."clean:
	rm -f *.o $(TASK1_EXE) $(TASK2_EXE) $(TASK3_EXE)"
    
    After using the command "make" it should automatically generate the objects files and any other files needed. You are able to test if the files works by using ./task1, ./task2, ./task3.


    WORKSHEET 2
    Following worksheet 2, task1. We were tasked to write our first little OS system.

    Using the codes given, i followed the structure in order to complete the task. We first wrote a kernal in assembly using NASM which is used to boot the GRUB and loads a simple EAX register.

    mov eax, 0xCAFEBABE ; Load magic number into eax
.loop:
    jmp .loop        ; Infinite loop to verify boot

I used menu.lst to help configure GRUB and a linker script to load the kernel at memory address 0x00100000. To verify this, i ran this in the ternimal:qemu-system-i386 -nographic -boot d -cdrom os.iso -m 32 -d cpu -D logQ.txt which then we were able to check logQ.txt for 0xCAFEBABe to be able to confirm this correctly worked.

using the following command - qemu-system-i386 -nographic -boot d -cdrom os.iso -m 32 -d cpu -
D logQ.txt

the command is used to tell qemu to boot a 32 bit x86 machine using the IOS image listed in the worksheet. It succesfully booted up which then moved onto the editing the makfile again. the alst task was to add a rule RUN, which makes the makefile run the ISO image from that command.
os.iso: $(KERNEL)
	mkdir -p iso/boot/grub
	cp $(KERNEL) iso/boot/
	cp menu.lst iso/boot/grub/
	cp stage2_eltorito iso/boot/grub/
	$(GENISOIMAGE) -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -A os -input-charset utf8 -quiet -boot-info-table -o os.iso iso

run: os.iso

this target build is to boot the ISO image containing the operating system. Using this command - run: os.iso
	$(QEMU) -nographic -boot d -cdrom os.iso -m 32 -d cpu -D logQ.txt  to run the ISO image.
 
Moving onto the second part of the worksheet, reading chapter 3 of the OS book, i extended the kernal so that it can call C functions.
I created the file kmain.c which serves as the enrty point from assembly to C. The Struct example is defined using "__attribute__((packed))" which helps to prevent the complier from inserting padding bytes.
struct example {
    unsigned char config;   // bits 0–7
    unsigned short address; // bits 8–23
    unsigned char index;    // bits 24–31
} __attribute__((packed));

we created the function kmain() in our code so we can simulate reading such as the register value using =
unsigned int raw = 0xABCD1234;
struct example* cfg = (struct example*)&raw;

The function that we used "sum_of_three(int a, int b, int c) is used to be called from the assembly code(loader.asm) which uses the standard cdec1 calling convention.

int sum_of_three(int a, int b, int c) {
    return a + b + c;
}
This shows how the C fucntions can integrated into a low-level OS kernal, showing how the data can passed from assembly to C.  
AFter this, we had to modify the makefile so it can be included into it. The command:
C_FILES = kmain.c
C_OBJECTS = $(C_FILES:.c=.o)
tells the makfile to track kmain.c and generate kmain.o.




