;Le istruzioni DIV (DIVision, unsigned) e IDIV (Integer DIVision, signed) permettono di eseguire
;l’operazione di divisione tra numeri interi rispettivamente senza segno o con segno.

		DIV     operando
		IDIV	operando

;L’operando può essere il contenuto di un registro oppure il contenuto di una locazione di memoria.
;Le istruzioni DIV e IDIV non aggiornano i flag: il valore dei flag di stato dopo un’istruzione
;di divisione è indefinito.
;L’unica differenza tra le due istruzioni è il tipo di dato su cui esse lavorano; l’istruzione DIV
;opera su numeri interi senza segno e l’istruzione IDIV su numeri interi con segno.
;Entrambe le istruzioni possono eseguire due tipi di operazioni:
;	1. divisione tra un operando di tipo word ed un operando di tipo byte
;	2. divisione tra un operando di tipo doubleword ed un operando di tipo word,
;restituendo comunque due risultati: il quoziente ed il resto.
;Il comportamento dell’istruzione è diverso a seconda del tipo di operazione:
;	1. se l’operando è di tipo BYTE, il processore esegue la divisione tra il contenuto del registro
;	   AX (dividendo) ed il contenuto dell’operando (divisore); come risultato della divisione,
;	   l’istruzione restituisce il quoziente nel registro AL ed il resto nel registro AH.
;	2. se l’operando è di tipo WORD, il processore esegue la divisione tra il contenuto della coppia
;	   di registri DX,AX (dividendo) ed il contenuto dell’operando (divisore); come risultato della
;	   divisione, l’istruzione restituisce il quoziente nel registro AX ed il resto nel registro DX.
;Una condizione di overflow si può verificare nel caso in cui il divisore sia troppo piccolo. In tal
;caso il processore rileva l’errore e salta alla procedura di interruzione per la gestione della divisione
;per zero (interrupt di tipo 0).
