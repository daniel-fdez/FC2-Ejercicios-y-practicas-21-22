/*
 * pruebaFC2p1.asm
 *
 *  Created on: 16/02/2022
 */
.global start
.data
X: 		.word 0x03
Y: 		.word 0x0A

.bss
Mayor: .space 4

.text
start:
		LDR R4, =X // Carga en R4 la direccion de memoria de X
		LDR R3, =Y // Carga en R3 la direccion de memoria de Y
		LDR R5, =Mayor // Carga en R5 la direccion de memoria de Mayor
		LDR R1, [R4] // Carga en R1 el contenido de la direccion de memoria almacenada en R4
		LDR R2, [R3] // Carga en R2 el contenido de la direccion de memoria almaceanda en R3
		CMP R1, R2 // Compara los contenidos de los registros R1 y R2
		BLE else // Si el contenido de R1 es menor o igual al contenido de R2, salta a la etiqueta 'else'
		STR R1, [R5] // Si R1>R2, almacena el contenido de R1 en la direccion de memoria que contiene R5
		B FIN // Y se acaba el programa
else: 	STR R2, [R5] // Si R1<=R2, almacena el contenido de R2 en la direccion de memoria que contiene R5
FIN: 	B . // Y se acaba el programa
		.end

