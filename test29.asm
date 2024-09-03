;Programma ASSEMBLER che determina se ciascuno dei numeri naturali (>=2) contenuti in un vettore è primo o no.

;Siano dati:
;	- un vettore di byte contenente DIM elementi (DIM è dichiarato come costante)
;	- un vettore di byte risultato della stessa dimensione che dovrà contenere, per ogni numero analizzato, un valore 
;	  logico 1 se il numero nella stessa posizione è primo e 0 altrimenti
;Tale vettore sarà modificato da un'apposita procedura.
;Supporre che il programma chiamante lanci la procedura una volta sola, passando gli indirizzi iniziali dei vettori
;e risultato, rispettivamente, attraverso i registri SI e DI.

;	esempio:
;			DIM			EQU			6
;			numeri					2,		15,		36,		37,		20,		97
;			risultato				1,		 0,		 0,		 1,	     0,		 1

DIM		EQU		6
		.MODEL	small
		.STACK	

		.DATA

numeri	DB		2, 15, 36, 37, 37, 20, 97
ris		DB		DIM DUP (?)

		.CODE
		.STARTUP

		LEA		SI, numeri ;copio l'OFFSET del vettore numeri dentro il registro SI
		LEA		DI, ris	   ;copio l'OFFSET del vettore ris dentro il registro DI
		
		CALL	PRIMI	;chiamata alla procedura PRIMI

		.EXIT

;La procedura PRIMI ha come dati in ingresso SI (offset di un vettore di DIM byte) e DI (offset di un vettore di 
;DIM byte per risultato)

PRIMI	PROC

		MOV		CX, DIM	;copio la lunghezza del vettore dentro il registro CX

ciclo1:	PUSH	CX	;salvo dentro lo stack il registro CX
		
		MOV		BL, [SI]	;copio dentro il registro BL l'elemento i-esimo del vettore numeri
		
		CMP		BL, 2	;confronto il contenuto del registro BL con il numero 2
		JBE 	primo	;l'istruzione JBE salta a "primo" sse destinazione <= sorgente
						;e quindi in questo specifico caso sse BL <= 2 (chiaramento il numero 0,1,2 sono primi)
		
		MOV		CL, BL	;se la condizione JBE non è rispettata allora copia il contenuto di BL in CL
		
		XOR		CH, CH	;ripulisco il registro CH, corrisponde a CH = 0.
		
		DEC		CX	;decremento di un'unità il registro CX
		
		MOV		BYTE PTR [DI], 0	;sposto il valore 0 nell'elemento i-esimo del vettore ris
								
		
ciclo2:	MOV		AL, BL	;sposto il contenuto di BL (i-esimo elemento del vettore numeri) dentro AL
		
		XOR		AH, AH	;ripulisco AH, reinizializzandolo a 0
		
		DIV		CL	;osservo che l'operando (registro CL) è di tipo BYTE, dunque l'istruzione DIV esegue una divisione
					;tra il contenuto del registro AX (dividendo) e il contenuto dell'operando (divisore).
					;Come risultato della divisione avrò il quoziente nel registro AL e il resto nel registro AH.	
		
		CMP		AH, 0 ;confronto il contenuto di AH (resto della divisione sopra) con il numero 0
		JE		next  ;l'istruzione JE impone la condizione destinazione = sorgente
					  ;In questo specifico caso salto a "next" se la condizione è verificata
			
		DEC		CX	  ;se la condizione non è verificata allora decremento il contenuto di CX
		
		CMP		CX, 1	;confronto il contenuto di CX con il numero 1 
		JNE		ciclo2	;l'istruzione JNE salta (in questo caso) a "ciclo2" sse destinazione != sorgente


primo:	MOV		BYTE PTR [DI], 1 ;copio il valore 1 nelle posizione i-esima del vettore ris (corrisponde ad aver trovato
								 ;un numero primo)
								 

next:	;procedo ad analizzare il prossimo elemento del vettore numeri

		INC		SI	;incremento di un'unità il contenuto del registro SI. Sto cioè scansionando il vettore numeri,
				    ;vado a analizzare l'elemento successivo
		INC		DI	;scansiono anche il vettore DI, quindi mi posiziono all'elemento successivo
		
		POP		CX	;libero lo stack dal registro salvato inizialmente
		
		LOOP	ciclo1 ;ritono a etichetta "ciclo1" in quanto sto analizzando un nuovo numero del vettore
		
		RET	;istruzione per ritornare al chiamante
		
PRIMI	ENDP	;fine della procedura
		
		END
		