;Dati due vettori di 50 word ciascuno:
;	- prezzi, rappresentante i prezzi di 50 articoli venduti in un negozio
;	- scontati, inizialmente di contenuto indeterminato

;Scrivere una procedura in grado di calcolare il prezzo scontato di ciascun articolo e salvarlo nel 
;corrispondente elemento del vettore scontati. La procedura deve leggere da una variabile intera di tipo
;word denominata sconto l'ammontare dello sconto percentuale da applicare. Si esegua un arrotondamento alla
;cifra superiore se la parte decimale del prezzo risultante è maggiore o uguale a 0,5.
;Inoltre, la procedura deve salvare in una variabile di tipo word totsconto l'ammontare totale delle
;riduzioni effettuate.

;Esempio
;		prezzi:		39, 1880, 2394, 1000, 1590
;		sconto: 	30
;		scontati: 	27, 1316, 1676,  700, 1113
;		totsconto:	2068

DIM			EQU		5

			.MODEL	small
			.STACK
			
			.DATA
			
prezzi		DW		39, 1880, 2394, 1000, 1590	;vettore dei prezzi iniziali
scontati	DW		DIM DUP (?)				  	;vettore (non inizializzato) che andrà riempito con i prezzi scontati
sconto		DW		30							;variabile che rappresenta la percentuale di sconto
totsconto	DW		?
			
			.CODE
			.STARTUP
			
			CALL	SCONTI	;chiamata alla procedura 
			
			.EXIT

;------------------------------------------------
;Definisco adesso la procedura SCONTI per il calcolo dei prezzi scontati

;Dati in ingresso:	prezzi - vettore globale di DIM word
;					sconto - variabile globale word

;Risultati:			scontati - vettore globale di DIM word
;					totsconto - variabile globale word

SCONTI		PROC

			MOV		totsconto, 0	;inizializzo la variabile che rappresenta la somma delle diminuzioni di prezzo
									;di ogni articolo
									
			MOV		CX, DIM			;inizializzo CX con la lunghezza del vettore prezzi
			
			MOV		SI, 0			;indice che utilizzo per scansionare il vettore prezzi
			
			MOV		BX, 100			;inizializzo il registro BX con il valore 100
							
ciclo:		MOV		AX, prezzi[SI]	;carico AX con l'elemento SI-esimo del vettore prezzi
			
			;calcolo frazione prezzo
			SUB		BX, sconto		;BX = contenuto (BX) - sconto
					 				;RICORDA: l'istruzione SUB esegue una sottrazione tra l'operando destinazione
									;(BX) e l'operando sorgente (sconto) e il risultato è memorizzato nell'operando
									;destinazione, mentre l'operando sorgente rimane immutato.
									;Nel caso del primo elemento del vettore prezzi si ha che BX = 100 - 30 = 70
			
			MUL		BX				;DX = AX*BX
									;AX = AX*BX
									;Siccome BX è di tipo WORD allora l'istruzione MUL esegue la moltiplicazione
									;tra il contenuto di AX e il contenuto di BX e pone il risultato nei registri
									;DX (word più significativa) e AX (word meno significativa)
									;Nel caso singolare del primo elemento di prezzi si ha il prodotto 39*70
			
			MOV		BX, 100			;copio il valore 100 dentro il registro 100
			
			DIV		BX				;siccome BX è di tipo WORD allora sto eseguendO la divisione tra la coppia di 
									;registri DX, AX (dividendo) e l'operando BX (che vale 100).
									;DIV restituisce poi il quoziente nel registro AX e il resto nel registro DX.
									;Sempre continuando il nostro caso particolare avremo (39*70)/100
			
			;arrotondamento
			CMP		DX, 50			;confronto il resto della divisione sopra con il valore 50
									;nel nostro caso ottengo un resto per cui devo approssimare, ossia un valore 
									;decimale >= 0.5
			JB		next			;JB salta a "next" sse destinazione(DX) < sorgente(50)
									;nel nostro caso NON salto a label "next"
									
			ADD		AX, 1			;se arrivo a questa istruzione allora sono nel caso destinazione (DX) >= sorgente (50)
									;incremento dunque di 1 il contenuto di AX (che memorizzava in ultimo luogo 
									;il quoziente della divisione)
									;Sono quindi nel caso in cui la cifra decimale è >= 0.5 per cui devo passare alla 
									;cifra successiva per arrotondamento
									;nel nostro caso approssimo
			
next:		MOV		scontati[SI], AX ;sposto il contenuto di AX (quoziente della divisione) dentro il vettore 
									 ;scontati alla posizione SI-esima
									 ;nel nostro caso scontati[SI] = 12
									 
			MOV		DX, prezzi[SI]	;carico DX con il prezzo SI-esimo
									;nel nostro caso DX = 39
			
			SUB		DX, AX			;DX = DX - AX
									;nel nostro caso DX = 39 - 12 = 27
			
			ADD		totsconto, DX	;sommo i nuovi prezzi scontati
						
			ADD		SI, 2			;incremento il contatore del ciclo per scansionare il prossimo elemento del 
									;vettore prezzi (incremento SI di due unità in quanto prezzi è definito per WORD)
			LOOP	ciclo			;ciclo, decrementando CX
			
			RET						;ritorno al chiamante
			
SCONTI		ENDP					;fine della procedura

;------------------------------------------------
			
			END
