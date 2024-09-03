;Programma implementato per sommare gli elementi di un vettore (II-implementazione)

DIM		EQU		15 ;definisco la costante DIM e la inizializzo al valore 15
				   ;definisce la dimensione del vettore
		.MODEL	small
		.STACK
		.DATA
VETT	DW 		2, 5, 16, 12, 34, 7, 20, 11, 31, 44, 70, 69, 2, 4, 23
RESULT	DW		? ;definisco una variabile RESULT (di tipo word, ossia due byte) senza tuttavia inizializzarla
		.CODE
		.STARTUP
		
		MOV		CX, 0 ;azzero il registro CX
		MOV		CX, DIM ;carico in CX il valore di DIM
		MOV		DI, 0 ;azzero il registro DI
		
lab:	ADD		AX, VETT[DI] ;sfruttando per il secondo operando il modo di indirizzamento 
							 ;diretto con indice 
							 ;accedo ai diversi elementi di VETT utilizzando DI come 
							 ;indice
		ADD		DI, 2 ;siccome la memoria è organizzata a byte, allora per passare da
					  ;un elemento al successivo mi devo spostare di due unità
		DEC		CX    ;decremento CX di un'unità. Lo utilizzo come indice del ciclo
					  ;per sommare tutti gli elementi di VETT
		CMP 	CX, 0 ;confronto il contatore con 0
		
		JNZ		lab   ;se diverso da 0 allora vai a "lab" (Jump-Not-Zero)
		MOV		RESULT, AX ;altrimenti scrivi il risultato in RESULT
		
		.EXIT
		END
		