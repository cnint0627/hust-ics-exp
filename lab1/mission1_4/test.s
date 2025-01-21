.section .data
n: .long 2
lowfn:.long 0
midfn:.long 0
highfn:.long 0
MSG:
.byte 0,0,0,0,0,0,0,0,0
.long 256809
.long -1023
.long 1265
.long 0


.byte 0,0,0,0,0,0,0,0,1
.long 1234
.long -1234
.long 5678
.long 0

LOWF:
.fill 10000,1,0
MIDF:
.fill 10000,1,0
HIGHF:
.fill 10000,1,0
.section .text
.global _start
_start:
mov $0,%esi
mov n, %edi

lopa:
add $9, %esi
mov MSG(%esi), %eax
mov $5, %ecx
imul %ecx, %eax
add $4, %esi
add MSG(%esi), %eax
add $4, %esi
sub MSG(%esi), %eax
add $100, %eax

mov $128, %ebx
//做除法之前要先将edx置0，不然会报错
//eax是被除数，ebx是除数,edx是余数
idiv %ebx
add $4, %esi
mov %eax, MSG(%esi)

//判断结果与100的大小，跳转到对应的部分对数据组进行拷贝
sub $21, %esi
mov $9, %ecx
cmp $100, %eax
jg highf
cmp $100, %eax
je midf
//else -> lowf
lowf:
mov lowfn, %ebx
loplow:
mov MSG(%esi), %eax
mov %eax, LOWF(%ebx)
inc %esi
inc %ebx
dec %ecx
jnz loplow

mov MSG(%esi), %eax
mov %eax, LOWF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, LOWF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, LOWF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, LOWF(%ebx)
add $4, %ebx
mov %ebx, lowfn
jmp next
midf:
mov midfn, %ebx
lopmid:
mov MSG(%esi), %eax
mov %eax, MIDF(%ebx)
inc %esi
inc %ebx
dec %ecx
jnz lopmid

mov MSG(%esi), %eax
mov %eax, MIDF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, MIDF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, MIDF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, MIDF(%ebx)
add $4, %ebx
mov %ebx, midfn
jmp next
highf:
mov highfn, %ebx
lophigh:
mov MSG(%esi), %eax
mov %eax, HIGHF(%ebx)
inc %esi
inc %ebx
dec %ecx
jnz lophigh

mov MSG(%esi), %eax
mov %eax, HIGHF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, HIGHF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, HIGHF(%ebx)
add $4, %esi
add $4, %ebx
mov MSG(%esi), %eax
mov %eax, HIGHF(%ebx)
add $4, %ebx
mov %ebx, highfn
jmp next

next:
add $4, %esi
dec %edi
jne lopa

mov $1, %eax
mov $0, %ebx
int $0x80
