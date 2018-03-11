ASM=nasm
FLAGS= -f bin
BL=bootloader
SO=draw_square
COD=.asm
BIN=.bin
IMG=.img
DD=dd

all: compile create_img 

compile:
		$(ASM) $(FLAGS) $(BL)$(COD) -o $(BL)$(BIN)
		$(ASM) $(FLAGS) $(SO)$(COD) -o $(SO)$(BIN)

create_img:
		$(DD) if=$(BL)$(BIN) of=$(SO)$(IMG) conv=notrunc
		$(DD) if=$(SO)$(BIN) of=$(SO)$(IMG) bs=512 seek=1 conv=notrunc

run:
	qemu-system-x86_64 -fda $(SO)$(IMG)

clean:
		rm $(BL)$(BIN) $(SO)$(BIN) $(SO)$(IMG)

