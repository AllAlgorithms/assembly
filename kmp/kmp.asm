segment .data
array	times 100 dd 0

segment .text
global kmp
extern strlen

kmp:
	push ebp
	mov ebp, esp

	mov ecx, [ebp+12]	;ecx =  address of search string
	mov edx, [ebp+8]		;edx = address of text
	xor esi, esi		;si=0
	mov edi, 1			;di = 1	
	mov dword [array], 0	
prefix:
	mov ah, [ecx+esi]	;ah = search_string[esi]
	mov al, [ecx+edi]	;al = search_string[edi]
	cmp al, 0			;if al == 0
	je search			; continue with search
	cmp al, ah			; if al == ah
	je equal
	jmp nequal
equal:					;array[edi] = ++esi
	inc esi
	mov [array+4*edi], esi
	inc edi
	jmp prefix
nequal:					;esi=0; array[edi] = esi
	xor esi, esi
	mov ah, [ecx+esi]
	cmp ah, al
	jne next
	inc esi
next:
	mov [array+4*edi], esi
	inc edi
	jmp prefix
search:
	xor esi, esi		;esi=0
	xor edi, edi		;edi=0
search_loop:
	mov ah, [ecx+esi]		
	mov al, [edx+edi]
	cmp ah, 0
	je found			;if search string ends
	cmp al, 0
	je notfound		;if text ends
	cmp ah, al			
	je pair
	jmp unpair
pair:				;edi++;esi++
	inc edi
	inc esi
	jmp search_loop
unpair:				;edi++;esi = array[esi]s	
	cmp esi, 0
	je next_u
	dec esi
	push dword[array+4*esi]
	pop esi
	jmp search_loop
next_u:
	inc edi
	jmp search_loop
	
found:
	sub edi, esi
	jmp end
notfound:
	mov edi, 101
end:
	push dword [ebp+12]		;get search pattern length to esi
	call strlen
	add esp, 4
	mov esi, eax

	mov ecx, 0				; ecx as counter
tochar:
	add dword[array + 4*ecx], 48	; convert number to character
	inc ecx
	cmp ecx, esi
	jne tochar
	mov dword[array + 4*ecx], 10	; endline char

	mov eax, 4			; write system call
	mov ebx, 1			; stdout
	mov ecx, array			; start address
	inc esi				; array length + endline char
	shl esi,2			; esi *= 4
	mov edx, esi	
	int $80
	
	mov eax, edi	;return value in eax<-edi
	mov esp, ebp
	pop ebp
	ret