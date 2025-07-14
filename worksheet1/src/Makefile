ASM = nasm
CC = gcc

#compler and linker flags
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -m32

# Files
DRIVER = driver.c
DRIVER_OBJ = driver.o
ASM_IO_OBJ = asm_io.o
TASK1_SRC = task1.asm
TASK2_SRC = task2.asm
TASK3_SRC = task3.asm
TASK1_OBJ = task1.o
TASK2_OBJ = task2.o
TASK3_OBJ = task3.o
TASK1_EXE = task1
TASK2_EXE = task2
TASK3_EXE = task3
all: $(TASK1_EXE) $(TASK2_EXE) $(TASK3_EXE)
$(DRIVER_OBJ): $(DRIVER)
	$(CC) $(CFLAGS) $(DRIVER) -o $(DRIVER_OBJ)

#compile any ASM FILE into .o files
%.o: %.asm
	$(ASM) -f elf32 $< -o $@

#link each task with driver and asm_io
$(TASK1_EXE): $(TASK1_OBJ) $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(CC) $(LDFLAGS) $^ -o $@

$(TASK2_EXE): $(TASK2_OBJ) $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(CC) $(LDFLAGS) $^ -o $@

$(TASK3_EXE): $(TASK3_OBJ) $(DRIVER_OBJ) $(ASM_IO_OBJ)
	$(CC) $(LDFLAGS) $^ -o $@

#clean up the build files
clean:
	rm -f *.o $(TASK1_EXE) $(TASK2_EXE) $(TASK3_EXE)
