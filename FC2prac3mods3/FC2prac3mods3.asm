/*
 * FC2prac3mods3.asm
 *
 *  Created on: 05/04/2022
 *      Author: danie
 */
 /*
.extern _stack
.global start
.equ N,8 @ Constante global que delimita el tama�o de los arrays
.data
A: .word 7,3,25,4,75,2,1,1 @ Array en el que buscar el valor m�ximo
.bss
B: .space 4*N @ Array en el que guardar el array A ordenado de mayor a menor
max: .space 4 @ Variable que guarda el valor m�ximo de A
ind: .space 4 @ Variable que guarda la posici�n del valor m�ximo de A
.text
start:
		ldr sp, =_stack @ sp = &_stack
		mov fp, #0 @ Se actualiza el fp a 0
		ldr r1, =A @ r1 = &A
		ldr r4, =B @ r4 = &B
		mov r2, #N @ r2 = N
		mov r5, #0 @ r5 = j

for1:	cmp r5, r2 @ Se compara j con N
		bge endfor1 @ Salta si j >= N
		bl MAX @ Salta a MAX y en lr se guarda la dir de mem de la siguiente instrucci�n
		ldr r6, =ind @ r6 = &ind
		str r0, [r6] @ ind = valor de retorno de la funci�n MAX
		ldr r7, [r1,r0,lsl#2] @ r7 = A(ind)
		sub r8, r2, #1 @ r8 = N - 1
		sub r9, r8, r5 @ r9 = N - 1 - j
		str r7, [r4,r9,lsl#2] @ Se escribe A(ind) en la pos de mem de B(N - j)
		mov r7, #0
		str r7, [r1,r0,lsl#2] @ Se escribe un 0 en la pos de mem de A(ind)
		add r5, r5, #1 @ j++
		b for1

endfor1:b .

MAX:	push {r4-r8,fp,lr} @ Se guardan los valores de los registros que se usan en la funci�n MAX
		@ Guardo lr por si en las modificaciones es necesario llamar a otra funci�n dentro de MAX
		add fp, sp, #24 @ Se ajusta el marco de pila en funci�n de los registros que se usen
		@ 24 = 4(bytes)*(7(n�_reg_usados)-1(registro))
		mov r4, #0 @ i = 0
		ldr r5, =max @ r5 = &max
		mov r6, #0 @ max = 0
		mov r7, #0 @ ind = 0

for:	cmp r4, r2 @ Comparo i con N
		bge endfor @ Salto si i >= N
		ldr r8, [r1,r4,lsl#2] @ r8 = A(i) = MEM(r0 + r5*2^2)

if:		cmp r8, r6 @ Comparo A(i) con max
		ble endif @ Salto si A(i) <= max
		mov r6, r8 @ max = A(i)
		str r6, [r5] @ Se escribe A(i) en memoria
		mov r7, r4 @ Se copia/guarda el valor de i

endif:	add r4, r4, #1 @ i++
		b for

endfor:	mov r0, r7 @ r0 = r7 = �ndice del valor m�ximo del vector (r0 = registro de retorno de MAX)
		sub sp, fp, #24 @ Reestablece el marco de la pila a como estaba antes de llamar a la funci�n MAX
		pop {r4-r8,fp,lr} @ Se restauran los valores de los registros usados en MAX
		mov pc, lr @ Se actualiza el pc para que ejecute la siguiente instrucci�n despu�s de MAX
		.end
*/