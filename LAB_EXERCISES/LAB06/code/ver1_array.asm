.MODEL SMALL
.STACK 100h

.DATA
Input_mgs     DB "Enter a 2-digits number: $"
Output_mgs    DB 13,10,"The first N Fibonacci numbers:",13,10,"$"
Error_mgs     DB 13,10,"Invalid N! Please enter 9 < N < 100.",13,10,"$"
Space_mgs     DB " $"

input1        DB 3,?,3 DUP(' ')
Num           DB ?

fibo_n1       DB 21 DUP(0)
fibo_n2       DB 21 DUP(0)
fibo          DB 21 DUP(0)

.CODE

Main PROC
MOV AX, @DATA
MOV DS, AX

InputAgain:
LEA BX, Input_mgs
LEA CX, input1
CALL Input
CALL Endline

LEA SI, input1 + 2
LEA BX, Num
CALL ConvertStrToNum

MOV AL, Num
CMP AL, 9
JLE InvalidInput

CMP AL, 100
JGE InvalidInput

JMP StartProgram

InvalidInput:
LEA DX, Error_mgs
MOV AH, 9
INT 21h

JMP InputAgain

StartProgram:
LEA DX, Output_mgs
MOV AH, 9
INT 21h

MOV fibo_n2 + 20, 1

XOR CX, CX
MOV CL, Num

PrintLoop:
LEA BX, fibo_n1
CALL printFibo

LEA DX, Space_mgs
MOV AH, 9
INT 21h

CALL Add_Array

LEA AX, fibo_n1
LEA DX, fibo_n2
CALL copyArray

LEA AX, fibo_n2
LEA DX, fibo
CALL copyArray

LOOP PrintLoop

CALL Endline

MOV AH, 4Ch
INT 21h
Main ENDP


printFibo PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI

MOV SI, 0
MOV CX, 21
XOR DH, DH

loop_printFibo:
MOV DL, [BX + SI]
CMP DL, 0
JNE print_digit

CMP DH, 0
JE skip_zero

print_digit:
MOV DH, 1
ADD DL, '0'
MOV AH, 02h
INT 21h

skip_zero:
INC SI
LOOP loop_printFibo

CMP DH, 1
JE end_printFibo

MOV DL, '0'
MOV AH, 02h
INT 21h

end_printFibo:
POP SI
POP DX
POP CX
POP BX
POP AX
RET
printFibo ENDP


copyArray PROC
PUSH AX
PUSH BX
PUSH CX
PUSH SI
PUSH DI

MOV DI, AX
MOV SI, DX
MOV CX, 21

copy_loop:
MOV BL, [SI]
MOV [DI], BL

INC SI
INC DI

LOOP copy_loop

POP DI
POP SI
POP CX
POP BX
POP AX
RET
copyArray ENDP


Add_Array PROC
PUSH AX
PUSH BX
PUSH DX
PUSH SI

MOV SI, 20
MOV DL, 0

loop_add_array:
CMP SI, 0
JL end_loop_add_array

MOV AL, fibo_n1[SI]
MOV BL, fibo_n2[SI]

ADD AL, BL
ADD AL, DL

MOV DL, 0

CMP AL, 10
JL store_digit

SUB AL, 10
MOV DL, 1

store_digit:
MOV fibo[SI], AL

DEC SI
JMP loop_add_array

end_loop_add_array:
POP SI
POP DX
POP BX
POP AX
RET
Add_Array ENDP


ConvertStrToNum PROC
PUSH AX
PUSH BX
PUSH CX
PUSH SI

XOR AX, AX

Convert_loop:
MOV CL, [SI]
CMP CL, '$'
JE end_loop

MOV CH, 0

PUSH BX
MOV BX, 10
MUL BX

SUB CX, '0'
ADD AX, CX

POP BX
INC SI

JMP Convert_loop

end_loop:
MOV [BX], AL

POP SI
POP CX
POP BX
POP AX
RET
ConvertStrToNum ENDP


Input PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI

MOV DX, BX
MOV AH, 9
INT 21h

MOV DX, CX
MOV AH, 0Ah
INT 21h

MOV BX, CX
XOR SI, SI

MOV AL, [BX + 1]
MOV AH, 0
MOV SI, AX

MOV BYTE PTR [BX + SI + 2], '$'

POP SI
POP DX
POP CX
POP BX
POP AX
RET
Input ENDP


Endline PROC
PUSH AX
PUSH DX

MOV DL, 13
MOV AH, 2
INT 21h

MOV DL, 10
MOV AH, 2
INT 21h

POP DX
POP AX
RET
Endline ENDP

END Main
