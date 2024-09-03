;Programma che, dato un vettore di 10 interi, visualizza un messaggio diverso a seconda
;che il numero sia positivo o negativo.
;La soluzione in linguaggio C è la seguente:

;	#include <stdio.h>;
;	#define LUNG 10
;	main()
;	{
;		int i, int vett[LUNG];
;		...
;		for (i = 0; i < LUNG; i++)
;			if(vett[i] > 0 ) printf ("Numero positivo\n");
;			else printf ("Numero negativo\n");
;		}
;	}

LUNG		EQU		10
			.MODEL	small
			.DATA
MSG1		DB		"Numero Negativo", 0Dh, 0AH, "$"
MSG2		DB		"Numero Positivo", 0Dh, 0AH, "$"
VETT		DW		LUNG DUP (?)
			.CODE
			...
			MOV		SI, 0
			MOV		CX, LUNG
ciclo:		CMP		VETT[SI], 0	;(VETT[SI] > 0) ?
			JNG		lab1		;no: vai a "lab1"
			LEA		DX, MSG2	;si: carica in DX l'offset di MSG2
			JMP		lab2
lab1:		LEA		DX, MSG1	;carica in DX l'offset di MSG1
lab2: 		MOV		AH, 09H		;istruzione per visualizzazione a video
			INT		21h			;istruzione per visualizzazione a video
			ADD		SI, 2		;incremento indice per scansionare il vettore
			LOOP 	ciclo
			...
				


