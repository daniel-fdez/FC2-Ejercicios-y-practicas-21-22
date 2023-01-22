/*
 * FC2prac2_mods3.asm
 *
 *  Created on: 10/03/2022
 *      Author: usuario_local
 */

.global start
.equ N,8 @ Constante que determina el tama�o de los arrays
.equ M, N-1
.data
A: .word 7,3,25,4,75,2,1,1 @ Array sobre el que operar
.bss
B: .space 4*N @ Array en el que se guarda el array A ordenado de mayor a menor
max: .space 4 @ Variable que guarda el valor maximo del array A
ind: .space 4 @ Variable que guarda la posicion del valor maximo del array A
C: .space 4*N @ Array en el que guardar los elementos de menor a mayor del Array A
.text
start:	mov r0,#0 @ r0 = j
		@mov r1,#0 @ r1 = i sobra porque ya lo hago dentro del for
		ldr r2,=max @ r2 = &max
		ldr r3,[r2] @ r3 = max
		ldr r4,=ind @ r4 = &ind
		ldr r5,[r4] @ r5 = ind
		ldr r6,=A @ r6 = &A
		ldr r7,=B @ r7 = &B
		ldr r9,=C @ r9 = &C
		mov r13,#M @ r13 = M
for1:	cmp r0,#N @ Comparo j con N
		bge endfor1 @ j >= N
		mov r1,#0 @ i = 0
		mov r3,#0 @ max = 0
for2:	cmp r1,#N @ Comparo i con N
		bge endfor2
		ldr r8,[r6,r1,lsl#2] @ r8 = A(i)
if:		cmp r8,r3 @ A(i) con max
		ble endif @ A(i) <= max
		mov r3,r8 @ r3 = A(i)
		str r3,[r2] @ max = A(i)
		mov r5,r1 @ r5 = i
		str r5,[r4] @ ind = r5
endif:	add r1,r1,#1 @ i++
		b for2
endfor2:
		ldr r10,[r6,r5,lsl#2] @ r10 = A(ind)
		sub r11,r13,r0 @ R11 = M - j
		str r10,[r7,r0,lsl#2] @ Escribo el valor de A(ind) en la posicion de memoria de B(j)
		str r10,[r9,r11,lsl#2] @ Escribo el valor de A(ind) en la posicion de memoria de C(M-j)
		mov r10,#0 @ r10 = 0
		str r10,[r6,r5,lsl#2] @ Escribir en la pos de mem de A(ind) un 0
		add r0,r0,#1 @ j++
		b for1
endfor1:b .
		.end
