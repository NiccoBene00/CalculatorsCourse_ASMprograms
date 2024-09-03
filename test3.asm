;Allocati un vettore di cinque elementi di tipo intero, oppurtunamente inizializzati,
;questo programma calcola la somma dei valori contenuti nel vettore e scrive
;il risultato nella variabile RESULT

		.MODEL small
		.STACK
		.DATA
VETT	DW		5, 7, 3, 4, 3 	;vettori di interi di cui specifico
								;l'inizializzazione
RESULT	DW		?				;definisco la variabile RESULT (di tipo word, ossia due byte) senza
								;inizializzarla
		.CODE
		.STARTUP
		MOV		AX, 0 			;azzero il registro AX
		ADD		AX, VETT		;sommo contenuto di AX con valore 5 (1° elemento di VETT)
		ADD		AX, VETT+2		;sommo contenuto di AX con valore 7 (2° elemento di VETT) 
		ADD		AX, VETT+4		;sommo contenuto di AX con valore 3 (3° elemento di VETT)
		ADD 	AX, VETT+6		;sommo contenuto di AX con valore 4 (4° elemento di VETT)
		ADD 	AX, VETT+8		;sommo contenuto di AX con valore 3 (5° elemento di VETT)
		MOV 	RESULT, AX		;copio contenuto di AX dentro la variabile RESULT
		.EXIT
		END

;OSSERVAZIONE: sapendo che ogni elemento del vettore occupa due byte (1 word), allora 
; VETT = contenuto della cella dato dall'indirizzo VETT, ossia il primo elemento 
;		 del vettore
; VETT+2 = secondo elemento del vettore
; VETT+4 = terzo elemento del vettore
; ...