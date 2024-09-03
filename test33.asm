;Realizzare una procedura che esegua la somma di un vettore di numeri interi positivi; se è stata
;riscontrata una condizione di errore, la procedura chiamante deve visualizzare un messaggio di errore.
;Si presenti anche la soluzione in linguaggio C

;------------------------------------------------

;	int som_vett(int *vett, int count)
;
;	main()
;	{
;		int dati[100], somma;
;		...
;		somma = som_vett(dati, 100);
;		if (somma == -1)
;			printf("Vector data error\n");
;		...
;	}

;	int som_vett(int *vett, int count)
;	{
;		int i, somma = 0;
;		for (i = 0; i < count; i++)
;			if(dati[i] >= 0)
;				somma += dati[i];
;			else return (-1);
;		return (somma);
;	}

;------------------------------------------------

;Adesso si presenta la relativa soluzione in linguaggio ASSEMBLER

;------------------------------------------------

LUNG		EQU		100
			.MODEL	small
			.DATA
			
DATA		DW		LUNG DUP (?) ;vettore dei dati
SUM			DW		?			 ;variabile su cui salvo la somma finale
MSG			DB		"Vector data error", 0Dh, 0Ah, "$" ;messaggio da visualizzare in caso di errore

			.CODE
			...
			
			MOV		AX, LUNG	;copio dentro il registro AX la lunghezza del vettore
			LEA		BX, DATA	;copio l'OFFSET del vettore DATA nel registro BX
			SUB		SP, 2		;alloca un'area dello STACK pari a 1 word (2 byte) per il parametro di ritorno
								;(la somma finale)
		
			PUSH	AX			;carico il primo parametro sullo stack
			PUSH	BX			;carico il secondo (e ultimo) parametro sullo stack
			
			CALL	SOM_VETT	;chiamata alla procedura
			
			ADD		SP, 4		;liberazione dello stack (equivale a due istruzioni POP, in quanto ho caricato
								;due parametri in ingresso sullo stack)
			
			MOV		SUM, AX		;copio il contenuto di AX dentro la variabile SUM
			
			POP		AX			;liberazione dello STACK del parametro di ritorno
			
			JNC		fine		;JNC verifica la condizione (CF == 0) ? Se verificata salta a "fine"
								;OSSERVAZIONE: utilizzo il flag CF per la segnalazione della condizione di errore
								;verificatasi all'interno della procedura
			LEA		DX, MSG		;Se condizione non verificata allora devo visualizzare il messaggio di errore, per cui
								;copio intanto l'OFFSET di MSG nel registro DX
			MOV		AH, 09h		;visualizzo MSG a video
			INT		21h			;visualizzo MSG a video
			
fine:		...


SOM_VETT	PROC
					
			MOV		BP, SP 		;copio SP in BP.
								;RICORDA: questa operazione deve essere eseguita prima del PUSH dei registri, 
								;in quanto il PUSH va a modificare il valore di SP.
								
			;adesso posso procedere al salvataggio dei registri sullo stack					
			PUSH	BX			;BX viene utilizzato per referenziare il vettore DATA
			PUSH	CX			;CX viene utilizzato come contatore del ciclo necessario per scansionare il vettore
								;DATA
			PUSH	DX			;DX viene utilizzato come deposito temporaneo degli elementi di DATA	
			
			;adesso provvedo a riempire correttamente i registri con i parametri inizialmente salvati sullo stack
			MOV		CX, [BP+4]	;carico nel registro CX il primo parametro salvato sullo stack.
								;Sto cioè copiando il contenuto di AX (lunghezza del vettore DATA) dentro CX.
			MOV		BX, [BP+2]	;carico nel registro BX il secondo (e ultimo) parametro salvato sullo stack.
								;Sto cioè copiando in BX l'OFFSET del vettore DATA
			
			XOR		AX, AX		;azzero il registro AX. Utilizzerò infatti AX per salvare le somme parziali.
			
ciclo:		MOV		DX, [BX]	;copio l'elemento indice-esimo del vettore DATA dentro il registro DX
			
			CMP		DX, 0		;confronto il contenuto di DX con 0
			JNL		ok			;JNL effettua il salto a "ok" se destinazione >= sorgente,
								;ossia se DX >= 0 (elemento del vettore >= 0)
			
			STC					;condizione non rispettata, allora forza a 1 il flag CF (condizione di errore)
			
			JMP		fin			;salta a "fin" (fine della procedura)
			
ok:			ADD		AX, [BX]	;sono nel caso in cui posso eseguire la somma
			ADD		BX, 2		;incremento (di due unità, in quanto DATA è definito per word) l'indice 
								;per scorrere il vettore DATA
			LOOP	ciclo
			CLC					;azzero il valore di CF
			
fin:		POP		DX			;ripristino dei registri dallo stack
			POP		CX			;ripristino dei registri dallo stack
			POP		BX			;ripristino dei registri dallo stack
			
			RET					;ritorno al chiamante
			
SOM_VETT	ENDP				;fine della procedura
			

;------------------------------------------------

			.EXIT
			END