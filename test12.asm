;Programma che valuta il numero di lettere minuscole all'interno di un vettore
;stringa.
;Il frammento di programma controlla il codice ASCII di ciascun carattere
;della stringa e verifica se è compreso all'interno dell'insieme dei codici
;delle lettere minuscole. La soluzione proposta in C è la seguente:

;	#define LUNG 20
;	main()
;	{ 
;		int i;		   
;		char vett[LUNG], minuscole = 0;	
;		...
;		for ( i = 0; i < LUNG ; i++)
;		if ((vett[i] >= 'a') && (vett[i] <= 'z')) 
;			minuscole++;
;		...
;	}


LUNG		EQU		20
CAR_A		EQU		"a"
CAR_Z		EQU		"z"
			.MODEL	small
			.DATA
VETT		DB		LUNG DUP (?) ;definisco una varibile vettore VETT di LUNG elementi non inizializzati
MINUSCOLE	DW		?            ;definisco una variabile MINUSCOLE (di tipo word) non inizializzata
			.CODE
			...
			
			MOV		SI, 0 ;azzero il registro SI
			MOV		AX, 0 ;in AX salvo il numero di caratteri minuscoli
			MOV		CX, LUNG ;utilizzo CX come contatore del ciclo (devo eseguire esattamente LUNG iterazioni)
			
ciclo:		CMP		VETT[SI], CAR_A ;(VETT[SI] >= 'a') ?
			JNAE	salta			;vai a "salta" se non è maggiore o uguale
			CMP		VETT[SI], CAR_Z 
			JNLE	salta			;vai a "salta" se non è minore o uguale
			INC		AX				;se arrivo qua significa che ho trovato una lettera minuscola
			
salta:		INC		SI
			LOOP	ciclo
			MOV		MINUSCOLE, AX ;salvo il numero di minuscole nella variabile MINUSCOLE
			...					  
			