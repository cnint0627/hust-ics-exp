.section .data
msg: .ascii "Press any key to begin!\n"
input: .space 20
buf1: .byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 
buf2: .fill 10, 1, 0 
buf3: .fill 10, 1, 0
buf4: .fill 10, 1, 0
.section .text
.global  _start
_start:

//print message
movl $4, %eax
movl $1, %ebx
movl $msg, %ecx
movl $24, %edx
int $0x80

//press any key to begin
mov $3, %eax
mov $0, %ebx
mov $input, %ecx
mov $20, %edx
int $0x80

//begin
mov  $buf1, %esi
mov  $buf2, %edi 
mov  $buf3, %ebx 
mov  $buf4, %edx 
mov  $10, %ecx 
lopa:  mov  (%esi), %al 
mov  %al, (%edi) 
inc  %al
mov  %al, (%ebx)
add  $3,  %al 
mov  %al, (%edx)
inc  %esi
inc  %edi
inc  %ebx
inc  %edx
dec  %ecx
jnz  lopa 
mov  $1, %eax
movl $0, %ebx
int  $0x80

