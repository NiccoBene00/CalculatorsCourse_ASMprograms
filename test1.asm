;Primo banale programma che ha la funzione di scrivere 0 in una cella di memoria
;Tutto ciò che è preceduto da un punto definisce un comando per l'assemblatore, mentre
;il resto definisce un'istruzione vera e propria.

		.MODEL 			small 
		.STACK
		.DATA
VAR		DW				? ;definizione di una variabile in memoria di nome VAR di lunghezza
						  ;pari a una word (due byte) NON inizializzata all'atto della 
						  ;definizione (?)
		.CODE             ;direttiva per l'allocazione del segmento di codice e a essa deve
					      ;seguire il programma vero e proprio
		.STARTUP	      ;direttiva che si occupa di creare l'interfaccia con l'OS, che possiede
						  ;il controllo del sistema nel momento in cui l'utente richiede 
						  ;l'esecuzione del programma
		MOV				VAR,0 ;carico il valore 0 nella variabile VAR
		.EXIT
		END
		