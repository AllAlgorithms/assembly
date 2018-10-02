; Assembly algorithm to calculate the greatest common divisor (gcd) from 2 numbers
; Example:
;     gcd(24, 8) = 8

; %include "linux64.asm"

section .data
    digit db 0,10

    welcomeStr db "Welcome to the gcd calculator!",10,0
    welcomeStrLen equ $ - welcomeStr

    theResultIsA db "Result is A",10,0
    theResultIsA_size equ $ - theResultIsA
    theResultIsB db "Result is B",10,0
    theResultIsB_size equ $ - theResultIsB
    theResultIsReady db "Result is Ready!",10,0
    theResultIsReady_size equ $ - theResultIsReady

section .bss
    numberA: resb 64
    numberB: resb 64

section .text
    global _start
    hlt

%macro printDigit 1
    mov rax, %1
    call _printRAXDigit
%endmacro

_printRAXDigit:
    add rax, 48
    mov [digit], al
    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall
    ret


_start:
    call welcome2
    mov rax, 24         ; First value
    mov rbx, 8          ; Second value
    mov [numberA], rax
    mov [numberB], rbx

    call verify
    
    ; Terminate program
	mov rax,1            ; 'exit' system call
	mov rbx,0            ; exit with error code 0
	int 80h              ; call the kernel

welcome2:
    ; WORKING VERSION
    mov rax,4            ; 'write' system call = 4
	mov rbx,1            ; file descriptor 1 = STDOUT
	mov rcx,welcomeStr   ; string to write
	mov rdx,welcomeStrLen; length of string to write
	int 80h              ; call the kernel
    ret



; Base cases
; gcd:
verify:
    ; if A = 0, return B
    mov rcx, [numberA]      ; load from memory
    cmp rcx, 0
    je resultIsB
    
    ; if B = 0, return A
    mov rdx, [numberB]      ; load from memory
    cmp rdx, 0
    je resultIsA
    jmp calculate
    ret

; Iteration to get result
isNotEqual:
    mov rcx, [numberA]
    mov rdx, [numberB]

    ;mov rax, rcx
    ;call _printRAXDigit

    cmp rcx, rdx
    jne calculate
    jmp resultIsReady
    ret

calculate:
    mov rcx, [numberA]
    mov rdx, [numberB]

    ; if A > B, jump
    cmp rcx, rdx
    jg AsubB

    ; if B > A, jump
    cmp rdx, rcx
    jg BsubA
    ret

; A = A - b
AsubB:
    mov rcx, [numberA]
    mov rdx, [numberB]

    sub rcx, rdx

    mov [numberA], rcx
    mov [numberB], rdx

    jmp isNotEqual
    ret

; B = B - A
BsubA:
    mov rcx, [numberA]
    mov rdx, [numberB]

    sub rdx, rcx

    mov [numberA], rcx
    mov [numberB], rdx

    jmp isNotEqual
    ret


resultIsA:
    ; print("Result is A")
    mov rax,4                   ; 'write' system call = 4
	mov rbx,1                   ; file descriptor 1 = STDOUT
	mov rcx,theResultIsA        ; string to write
	mov rdx,theResultIsA_size   ; length of string to write
	int 80h                     ; call the kernel

    ; Terminate program
    mov rax,1            ; 'exit' system call
	mov rbx,0            ; exit with error code 0
	int 80h              ; call the kernel

    ret

resultIsB:
    ; print("Result is B")
    mov rax,4                   ; 'write' system call = 4
	mov rbx,1                   ; file descriptor 1 = STDOUT
	mov rcx,theResultIsB        ; string to write
	mov rdx,theResultIsB_size   ; length of string to write
	int 80h                     ; call the kernel

    ; Terminate program
    mov rax,1            ; 'exit' system call
	mov rbx,0            ; exit with error code 0
	int 80h              ; call the kernel

    ret

resultIsReady:
    mov rax, [numberA]
    call _printRAXDigit

    ; Terminate program
    mov rax,1            ; 'exit' system call
	mov rbx,0            ; exit with error code 0
	int 80h              ; call the kernel

    ret
