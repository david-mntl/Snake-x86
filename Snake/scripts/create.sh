mkdir -p build
nasm bootloader.asm -f bin -o build/bootloader.bin
nasm SnakeMain.asm -f bin -o build/SnakeMain.bin

dd if=build/bootloader.bin of=build/image.img bs=512 count=1
dd if=build/SnakeMain.bin of=build/image.img bs=512 count=4 seek=1
