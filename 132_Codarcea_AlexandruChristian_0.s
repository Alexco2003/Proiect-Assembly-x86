.data
m1: .space 40000
m2: .space 40000
mres: .space 40000
columnIndex: .space 4
lineIndex: .space 4
n: .space 4
n2: .space 4
y: .space 4
x: .space 4
k: .space 4
i: .space 4
j: .space 4
index2: .space 4
index: .space 4
left: .space 4
right: .space 4
formatScanf: .asciz "%ld"
formatPrintf: .asciz "%ld "
formatPrintf2: .asciz "%ld\n"
newLine: .asciz "\n"

.text

matrix_mult:

pushl %ebp
movl %esp, %ebp



subl $4, %esp
movl $0, -4(%ebp)
subl $4, %esp
movl $0, -8(%ebp)
subl $4, %esp
movl $0, -12(%ebp)
subl $4, %esp
movl $0, -16(%ebp)
subl $4, %esp
movl $0, -20(%ebp)

pushl %esi
pushl %ebx
pushl %edi


fori:
movl $0, -8(%ebp)
movl -4(%ebp), %ecx
cmp %ecx, 20(%ebp)
je exit

fori2:

mov 16(%ebp), %edi
movl -4(%ebp), %eax
movl $0, %edx
mull 20(%ebp)
addl -8(%ebp), %eax
movl $0, (%edi, %eax, 4)

movl $0, -12(%ebp)

movl -8(%ebp), %ecx
cmp %ecx, 20(%ebp)
je fori5


fori3:
movl -12(%ebp), %ecx
cmp %ecx, 20(%ebp)
je fori4

mov 8(%ebp), %edi
mov 12(%ebp), %esi

movl -4(%ebp), %eax
movl $0, %edx
mull 20(%ebp)
addl -12(%ebp), %eax
movl (%edi, %eax, 4), %ecx
movl %ecx, -16(%ebp)

movl -12(%ebp), %eax
movl $0, %edx
mull 20(%ebp)
addl -8(%ebp), %eax
movl (%esi, %eax, 4), %ecx
movl %ecx, -20(%ebp)

movl -16(%ebp), %eax
movl $0, %edx
mull -20(%ebp)
movl %eax, -16(%ebp)

mov 16(%ebp), %edi
movl -4(%ebp), %eax
movl $0, %edx
mull 20(%ebp)
addl -8(%ebp), %eax
movl (%edi, %eax, 4), %ebx
addl -16(%ebp), %ebx
movl %ebx,(%edi, %eax, 4)

movl $0, -16(%ebp)
movl $0, -20(%ebp)









incl -12(%ebp)
jmp fori3


fori4:
incl -8(%ebp)
jmp fori2

fori5:
incl -4(%ebp)
jmp fori

exit:
popl %edi
popl %ebx
popl %esi
addl $4, %esp
addl $4, %esp
addl $4, %esp
addl $4, %esp
addl $4, %esp
popl %ebp
ret


.global main

main:

pushl $y
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $n
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

lea m2, %esi
lea m1, %edi
movl $0, %ecx

citire:


cmp %ecx, n
je citire2

pusha
pushl $x
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa

movl x, %eax
movl %eax, (%esi, %ecx, 4)
incl %ecx
jmp citire

citire2:

movl $0, %ecx
movl $0, index2


et_for:

cmp %ecx, n
je afisare1

movl index2, %ebx
cmp %ebx, (%esi, %ecx, 4)
je for2

movl %ecx, left

pusha
pushl $right
pushl $formatScanf
call scanf
popl %ebx
popl %ebx
popa

movl left, %eax
movl $0, %edx
mull n
addl right, %eax
lea m1, %edi
movl $1, (%edi, %eax, 4)

incl index2

jmp et_for

for2:

movl $0, index2
incl %ecx
jmp et_for

afisare1:

mov $1, %eax
cmp %eax, y
je et_afis_matr

mov $2, %eax
cmp %eax, y
je main2

main2:

pushl $k
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $i
pushl $formatScanf
call scanf
popl %ebx
popl %ebx

pushl $j
pushl $formatScanf
call scanf
popl %ebx
popl %ebx


movl n, %eax
movl $0, %edx
mull n
movl %eax, n2

movl $1, index
movl $0, %ecx

for5:

cmp %ecx, n2
je for6
movl (%edi, %ecx, 4), %eax
lea m2, %esi
movl %eax, (%esi, %ecx, 4)
lea mres, %esi
movl %eax, (%esi, %ecx, 4)
incl %ecx
jmp for5

for6:
movl index, %ecx
cmp %ecx, k
je et_afis_matr2

pusha
pushl n
pushl $mres
pushl $m2
pushl $m1
call matrix_mult
pop %ebx
pop %ebx
pop %ebx
pop %ebx
popa

movl $0, %ecx
for7:

cmp %ecx, n2
je for8
lea mres, %edi
lea m2, %esi
movl (%edi, %ecx, 4), %eax
movl %eax, (%esi, %ecx, 4)
incl %ecx
jmp for7

for8:



incl index
jmp for6


















































et_afis_matr:
movl $0, lineIndex
for_lines:
movl lineIndex, %ecx
cmp %ecx, n
je et_exit
movl $0, columnIndex
for_columns:
movl columnIndex, %ecx
cmp %ecx, n
je cont
movl lineIndex, %eax
movl $0, %edx
mull n
addl columnIndex, %eax
lea m1, %edi
movl (%edi, %eax, 4), %ebx
pushl %ebx
pushl $formatPrintf
call printf
popl %ebx
popl %ebx
pushl $0
call fflush
popl %ebx
incl columnIndex
jmp for_columns
cont:
movl $4, %eax
movl $1, %ebx
movl $newLine, %ecx
movl $1, %edx
int $0x80
incl lineIndex
jmp for_lines

et_afis_matr2:

movl i, %eax
movl $0, %edx
mull n
addl j, %eax
lea mres, %edi
pushl (%edi, %eax, 4)
pushl $formatPrintf2
call printf
pop %ebx
pop %ebx





et_exit:
pushl $0
call fflush
popl %ebx
movl $1, %eax
movl $0, %ebx
int $0x80
