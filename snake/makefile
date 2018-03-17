#SETTING MACROS FOR MAKE FILE
#NASM IS THE assembler of the .asm code
ASM=nasm		
#flag for compiling the snake and bootloader code
FLAGS= -f bin
#bootloader macro
BL=bootloader
#snake name macro
SO=snake
#asm extension macro
COD=.asm
#bin extension macro
BIN=.bin
#img exension macro
IMG=.img
#dd macro
DD=dd
ZERO=/dev/zero
#usb macro --- can be changed when sudo make 'USB= /dev/disk'
USB=/dev/sdb1

#macro that call compile, create image and save image on storage
all: compile create_img save_usb

#compile instructions
compile:
		$(ASM) $(FLAGS) $(BL)$(COD) -o $(BL)$(BIN)
		$(ASM) $(FLAGS) $(SO)$(COD) -o $(SO)$(BIN)

#create image
create_img:
		$(DD) if=$(ZERO) of=$(SO)$(IMG) bs=1024 count=512
		$(DD) if=$(BL)$(BIN) of=$(SO)$(IMG) conv=notrunc
		$(DD) if=$(SO)$(BIN) of=$(SO)$(IMG) bs=512 seek=1 conv=notrunc

#save the image on the storage device
save_usb:
		$(DD) if=$(SO)$(IMG) of=$(USB)

#macro for running the program on the real time simulator qemu
run:
	qemu-system-x86_64 -fda $(SO)$(IMG)

#for cleaning the .img, .bin of bootloader and snake

clean:
		rm $(BL)$(BIN) $(SO)$(BIN) $(SO)$(IMG)

#in case the user need any heal
help:
	@echo "Execute using \"sudo make 'USB=/dev/sdbX'\""
	@echo "sudo used for load the Snake game in the USB drive"
	@echo "the 'X' on the USB path may be changed with a correct letter on the system"
	@echo "\nTry typing \"sudo fdisk -l\" on terminal to get the USB drive path"
