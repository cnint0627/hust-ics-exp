.section .data
buf1: .byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 
buf2: .fill 10, 1, 0 
buf3: .fill 10, 1, 0
buf4: .fill 10, 1, 0
.section .text
.global  _start
_start:
mov  $0, %esi
mov  $10, %ecx
lopa:  mov buf1(%esi), %al 
mov  %al, buf2(%esi)
inc  %al
mov  %al, buf3(%esi)
add  $3,  %al 
mov  %al, buf4(%esi)
inc  %esi
dec  %ecx
jnz  lopa 
mov  $1, %eax
movl $0, %ebx
int  $0x80

