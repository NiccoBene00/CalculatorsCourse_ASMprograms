
		SHL		operando, conteggio
		SHR		operando, conteggio

;L’istruzione SHL esegue lo scorrimento a sinistra del contenuto dell’operando di un numero di
;posizioni pari al valore di conteggio.
;L’istruzione SHR esegue lo scorrimento a destra del contenuto dell’operando di un numero di
;posizioni pari al valore di conteggio.
;L’ultimo bit in uscita viene copiato nel flag CF; tutte le posizioni vuote vengono caricate con bit
;di valore 0. Le istruzioni SHL e SHR aggiornano il valore di tutti i flag di stato (tranne AF).
;Uno degli usi principali delle istruzioni di shift è quello di eseguire operazioni di moltiplicazione
;o divisione per potenze di due su numeri senza segno. Lo shift a destra di n posizioni è equivalente
;alla divisione per 2^(n); lo shift a sinistra di n posizioni è equivalente alla moltiplicazione per 2^(n).

;esempio_1 : divido per 8 il contenuto della variabile DATO

	MOV		CL, 3
	SHR		DATO, CL
	
;esempio_2 : moltiplico per 16 il contenuto della variabile DATO

	MOV		CL, 4
	SHL		DATO, CL
	