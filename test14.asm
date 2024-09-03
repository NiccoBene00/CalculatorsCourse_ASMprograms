;Programma che cerca all'interno di un vettore la prima occorrenza del 
;valore -1.
;La soluzione C proposta è la seguente:

;	#define LUNG 100
;	main()
;	{
;		int i;
;		int vett[LUNG];
;		...
;		for ( i = 0; i < LUNG; i++)
;			if(vett[i] == -1) break;
;		}
;	}

LUNG		EQU		100
			.MODEL	small
			.DATA
VETT		DW		LUNG DUP (?) ;definisco una variabile VETT (di tipo word) senza inizializzarla
			.CODE
			...
			
			MOV		SI, -2 ;inizializzo l'indice del vettore a -2
			MOV		CX, LUNG ;utilizzo CX come contatore delle iterazioni del ciclo (nel peggiore dei casi devo
							 ;scorrere tutto il vettore, ossia eseguire LUNG iterazioni)
			
ciclo:		ADD		SI, 2 ;scansione del vettore
			CMP		VETT[SI], -1 ;(VETT[SI] = -1) ?
			LOOPNE	ciclo	;no e CX != 0: vai all'istruzione "ciclo"
			
;OSSERVAZIONE: l'istruzione che aggiorna il valore dell'indice è stata anticipata
;per fare in modo che l'istruzione di confronto sia l'ultima istruzione a modificare
;i flag prima di LOOPNE. Il primo valore valido dell'indice è 0 e dunque il valore
;di inizializzazione deve essere posto a -2
			