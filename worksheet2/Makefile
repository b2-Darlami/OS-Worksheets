LOADER = source/loader.asm
LINKER = source/link.ld
KERNEL = kernel.elf

all: os.iso

loader.o: $(LOADER)
	nasm -f elf $(LOADER) -o loader.o

$(KERNEL): loader.o
	ld -T $(LINKER) -melf_i386 loader.o -o $(KERNEL)

iso: $(KERNEL)
	mkdir -p iso/boot/grub
	cp $(KERNEL) iso/boot/
	cp menu.lst iso/boot/grub/
	cp stage2_eltorito iso/boot/grub/

os.iso: iso
	genisoimage -R \
	-b boot/grub/stage2_eltorito \
	-no-emul-boot -boot-load-size 4 -A os \
	-input-charset utf8 -quiet -boot-info-table \
	-o os.iso iso

run: os.iso
	qemu-system-i386 -nographic -boot d -cdrom os.iso -m 32 -d cpu -D logQ.txt

clean:
	rm -f *.o $(KERNEL) os.iso logQ.txt
	rm -rf iso
