;Viene qui presentata la modalità con cui ASSEMBLER gestisce le stringhe.
;Le operazioni da compiere per l’esecuzione di un ciclo di istruzioni per la manipolazione di
;stringhe sono:

;	1. preparazione dei registri;
;	   - La prima stringa (denominata sorgente) si deve trovare nel segmento di dato puntato da DS ed il registro
;	     SI deve memorizzare l’indirizzo di offset dell’elemento da elaborare all’interno della sequenza;
;	   - l’eventuale seconda stringa (denominata destinazione) si deve trovare nel segmento extra di dato
;	     puntato da ES ed il registro DI deve memorizzare l’indirizzo di offset dell’elemento da elaborare.
;
;	   Se i dati sono contenuti in un unico segmento di dato, le operazioni da fare per predisporre i registri
;	   per la manipolazione delle stringhe sono le seguenti:
;	   	 copiare il contenuto del registro DS nel registro ES in modo da far coincidere i due segmenti;
;		 copiare gli offset delle due stringhe nei registri SI e DI.
;
;	   esempio:

				.MODEL	small
	   LUNG		EQU		100
				.DATA
	   STR1		DB		LUNG DUP (?)
	   STR2		DB		LUNG DUP (?)
				.CODE
				...
				PUSH	DS
				POP		ES			;caricamento del registro ES
				LEA		SI, STR1	;caricamento in SI dell'indirizzo di partenza della stringa STR1
				
				LEA		DI, STR2	;caricamento in DI dell'indirizzo di partenza della stringa STR2



;	   In programmi complessi i dati sono suddivisi su più segmenti ed in generale i registri DS ed ES
;	   contengono indirizzi di segmenti diversi.
;	   La condizione di default prevista dal processore è quella di avere la stringa sorgente nel segmento
;	   di dato e la stringa destinazione nel segmento extra: in questo caso per caricare i registri SI e DI
;	   basta eseguire l’istruzione LEA.

;	   esempio:
		
				.MODEL		compact   ;un segmento di codice, più segmenti di dato
	   LUNG		EQU			100
				.FARDATA	segm1 
	   STR1		DB			LUNG DUP (?)
				.FARDATA	segm2
	   STR2		DB			LUNG DUP (?)
				.CODE
				ASSUME		DS:segm1, ES:segm2
				LEA			SI, STR1
				LEA			DI, STR2
				...


;	2. caricamento del registro CX con il numero di elementi della stringa;
;	3. aggiornamento del flag DF;
;	4. esecuzione dell’istruzione REP (o REPE o REPNE) abbinata all’opportuna istruzione 
;	   di manipolazione:

	   REP		string_istruz	;ripete il ciclo per un numero di volte pari al contenuto del
								;registro CX

	   REPE		string_istruz	;ripete il ciclo finchè il registro CX ha un valore diverso da 0 e
								;le parole confrontate sono uguali (può essere utile per cercare una
								;parola che non corrisponda a un determinato valore)
	   
	   REPNE	string_istruz	;ripete il ciclo finchè il registro CX ha un valore diverso da 0 e le
								;parole confrontate sono diverse (è utile quando sto cercando una parola
								;con un determinato valore)

;	   Dunque per usare le istruzioni REP, REPE, REPNE occorre caricare il registro CX con la dimensione
;	   della stringa; analogamente a quanto avviene con l'istruzione LOOP, ad ogni esecuzione dell'istruzione
;	   di ripetizione il contenuto di CX viene decrementato di un'unità. La differenza sostanziale tra 
;	   l'istruzione LOOP e l'istruzione REP è che quest'ultima permette di ripetere un'unica istruzione
;      di manipolazione di stringhe, mentre LOOP permette di ripetere una generica sequenza di istruzioni.

;Abbiamo quindi appurato che le istruzioni per la manipolazione delle stringhe prevedono che i registri 
;SI e DI contengano l'offset delle parole da elaborare. Quando si esegue ripetutamente una stessa 
;istruzione di manipolazione, il contenuto dei registri è automaticamente aggiornato per indirizzare
;la parola successiva nella stringa, in base al valore del flag di direzione (DF), contenuto nella PSW.
;	- se DF vale 0, dopo ogni esecuzione dell’istruzione di manipolazione il contenuto dei
;     registri di indice è incrementato di un’unità, per le stringhe di byte, o di due unità, per le
;     stringhe di word;
;   - se il flag DF vale 1, dopo ogni esecuzione dell’istruzione di manipolazione il contenuto dei
;     registri di indice è decrementato di un’unità, per le stringhe di byte, o di due unità, per le
;     stringhe di word.
;A seconda del valore del flag DF le operazioni sulle stringhe vengono quindi eseguite in avanti
;(forward) oppure all’indietro (backward). Il valore del flag DF può essere modificato mediante le
;due istruzioni STD e CLD, che lo forzano rispettivamente a 1 e a 0.

;	esempio: il seguente frammento di codice copia la stringa STR1 nella stringa STR2, con una scansione
;			 in avanti.

				.MODEL	small
	LUNG		EQU		100
				.DATA
				
	STR1		DB		LUNG DUP (?)
	STR2		DB		LUNG DUP (?)
				
				.CODE
				...
				PUSH	DS
				POP		ES
				LEA		SI, STR1
				LEA		DI, STR2
				MOV		CX, LUNG
				CLD						;DF = 0 : scansione in avanti
				REP		MOVSB
				...
				
;	esempio: il seguente frammento di codice copia la stringa STR1 nella stringa STR2, con una scansione
;			 all'indietro. 

				.MODEL	small
	LUNG		EQU		100
				.DATA
				
	STR1		DB		LUNG DUP (?)
	STR2		DB		LUNG DUP (?)
				
				.CODE
				...
				PUSH	DS
				POP		ES
				LEA		SI, STR1 + SIZE STR1 - TYPE STR1
				LEA		DI, STR2 + SIZE STR2 - TYPE	STR2
				MOV		CX, LUNG
				STD						;DF = 1 : scansione in avanti
				REP		MOVSB
				...

;	OSSERVAZIONE: L’istruzione MOVSB aggiorna il contenuto di SI e DI dopo la copiatura di ciascun
;	              byte; nel primo esempio DF vale 0 e MOVSB incrementa di una unità i registri di indice;
;                 nel secondo DF vale 1 e MOVSB decrementa di una unità i registri SI e DI.	