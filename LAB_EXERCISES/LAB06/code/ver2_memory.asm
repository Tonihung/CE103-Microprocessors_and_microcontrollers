.MODEL SMALL
.STACK 100h

.DATA
Input_mgs    DB "Enter a 2-digits number: $"
Output_mgs   DB 13,10,"The first N Fibonacci numbers:",13,10,"$"
Error_mgs    DB 13,10,"Invalid N! Please enter 9 < N < 100.",13,10,"$"
Space_mgs    DB " $"

input1       DB 3,?,3 DUP(' ')
Num          DB ?

n1_0         DW 0
n1_1        DW 0
n1_2        DW 0
n1_3        DW 0
n1_4        DW 0

n2_0        DW 1
n2_1        DW 0
n2_2        DW 0
n2_3        DW 0
n2_4        DW 0

f_0         DW 0
f_1         DW 0
f_2         DW 0
f_3         DW 0
f_4         DW 0

t_0         DW 0
t_1         DW 0
t_2         DW 0
t_3         DW 0
t_4         DW 0

Ten         DW 10

.CODE

Main PROC
MOV AX, @DATA
MOV DS, AX

InputAgain:
LEA BX, Input_mgs
LEA CX, input1
CALL ReadNumberInput
CALL PrintNewLine

LEA SI, input1 + 2
LEA BX, Num
CALL ParseInputNumber

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
MOV n1_0, 0
MOV n1_1, 0
MOV n1_2, 0
MOV n1_3, 0
MOV n1_4, 0

MOV n2_0, 1
MOV n2_1, 0
MOV n2_2, 0
MOV n2_3, 0
MOV n2_4, 0

LEA DX, Output_mgs
MOV AH, 9
INT 21h

XOR CX, CX
MOV CL, Num

PrintLoop:
CALL PrintFiboMemory

LEA DX, Space_mgs
MOV AH, 9
INT 21h

CALL AddFiboMemory
CALL MoveFiboMemory

LOOP PrintLoop

CALL PrintNewLine

MOV AH, 4Ch
INT 21h
Main ENDP


AddFiboMemory PROC
PUSH AX

MOV AX, n1_0
ADD AX, n2_0
MOV f_0, AX

MOV AX, n1_1
ADC AX, n2_1
MOV f_1, AX

MOV AX, n1_2
ADC AX, n2_2
MOV f_2, AX

MOV AX, n1_3
ADC AX, n2_3
MOV f_3, AX

MOV AX, n1_4
ADC AX, n2_4
MOV f_4, AX

POP AX
RET
AddFiboMemory ENDP


MoveFiboMemory PROC
PUSH AX

MOV AX, n2_0
MOV n1_0, AX

MOV AX, n2_1
MOV n1_1, AX

MOV AX, n2_2
MOV n1_2, AX

MOV AX, n2_3
MOV n1_3, AX

MOV AX, n2_4
MOV n1_4, AX

MOV AX, f_0
MOV n2_0, AX

MOV AX, f_1
MOV n2_1, AX

MOV AX, f_2
MOV n2_2, AX

MOV AX, f_3
MOV n2_3, AX

MOV AX, f_4
MOV n2_4, AX

POP AX
RET
MoveFiboMemory ENDP


PrintFiboMemory PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX

MOV AX, n1_0
MOV t_0, AX

MOV AX, n1_1
MOV t_1, AX

MOV AX, n1_2
MOV t_2, AX

MOV AX, n1_3
MOV t_3, AX

MOV AX, n1_4
MOV t_4, AX

CMP t_0, 0
JNE ConvertPrint

CMP t_1, 0
JNE ConvertPrint

CMP t_2, 0
JNE ConvertPrint

CMP t_3, 0
JNE ConvertPrint

CMP t_4, 0
JNE ConvertPrint

MOV DL, '0'
MOV AH, 2
INT 21h

JMP FinishPrintMemory

ConvertPrint:
XOR CX, CX

DivideLoop:
CALL DivideMemoryByTen

ADD DL, '0'
MOV DH, 0
PUSH DX

INC CX

CMP t_0, 0
JNE DivideLoop

CMP t_1, 0
JNE DivideLoop

CMP t_2, 0
JNE DivideLoop

CMP t_3, 0
JNE DivideLoop

CMP t_4, 0
JNE DivideLoop

PrintDigitLoop:
POP DX
MOV AH, 2
INT 21h

LOOP PrintDigitLoop

FinishPrintMemory:
POP DX
POP CX
POP BX
POP AX
RET
PrintFiboMemory ENDP


DivideMemoryByTen PROC
PUSH AX
PUSH BX

MOV BX, Ten
XOR DX, DX

MOV AX, t_4
DIV BX
MOV t_4, AX

MOV AX, t_3
DIV BX
MOV t_3, AX

MOV AX, t_2
DIV BX
MOV t_2, AX

MOV AX, t_1
DIV BX
MOV t_1, AX

MOV AX, t_0
DIV BX
MOV t_0, AX

POP BX
POP AX
RET
DivideMemoryByTen ENDP


ParseInputNumber PROC
PUSH AX
PUSH BX
PUSH CX
PUSH SI

XOR AX, AX

ParseLoop:
MOV CL, [SI]
CMP CL, '$'
JE FinishParse

MOV CH, 0

PUSH BX
MOV BX, 10
MUL BX

SUB CX, '0'
ADD AX, CX

POP BX
INC SI

JMP ParseLoop

FinishParse:
MOV [BX], AL

POP SI
POP CX
POP BX
POP AX
RET
ParseInputNumber ENDP


ReadNumberInput PROC
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
ReadNumberInput ENDP


PrintNewLine PROC
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
PrintNewLine ENDP

END Main
