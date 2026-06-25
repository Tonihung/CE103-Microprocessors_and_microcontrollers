name "add-sub-32bit"
org 100h
jmp start

x_hi dw 0000h
x_lo dw 000Fh
y_hi dw 0000h
y_lo dw 0005h

sum_hi dw ?
sum_lo dw ?
diff_hi dw ?
diff_lo dw ?

add_of db '0'
sub_of db '0'

str_x db 'x = $'
str_y db 'y = $'
str_sum db 'sum = $'
str_diff db 'diff = $'
str_add_of db 'OF add = $'
str_sub_of db 'OF sub = $'
str_bnl db 'b', 13, 10, '$'
newline db 13, 10, '$'

start:
    mov ax, cs
    mov ds, ax

    lea dx, str_x
    call print_str
    mov bx, [x_hi]
    call print_bin
    mov bx, [x_lo]
    call print_bin
    lea dx, str_bnl
    call print_str

    lea dx, str_y
    call print_str
    mov bx, [y_hi]
    call print_bin
    mov bx, [y_lo]
    call print_bin
    lea dx, str_bnl
    call print_str

    mov ax, [x_lo]
    add ax, [y_lo]
    mov [sum_lo], ax

    mov ax, [x_hi]
    adc ax, [y_hi]
    mov [sum_hi], ax

    mov byte ptr [add_of], '0'
    jno no_add_overflow
    mov byte ptr [add_of], '1'
no_add_overflow:

    lea dx, str_sum
    call print_str
    mov bx, [sum_hi]
    call print_bin
    mov bx, [sum_lo]
    call print_bin
    lea dx, str_bnl
    call print_str

    lea dx, str_add_of
    call print_str
    mov dl, [add_of]
    call print_char
    lea dx, newline
    call print_str

    mov ax, [x_lo]
    sub ax, [y_lo]
    mov [diff_lo], ax

    mov ax, [x_hi]
    sbb ax, [y_hi]
    mov [diff_hi], ax

    mov byte ptr [sub_of], '0'
    jno no_sub_overflow
    mov byte ptr [sub_of], '1'
no_sub_overflow:

    lea dx, str_diff
    call print_str
    mov bx, [diff_hi]
    call print_bin
    mov bx, [diff_lo]
    call print_bin
    lea dx, str_bnl
    call print_str

    lea dx, str_sub_of
    call print_str
    mov dl, [sub_of]
    call print_char
    lea dx, newline
    call print_str

    mov ah, 0
    int 16h
    ret

print_str:
    mov ah, 09h
    int 21h
    ret

print_char:
    mov ah, 02h
    int 21h
    ret

print_bin:
    mov cx, 16
next_bit:
    mov dl, '0'
    test bx, 1000000000000000b
    jz bit_zero
    mov dl, '1'
bit_zero:
    call print_char
    shl bx, 1
    loop next_bit
    ret
