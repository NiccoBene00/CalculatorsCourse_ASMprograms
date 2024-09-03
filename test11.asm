;Programma che ricerca il massimo in un vettore di numeri positivi.
;L'equivalente codice C è il seguente:
;	#define LUNG 10
;	main()
;	{
;		int i, massimo = -1;
;		unsigned int vett[LUNG];
;		...
;		for(i = 0 ; i < LUNG ; i++)
;			if(vett[i] > massimo)	  
;				massimo = vett[i];
;		...
;	}

LUNG		EQU		10
			.MODEL	small
			.DATA
VETT		DW		LUNG DUP (?) ;definisco una variabile vettore VETT di LUNG elementi non inizializzati
MASSIMO		DW		?            ;definisco una variabile (di tipo word) non inizializzata
			.CODE
			...
			
			LEA		SI, VETT ;copia dell'offset di VETT in SI
			MOV		AX, 0 ;utilizzo il registro AX per memorizzare il 
						  ;massimo valore temporaneo del vettore
			MOV		CX, LUNG
			
ciclo:		CMP		AX, [SI] ;(VETT[SI] >= AX) ?
			JA		scans    ;no: vai a "scans"
			MOV		AX, [SI] ;si: aggiorno il massimo
			
scans:		ADD		SI, 2  ;aggiorno l'indice utilizzato per il confronto
			LOOP	ciclo
			MOV		MASSIMO, AX ;copia di AX nella variabile MASSIMO	