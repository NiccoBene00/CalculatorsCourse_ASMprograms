;Viene presentato lo scheletro di un programma ASSEMBLER

STACK		SEGMENT		PARA STACK 'STACK' ;segmento di STACK
DB			32 DUP		("STACK---")
STACK		ENDS

DATA		SEGMENT		WORD PUBLIC 'DATA' ;segmento di dato
			...							   ;dati
DATA 		ENDS

CSEG		SEGMENT		PARA PUBLIC 'CODE' ;segmento di codice
			ASSUME		CS:CSEG, DS:DATA, SS:STACK
			
start:								       ;inizio programma
			MOV			AX, DATA		   
			MOV			DS, AX		       ;inizializzazione di DS
			...							   ;istruzioni
			MOV			AL, 0
			MOV			AH, 04CH           ;questa sequenza di 3 istruzioni permette il ritorno
			INT			21H                ;a MS-DOS (controllo al OS)
			
CSEG		ENDS
			END			start		       ;fine del modulo