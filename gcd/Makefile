all: run

run:
	clear
	nasm -f elf64 gcd.asm
	ld -m elf_x86_64 -s -o gcd.exe gcd.o
	./gcd.exe