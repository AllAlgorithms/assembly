iclude'emu8086.inc'

org 100h 
.data

array  db 9,6,5,4,3,2,1
count  dw 7

.code

    mov cx,count      
    dec cx               ; outer loop iteration count

nextscan:                ; do {    // outer loop
    mov bx,cx
    mov si,0 

nextcomp:

    mov al,array[si]
    mov dl,array[si+1]
    cmp al,dl

    jnc noswap 

    mov array[si],dl
    mov array[si+1],al

noswap: 
    inc si
    dec bx
    jnz nextcomp

    loop nextscan       ; } while(--cx);



;;; this  loop to display  elements on the screen

    mov cx,7
    mov si,0

print:

    Mov al,array[si]  
    Add al,30h
    Mov ah,0eh
    Int  10h 
    MOV AH,2
    Mov DL , ' '
    INT 21H
    inc si
    Loop print

    ret 
