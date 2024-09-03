;Programma che valuta il numero di elementi positivi e negativi all'interno
;di un vettore.
;La soluzione in linguaggio C proposta è:

;	#define LUNG 10
;	main()
;	{
;		int i, count_neg = 0, count_pos = 0, vett[LUNG];
;		...
;		for( i = 0; i < LUNG; i++){
;			if(vett[i] >= 0)
;				count_pos++;
;			else count_neg++;
;		...
;		}
;	}

LUNG		EQU		10
			.MODEL	small
			.DATA
VETT		DB		LUNG DUP (?) ;definisco una variabile VETT (di tipo byte) di LUNG elementi non
								 ;inizializzati
COUNT_POS	DW		? ;definisco una variabile COUNT_POS (di tipo word) non inizializzata
COUNT_NEG	DW		? ;definisco una variabile COUNT_NEG (di tipo word) non inizializzata

			.CODE
			...
			
			MOV		SI, 0 ;indice del vettore
			MOV		AX, 0 ;contatore dei numeri positivi
			MOV		BX, 0 ;contatore dei numeri negativi
			MOV		CX, LUNG ;contatore del ciclo (devo infatti eseguire esattamente LUNG iterazioni)
			
ciclo:		CMP		VETT[SI], 0 ;condizione (VETT[SI] >= 0) ?
			JGE		pos         ;vai a "pos" se maggiore o uguale (con segno)
			INC 	BX          ;condizione non verificata: incrementa contatore numeri negativi
			JMP		continua    ;vai a "continua" incondizionatamente"
			
pos:		      INC		AX	      ;si: incrementa contatore numeri positivi
		      JMP		continua    ;vai a "continua" incondizionatamente
			
continua:	      INC		SI ;aggiorna indice vettore
			LOOP	ciclo
			MOV		COUNT_POS, AX ;copia di AX nella variabile COUNT_POS
			MOV		COUNT_NEG, BX ;copia di BX nella variabile COUNT_NEG
			...
				