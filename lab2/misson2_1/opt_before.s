.section .data

start_t:.long 0
end_t:.long 0
time: .ascii "run time: %d\n"

n: .long 100000
lowfn:.long 0
midfn:.long 0
highfn:.long 0

MSG:
.fill 5000000,1,1


LOWF:
.fill 5000000,1,0
MIDF:
.fill 5000000,1,0
HIGHF:
.fill 5000000,1,0
.section .text
.global _start
_start:

//调用系统函数clock函数
call clock
mov %eax, start_t

mov $0,%esi
mov n, %edi

lopa:
add $9, %esi
mov MSG(%esi), %eax

//汇编乘法效率较低
mov $5, %ecx
imul %ecx, %eax

add $4, %esi
add MSG(%esi), %eax
add $4, %esi
sub MSG(%esi), %eax
add $100, %eax

//edx存符号位
//eax是被除数，ebx是除数,edx是余数
//汇编除法效率较低
cdq 
mov $128, %ebx
idiv %ebx
add $4, %esi
mov %eax, MSG(%esi)

//判断结果与100的大小，跳转到对应的部分对数据组进行拷贝
sub $21, %esi
mov $25, %ecx
cmp $100, %eax
jg highf
je midf
//else -> lowf

lowf:
//采用循环结构，每次拷贝单个字节，耗时长
mov lowfn, %ebx
loplow:
movb MSG(%esi), %al
movb %al, LOWF(%ebx)
inc %esi
inc %ebx
dec %ecx
jnz loplow
mov %ebx, lowfn
jmp next

midf:
mov midfn, %ebx
lopmid:
movb MSG(%esi), %al
movb %al, MIDF(%ebx)
inc %esi
inc %ebx
dec %ecx
jnz lopmid
mov %ebx, midfn
jmp next

highf:
mov highfn, %ebx
lophigh:
movb MSG(%esi), %al
movb %al, HIGHF(%ebx)
inc %esi
inc %ebx
dec %ecx
jnz lophigh
mov %ebx, highfn
jmp next

next:
add $4, %esi
dec %edi
jne lopa

//调用系统函数clock函数和printf函数
call clock
mov %eax, end_t
sub start_t, %eax
pushl %eax
pushl $time
call printf

mov $1, %eax
mov $0, %ebx
int $0x80
