;Inversione di un vettore.
;Frammento di programma che memorizza gli elementi di un vettore nell'ordine
;inverso rispetto quello iniziale.
;La soluzione proposta in C è la seguente

;	#define LUNG 150
;	main()
;	{
;	int i;
; 	char vett[LUNG], temp;
; 	...
;	for (i = 0 ; i < (LUNG/2) ; i++){
;		temp = vett[LUNG-1-i];
;		vett[LUNG-1-i] = vett[i];
;		vett[i] = temp;
;		}
; 	}


LUNG		EQU		150
			.MODEL	small
			.STACK
			.DATA
			
VETT		DB		LUNG DUP (?) ;definisco il vettore VETT di LUNG elementi non inizializzati

			.CODE
			...
			
			MOV		SI, 0 ;SI punta al primo elemento
			MOV		DI, LUNG-1 ;DI punta all'ultimo elemento
			MOV		CX, LUNG/2 ;CX viene utilizzato come iteratore del ciclo (devo infatti eseguire LUNG/2
							   ;iterazioni)
			
ciclo:		MOV		AH, VETT[DI] ;sposto nel registro AH l'elemento di VETT che si trova all'indice DI 
			MOV		AL, VETT[SI] ;sposto nel registro AL l'elemento di VETT che si trova all'indice SI
			MOV		VETT[SI], AH 
			XCHG	VETT[DI], AL
			
			
			INC 	SI ;aggiornamento degli indici
			DEC		DI
			
			LOOP	ciclo
			...