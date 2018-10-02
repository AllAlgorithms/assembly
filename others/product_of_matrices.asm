section .data
msg1: db 'Enter the number of rows of 1st matrix: '
size1: equ $-msg1
msg2: db 'Enter the number of columns of 1st matrix: '
size2: equ $-msg2
msg3: db 'Enter the elements of 1st matrix: ',0Ah
size3: equ $-msg3
msg4: db 'Enter the number of rows of 2nd matrix: '
size4: equ $-msg4
msg5: db 'Enter the number of columns of 2nd matrix: '
size5: equ $-msg5
msg6: db 'Enter the elements of 2nd matrix: ',0ah
size6: equ $-msg6
msg7: db  'The product of two matrices is: ',0Ah
size7: equ $-msg7
msg8: db 'Invalid input ',0Ah
size8: equ $-msg8
space: db ' '
size_: equ $-space
newline: db 10

section .bss
num: resw 1
matrix1: resw 50
matrix2: resw 50
matrix3: resw 50
temp: resw 1
temp1: resw 1
temp2: resw 1
temp3: resw 1
t: resd 1
n1: resw 1
n2: resw 1
m1: resw 1
m2: resw 1
nod: resw 1
sum: resw 1
zero: resw 1

section .text
global _start:
_start:

mov word[zero],0
add word[zero],30h

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h

call read_num
mov ax,word[num]
mov word[n1],ax

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,size2
int 80h

call read_num
mov ax,word[num]
mov word[m1],ax

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,size3
int 80h


mov ax,word[n1]
mov word[temp1],ax

mov edi,matrix1

i_loop1:
mov ax,word[m1]
mov word[temp2],ax

j_loop1:
call read_num
mov ax,word[num]
mov word[edi],ax
add edi,2
dec word[temp2]
cmp word[temp2],0
ja j_loop1

dec word[temp1]
cmp word[temp1],0
ja i_loop1

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,size4
int 80h

call read_num
mov ax,word[num]
mov word[n2],ax

mov eax,4
mov ebx,1
mov ecx,msg5
mov edx,size5
int 80h

call read_num
mov ax,word[num]
mov word[m2],ax

mov ax,word[n2]
mov word[temp1],ax

mov eax,4
mov ebx,1
mov ecx,msg6
mov edx,size6
int 80h


mov edi,matrix2

i_loop2:
mov ax,word[m2]
mov word[temp2],ax

j_loop2:
call read_num
mov ax,word[num]
mov word[edi],ax
add edi,2
dec word[temp2]
cmp word[temp2],0
ja j_loop2

dec word[temp1]
cmp word[temp1],0
ja i_loop2

mov ax,word[m1]
cmp ax,word[n2]
je if

else:
mov eax,4
mov ebx,1
mov ecx,msg8
mov edx,size8
int 80h
jmp exit

if:
mov ax,word[n1]
mov word[temp1],ax

mov edi,matrix1
mov esi,matrix2
mov ebp,matrix3

for1:
mov ax,word[m2]
mov word[temp3],ax
for2:
mov ax,word[m1]
mov word[temp2],ax

mov word[sum],0
for3:
mov ax,word[edi]
mov bx,word[esi]
mul bx
add word[sum],ax
add edi,2
mov ax,word[m2]
add ax,ax
mov word[t],ax
add esi,dword[t]
dec word[temp2]
cmp word[temp2],0
ja for3

mov ax,word[sum]
mov word[ebp],ax
add ebp,2

mov ax,word[m1]
add ax,ax
mov word[t],ax
sub edi,dword[t]

mov ax,word[n2]
mov bx,word[m2]
mul bx
add ax,ax
mov word[t],ax
sub esi,dword[t]
add esi,2

dec word[temp3]
cmp word[temp3],0
ja for2

mov ax,word[m1]
add ax,ax
mov word[t],ax
add edi,dword[t]

mov ax,word[m2]
add ax,ax
mov word[t],ax
sub esi,dword[t]

dec word[temp1]
cmp word[temp1],0
ja for1

mov ax,word[n1]
mov word[temp1],ax

mov eax,4
mov ebx,1
mov ecx,msg7
mov edx,size7
int 80h

mov ebp,matrix3
p1:
mov ax,word[m2]
mov word[temp2],ax
p2:
mov ax,word[ebp]
mov word[num],ax
call print_num

mov eax,4
mov ebx,1
mov ecx,space
mov edx,size_
int 80h

add ebp,2
dec word[temp2]
cmp word[temp2],0
ja p2

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h

dec word[temp1]
cmp word[temp1],0
ja p1

exit:
mov eax,1
mov ebx,0
int 80h

read_num:

mov word[num],0

loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read
cmp byte[temp],32
je end_read


mov ax,word[num]
mov bx,10
mul bx
mov bx,word[temp]
sub bx,30h
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
ret



print_num:

cmp word[num],0
je p

jmp L

p:
mov eax,4
mov ebx,1
mov ecx,zero
mov edx,2
int 80h

L:

extract_no:
cmp word[num],0
je print_no
inc word[nod]
mov dx,0
mov ax,word[num]
mov cx,10
div cx
push dx
mov word[num],ax
jmp extract_no

print_no:
cmp word[nod],0
je end_print
dec word[nod]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

jmp print_no
end_print:
ret
