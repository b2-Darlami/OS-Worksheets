ASM = nasm
CC = gcc
LD = ld
GENISOIMAGE = genisoimage
QEMU = qemu-system-i386

LOADER = source/loader.asm       
LINKER = source/link.ld
KERNEL = kernel.elf
C_FILES = kmain.c                 
C_OBJECTS = $(C_FILES:.c=.o)      

all: os.iso
loader.o: $(LOADER)
	$(ASM) -f elf32 $(LOADER) -o loader.o
$(C_FILES:.c=.o): $(C_FILES)
	$(CC) -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c $(C_FILES) -o $(C_FILES:.c=.o)
$(KERNEL): loader.o $(C_OBJECTS)
	$(LD) -T $(LINKER) -melf_i386 loader.o $(C_OBJECTS) -o $(KERNEL)

os.iso: $(KERNEL)
	mkdir -p iso/boot/grub
	cp $(KERNEL) iso/boot/
	cp menu.lst iso/boot/grub/
	cp stage2_eltorito iso/boot/grub/
	$(GENISOIMAGE) -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -A os -input-charset utf8 -quiet -boot-info-table -o os.iso iso
run: os.iso
	$(QEMU) -nographic -boot d -cdrom os.iso -m 32 -d cpu -D logQ.txt

#clean up build files
clean:
	rm -f *.o $(KERNEL) os.iso logQ.txt
	rm -rf iso
