;Programma ASSEMBLER che determina se un anno è o meno bisestile. 
;NOTA: un anno è bisestile se è divisibile per 4, con l'eccezione degli anni secolari (ossia quelli 
;	   divisibili per 100).Però quelli secolari sono bisestili se sono divisibili anche per 400.

;Lo pseudocodice da tradurre è il seguente:

;	IF(anno divisibile per 100){
;		IF(anno divisibile per 400)
;			Anno_bisestile = TRUE
;		ELSE Anno_bisestile = FALSE
;	}ELSE{
;		IF (anno divisibile per 4)
;			Anno_bisestile = TRUE
;		ELSE Anno_bisestile = FALSE
;	}

;Implementare una procedura per la risoluzione del problema. La procedura deve ricevere come input:
;	- tramite il registro SI l'offset di un vettore di word contenente gli anni da valutare
;	- tramite il registro DI l'offset di un vettore di byte della stessa lunghezza, che dovrà contenere,
;     al termine dell'esecuzione della procedura, nelle posizioni corrispondenti agli anni espressi
;	  nell'altro vettore, il valore 1 se l'anno è bisestile oppure 0 nel caso opposto
;	- tramite il registro BX la lunghezza di tali vettori

;Vogliamo una cosa del genere:
;	anni:		1945, 2008, 1800, 2006, 1748, 1600
;	risultato:	   0,    1,    0,    0,    1,    1
; 	lunghezza: 	   6

LUNG		EQU		6		;costante che identifica la lunghezza dei due vettori
			.MODEL	small	
			.STACK
			
			.DATA

anni		DW		1945, 1800, 2006, 1748, 1600 ;vettore contenente gli anni da analizzare
ris			DB		LUNG DUP (?)				 ;vettore risultato
			
			.CODE
			.STARTUP
			
			LEA		SI, anni	;copio l'OFFSET del vettore anni dentro il registro SI
			LEA		DI, ris		;copio l'OFFSET del vettore ris dentro il registro DI
			
			MOV		BX, LUNG	;BX contiene la costante che identifica la lunghezza dei due vettori
				
			CALL	BISESTILE	;chiamata alla procedura
				
			.EXIT
			
;Definisco adesso la procedura per il riconoscimento degli anni bisestili
;Dati in ingresso:	SI - offset del vettore di word rappresentante anni 
;					DI - offset del vettore di byte per risultato
;					BX - lunghezza vettori

BISESTILE	PROC

			PUSH	AX	;salvataggio registro AX dentro lo stack
			PUSH	BX	;salvataggio registro BX dentro lo stack
			PUSH	CX	;salvataggio registro CX dentro lo stack
			PUSH	SI	;salvataggio registro SI dentro lo stack
			PUSH	DI	;salvataggio registro DI dentro lo stack

ciclo:		MOV		[DI], 0	;sposto il valore 0 nella posizione i-esima del vettore ris

			MOV		AX, [SI] ;carico AX con il contenuto dell'elemento i-esimo del vettore anni
			
			MOV		CL, 100	 ;sposto la costante 100 dentro CL
			
			DIV		CL	;siccome l'operando (CL) è di tipo byte allora l'istruzione DIV produce la divisione tra
						;contenuto di AX e contenuto di CL e restituisce il quoziente in AL e il resto in AH
						;Sto quindi effettuando tale divisione per vedere se l'anno è secolare o meno
			
			CMP		AH, 0	;confronto il contenuto di AH (resto della divisione sopra) con 0
			JNZ		non_sec ;JNZ salta a "non_sec" sse la condizione (AH = 0) è falsa
			
			;se arrivo qua significa che la divisione ha prodotto un resto = 0
			MOV		CL, 400	;adesso vado a verificare la divisibilità anche per 400
			DIV		CL	;stesso discorso della divisione sopra. Siccome CL è un operando byte allora DIV esegue la
						;divisione tra il contenuto di AX e il contenuto di CL. Il quoziente viene salvato in AL e il 
						;resto in AH
			
			CMP		AH, 0	;confronto contenuto di AH (resto della divisione) con 0
			JNZ		next    ;se il resto della divisione non è zero (anno secolare) allora salta a "next"
					
			MOV		[DI], 1 ;se il resto della divisione è 0 allora arrivo a questa istruzione.
							;Dunque scrivo un 1 nella posizione corrispondente del vettore ris
			
			JMP		next	;analizzo un altro elemento del vettore anni 

non_sec:	;anno non secolare: verifica divisibilità per 4 per vedere se fosse bisestile
			MOV		CL, 4
			DIV		CL	;contenuto(AX)/4 e pongo quoziente in AL e resto in AH

			CMP		AH, 0 ;confronto il resto della divisione con 0
			JNZ		next  ;se il resto della divisione non è 0 (anno non bisestile) allora salta a "next".
						  ;Non devo modificare ris in quanto era già stato inizializzato con 0 nella prima istruzione
						  ;relativa all'etichetta "ciclo"
			
			MOV		[DI], 1 ;se arrivo a questa istruzione allora l'anno è bisestile per cui pondo un 1 nella
							;posizione corrispondente del vettore ris
			
next:		;mi permette di andare avanti con la scansione del vettore anni
			ADD		SI, 2 ;incremento il registro relativo all'indice del vettore anni
			INC		DI	  ;incremento il registro relativo all'indice del vettore ris (mi basta incrementarlo di 
						  ;una sola unità in quanto ris è definito per byte)
						  
			DEC		BX	  ;decremento il contatore del ciclo (BX conteneva la lunghezza del vettore anni)
			
			JNZ		ciclo ;salta a label "ciclo" se ZF != 0
						  ;RICORDA: il flag di zero viene forzato a 1 se il risultato dell'operazione è 0.
			
			;libero i registri dallo stack in ordine inverso circa il salvataggio iniziale 
			POP		DI
			POP		SI
			POP		CX
			POP		BX
			POP		AX
			
			RET		;ritorno al chiamante
			
BISESTILE	ENDP	;fine della procedura
			
			END	
			
			