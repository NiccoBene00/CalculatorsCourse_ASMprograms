;Programma che esegue la copia di un vettore di interi da un'area di memoria sorgente 
;a un'area di memoria destinazione. Una possibile soluzione in linguaggio C potrebbe essere

;	#define LUNG 500
;	main()
;   {
;	int i, dest[LUNG], sorg[LUNG];
;	...
;	for (i=0 ; i<LUNG ; i++)
;		dest[i] = sorg[i]
;	}


LUNG		EQU		500
			.MODEL	small
			.DATA
			
SORG		DW		LUNG DUP(?)
DEST		DW		LUNG DUP(?)

			.CODE
			...
			
			MOV		SI, OFFSET SORG ;copia in SI l'offset del vettore SORG
			MOV		DI, OFFSET DEST ;copia in DI l'offset del vettore DEST
			MOV		CX, LUNG		;copia in CX del numero di elementi. CX viene utilizzato come contatore.
			
ciclo:		MOV		AX, [SI]
			MOV		[DI], AX
			ADD		SI, 2			;aggiornamento dei registri indice
			ADD		DI, 2			;aggiornamento dei registri indice
			
			LOOP 	ciclo ;l'istruzione LOOP esegue direttamente un ciclo for per |contenuto di CX| 
						  ;iterazioni
			
			...
			
			END