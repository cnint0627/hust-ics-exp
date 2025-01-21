.section .text
.global _start
_start:
mov $0b01100101, %al
mov $0b01011101, %bl
sub %bx, %ax
mov $1, %eax
mov $0, %ebx
int $0x80
