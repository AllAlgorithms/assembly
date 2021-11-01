section .data
	hexoutdata	times 8 db 0, 10, 0
	hexoutdatalength	equ $-hexoutdata

section .text
global _start
_start:
	mov eax, 4

	call Factorial
	bswap eax		;Fix little endian for proper hexidecimal readout
	call HexConvert

	mov eax, 4		;write to file
	mov ebx, 1		;STDOUT handle
	mov ecx, hexoutdata		;Message pointer
	mov edx, hexoutdatalength		;Size of the message
	int 80h			;System call
	
	xor ebx, ebx 		;Exit code is 0
	mov eax, 1		;Terminate process code
	int 80h		;System call


HexConvert:
	bswap eax
	mov ecx, 8

	hexloop:
		mov ebx, eax
		and ebx, 1111b

		cmp ebx, 10
		jb hexlessthanten
		add ebx, 'a' - 10
		jmp hexdone

	hexlessthanten:
		add ebx, '0'
	hexdone:
		mov edx, hexoutdata	;Base pointer
		add edx, ecx	;Pointer offset
		dec edx			;Correct to zero-based offset
		mov esi, edx
		mov [esi], bl
		shr eax, 4
		loop hexloop

		mov eax, hexoutdata
		add eax, 8
		mov esi, eax
		mov al, 0
		mov [esi], al
	ret

Factorial:
	mov ebx, 1
fact_top:
	imul ebx, eax
	cmp eax, 2
	dec eax
	jne fact_top
	mov eax, ebx
	ret

