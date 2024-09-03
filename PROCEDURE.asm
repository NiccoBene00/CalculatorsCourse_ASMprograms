;Definiamo e analizziamo come l'8086 gestisce le PROCEDURE.

;Una procedura, detta anche subroutine o sottoprogramma, è una parte di programma costituita
;da un gruppo di istruzioni che eseguono un compito specifico; ogni procedura, memorizzata in memoria
;una volta sola, può essere eseguita un numero qualsiasi di volte.
;L’utilizzo delle procedure permette di risparmiare spazio in memoria e di rendere più modulare
;lo sviluppo di programmi. Il principale svantaggio risiede nel tempo di elaborazione necessario per
;le operazioni di chiamata e di ritorno tra la procedura chiamante e quella chiamata.

;	esempio di definizione di procedura:
	
	L_CAR	PROC 	NEAR	;Una procedura è di tipo NEAR se è richiamabile solo all'interno dello
							;segmento di codice, mentre è di tipo FAR se può essere richiamata da
							;procedure appartenenti a segmenti di codice diversi
							
					...		;istruzioni che costituiscono il corpo della procedura
					
	L_CAR	ENDP	


;L’istruzione CALL (CALL a procedure) trasferisce il controllo del flusso del programma ad una
;specifica procedura; il suo formato è il seguente:
	
	CALL	destinazione

;L’operando destinazione specifica l’indirizzo di inizio della procedura chiamata.
;L’istruzione CALL provvede a salvare nello stack l’indirizzo di ritorno ed a trasferire il controllo
;all’operando destinazione, senza modificare il valore di alcun flag.
;L’indirizzo di ritorno corrisponde all’indirizzo dell’istruzione successiva a quella di CALL; ad
;essa la procedura ritorna al termine della sua esecuzione.
;Se la procedura chiamata è di tipo NEAR, l’istruzione CALL carica nello stack solo il contenuto
;dell’Instruction Pointer (IP), cioè l’indirizzo di offset dell’istruzione successiva.
;Se la procedura chiamata è di tipo FAR, l’istruzione CALL carica nello stack prima il contenuto
;del registro di segmento di codice CS e poi il contenuto del registro IP.
;L’operando destinazione può essere un indirizzo diretto o indiretto. Nel primo caso
;l’operando è costituito dal nome stesso della procedura.

;L'istruzione RET (RETurn from procedure) permette di restituire il controllo alla procedura chiamante,
;una volta che la procedura chiamata ha terminato l'esecuzione.

	RET		{pop_value}		;pop_value è un valore immediato opzionale

;L’istruzione RET esegue le seguenti operazioni:
;	1. pop dallo stack dell’indirizzo di ritorno;
;	2. estrazione dallo stack di un numero di byte pari a pop_value;
;	3. salto all’indirizzo di ritorno.
;Se la procedura è di tipo NEAR il processore preleva dallo stack una word contenente l’offset
;dell’indirizzo di ritorno, mentre nel caso di procedura di tipo FAR dallo stack vengono prelevate due
;word equivalenti all’intero indirizzo di ritorno CS:IP.
;Esistono due diverse istruzioni macchina che permettono di ritornare alla procedura principale:
;una per un ritorno di tipo FAR ed una per un ritorno di tipo NEAR. È compito dell’assemblatore generare
;l’opportuna istruzione in linguaggio macchina, in base al tipo di procedura.

;Per il funzionamento corretto del programma è estremamente importante che l’effetto della procedura
;non sia distruttivo sul resto del programma. Questa implica, tra l’altro, che il contenuto dei
;registri prima della chiamata della procedura sia lo stesso al momento del ritorno. Per ottenere questo,
;la prima operazione da eseguire all’interno di una procedura è il salvataggio nello stack di tutti i
;registri modificati all’interno. Tale operazione è totalmente a carico del programmatore.
;Per ripristinare il contenuto dei registri occorre eseguire l’operazione di pop dei registri dallo
;stack prima dell’esecuzione dell’istruzione RET.
;È bene ricordare che lo stack è una coda di tipo LIFO e dunque l’ordine delle istruzioni POP deve
;essere l’inverso dell’ordine delle istruzioni PUSH.

;	esempio: frammento di procedura che mostra come salvare e ripristinare i registri AX e BX

	name_proc		PROC		NEAR
	
					PUSH		AX		;salvataggio dei registri nello stack
					PUSH		BX		;salvataggio dei registri nello stack
								
					...					;istruzioni
				
					POP			BX		;ripristino dei registri dallo stack
					POP			AX		;ripristino dei registri dallo stack
					
					RET					;ritorno alla procedura chiamante
	
	name_proc		ENDP
	
;A partire dal processore 80186 è possibile utilizzare le istruzioni PUSHA, POPA per salvare nello stack il
;contenuto di tutti i registri.

;PASSAGGIO DEI PARAMETRI
;Esistono diverse tecniche per effettuare il passaggio dei parametri tra procedura chiamante e
;chiamata, classificabili in base al metodo o in base al tramite.
;I possibili metodi con cui i parametri possono essere trasferiti sono:
;	1. una copia del valore del parametro (passaggio by value);
;	2. l’indirizzo del parametro (passaggio by reference).
;In un passaggio by value, la procedura chiamante passa a quella chiamata una copia del parametro.
;Ogni possibile modifica del parametro all’interno della procedura modifica esclusivamente tale
;copia. La procedura chiamante non “vede” le modifiche effettuate sul parametro dalla procedura
;chiamata.
;In un passaggio by reference la procedura chiamante passa alla procedura chiamata l’indirizzo
;del parametro: la procedura chiamata e quella chiamante operano direttamente sulla stessa variabile.
;I possibili tramiti con cui avviene il trasferimento dei dati sono:
;	1. le variabili globali;
;	2. i registri (general purpose);
;	3. lo stack.

;Se il tramite "variabili globali" è da evitare in quanto in netto contrasto con la logica di procedura, anche il
;tramite "registri" non è così consigliato in quanto, nonostante sia un metodo semplice ed efficiente, è utilizzabile
;solo quando i parametri sono in numero limitato.
;Analizziamo quindi più in dettaglio il tramite "stack", che si rivela essere quello maggiormente utilizzato.
;Tale metodo non ha limiti sul numero di parametri passati (a meno del limite fisico di allocazione dello stack) e 
;permette un comodo riutilizzo delle procedure su dati diversi; inoltre non richiede un’allocazione statica di
;memoria per contenere i parametri, come nel caso delle variabili globali.

;	- caricamento dei parametri nello stack:
;	  prima dell’esecuzione dell’istruzione CALL, la procedura chiamante deve eseguire tante istruzioni
;	  di PUSH nello stack quanti sono i parametri da passare

;	- lettura dei parametri di ingresso:
;	  l’istruzione CALL è eseguita dopo che i parametri sono caricati nello stack; l’indirizzo di ritorno è 
;	  caricato nello stack dopo tutti i parametri e si trova in cima allo stack nel momento in cui la procedura inizia
;	  l’esecuzione. Ciò significa che la procedura chiamata non può eseguire l’operazione di pop dallo
;	  stack per prelevare i parametri senza perdere l’indirizzo di ritorno.
;	  Si utilizza quindi il registro Base Pointer (BP) per fare accesso allo stack.
;	  Il registro BP permette di indirizzare dati presenti nello stack senza eseguire operazioni
;	  di push o pop, ossia senza cambiare il contenuto del registro Stack Pointer (SP). Questo è possibile
;	  eseguendo la copia del contenuto di SP in BP. Tale operazione deve essere fatta prima del salvataggio
;	  dei registri, poiché il salvataggio dei registri nello stack necessariamente modifica il contenuto
;	  di SP.

;Le considerazioni fatte finora sono valide per procedure di tipo NEAR, in cui l’indirizzo di ritorno
;è costituito da una word. Analogo discorso può essere fatto nel caso in cui la procedura chiamata
;sia di tipo FAR, con l’accorgimento che l’indirizzo di ritorno è qui costituito da due word.

;	- passaggio dei parametri in uscita:
;	  è possibile utilizzare lo stack anche per passare alla procedura chiamante i parametri di uscita.
;	  Essi non possono essere caricati nello stack con un’operazione di push perché in tal caso sarebbero
;	  posizionati in cima allo stack e non permetterebbero un corretto ritorno alla procedura chiamante.
;	  Anche per la scrittura dei parametri nello stack è necessario utilizzare il registro BP.
;	  È compito della procedura chiamante eseguire le opportune operazioni di pop per la lettura dei
;	  valori di ritorno.

;	- liberazione dello stack:
;	  l'ultima operazione da eseguire è la liberazione dello stack. È solitamente compito della procedura
;	  chiamante liberare lo stack, cancellando le parole che sono state utilizzate per il passaggio dei
;	  parametri. Questo può essere fatto o con successive operazioni di pop, o incrementando opportunamente
;	  il valore del registro Stack Pointer.
;	  Se la procedura non restituisce alcun parametro memorizzato nello stack, la liberazione dello
;	  stack può essere fatta all’interno della procedura chiamata mediante l’esecuzione dell’istruzione
;	  RET.

;Si mostri adesso un esempio di procedura (scritta prima in linguaggio C), che esegue la somma degli elementi di un
;vettore di interi di nome vett e di dimensione count.
;La procedura dispone di due parametri di ingresso (indirizzo iniziale del vettore di interi e la sua lunghezza) e 
;restituisce un parametro di ritorno (valore della somma degli elementi del vettore). Il parametro vett è un
;esempio di parametro passato by reference, count è un esempio di parametro passato by value.

;	...
;	int som_vett(int *vett, int count)
;	{
;		int i, somma = 0;
;		for (i = 0, i < count; i++)
;			somma += vett[i];
;		return (somma);
;	...

;Si presenti ora la soluzione in linguaggio ASSEMBLER, utilizzando lo stack per il passaggio dei parametri in ingresso
;e uscita.

LUNG		EQU		100
			
			.MODEL	small
			.DATA
			
VETT		DW		LUNG DUP (?)
SOMMA		DW		?
TEMP		DW		?

			.CODE

			...

			MOV		AX, LUNG	;copio la lunghezza del vettore nel registro AX
			LEA		BX, VETT    ;copio l'OFFSET del vettore VETT nel registro BX
			SUB		SP, 2		;allocazione per il parametro di ritorno. Sto cioè riservando un'area dati
								;di variabili locali di 1 word (2 byte).
			
			PUSH	AX			;primo parametro caricato nello stack
			PUSH	BX			;secondo parametro caricato nello stack
			
			CALL	SOM_VETT	;chiamata alla procedura
			
			ADD		SP, 4		;liberazione dello stack (equivalente a due istruzioni di pop in quanto ho caricato
								;due parametri sullo stack)
								
			MOV		SOMMA, AX	;copio il contenuto del registro AX dentro la variabile SOMMA
			
			POP		AX			;liberazione dello STACK parametro di ritorno
			
			...

SOM_VETT	PROC				;procedura che esegue la somma degli elementi del vettore
			
			MOV		BP, SP		;copia del valore dello stack pointer.
								;Eseguo questa operazione prima del salvataggio dei registri nello stack, in 
								;quanto inevitabilmente il PUSH dei registri mi va a modificare SP.
			
			PUSH	BX			;salvataggio dei registri nello stack
			PUSH	CX			;salvataggio dei registri nello stack
			PUSH 	AX			;salvataggio dei registri nello stack
			
								;da qui in avanti posso accedere ai parametri tramite BP: supponendo che la procedura
								;sia di tipo NEAR, l'ultimo parametro messo nello stack sarà all'indirizzo [BP+4],
								;il penultimo all'indirizzo [BP+6] e così via. Qualora la procedura fosse di tipo FAR,
								;l'ultimo parametro messo nello stack dal chiamante sarà all'indirizzo [BP+6], il 
								;penultimo all'indirizzo [BP+8], e così via.
			
			MOV		CX, [BP+4]	;copia del primo parametro in CX (è il contenuto di AX, ossia la lunghezza 
								;del vettore)
			MOV		BX, [BP+2]  ;copia del secondo parametro in BX (è l'OFFSET di VETT)
			
			XOR		AX, AX		;azzeramento del registro AX. Da qui in avanti utilizzo il registro AX per 
								;memorizzare la somma temporanea degli elementi del vettore

ciclo:		ADD		AX, [BX]	;AX = AX + [BX] (corrisponde a AX += VETT[INDICE])
			ADD		BX, 2		;aggiornamento OFFSET per andare avanti nella scansione del vettore
			LOOP	ciclo		;scansiono il vettore
			
			MOV		[BP+6], AX	;caricamento di AX sullo stack. Sto cioè copiando la somma degli elementi del 
								;vettore, che è contenuta in AX, sullo stack
			
			POP		AX			;ripristino dei registri dallo stack
			POP		CX			;ripristino dei registri dallo stack
			POP		BX			;ripristino dei registri dallo stack
			
			RET					;ritorno alla procedura chiamante

SOM_VETT	ENDP				;fine procedura
			...
			