;Dati n elementi distinti e un numero intero positivo K <= n, il numero di combinazioni semplici possibili
;C(n,k) è dato dalla seguente formula:

;			 (n)	n*(n-1)*(n-2)...*(n-k+1)
;	C(n,k) = ( ) =  ------------------------
;			 (k)			  k!

;Si scriva una procedura COMBINA in grado di calcolare il numero di combinazioni semplici dati i parametri
;n e k ricevuti come variabili globali di tipo byte. Il risultato dovrà essere restituito attraverso la
;variabile globale di tipo word risultato.
;[Sia lecito supporre che durante le operazioni intermedie non si presenti overflow].

			.MODEL		small
			.STACK
			.DATA
			
n			DB			6	;parametro n (tipo BYTE)
k			DB			3	;parametro k (tipo BYTE)
risultato	DW			?	;variabile (tipo WORD) non inizializzata su cui caricherò il risultato della 
							;combinazione semplice 
			
			.CODE
			.STARTUP
			
			CALL		COMBINA	;chiamata alla procedura COMBINA
			
			.EXIT

;------------------------------------------------
;Si definisce adesso la procedura COMBINA, per il calcolo del numero di combinazioni semplici di elementi
;di un insieme.
;Dati in ingresso: n, k - variabili globali (byte)
;Risultati		 : risultato - variabile globale (word)

COMBINA		PROC

			MOV			CL, k	;carico il valore di k dentro il registro CL (si noti che è una MOV compatibile in 
								;quanto k e CL sono entrambi di tipo BYTE)
			
			XOR			CH, CH	;ripulisco il registro CH
								;Corrisponde a CH = 0
			
			DEC			CX		;decremento di un'unità il contenuto di CX (= CL = k-1)
			
			MOV			AL, n	;sposto il valore di n dentro il registro AL (si noti che si tratta di una MOV
								;compatibile in quanto AL, n sono entrambi di tipo BYTE)
			
			XOR			AH, AH	;ripulisco il registro AH. Corrisponde a AH = 0
			
			MOV			BL, n	;sposto il valore di n dentro il registro BL (si noti che è una MOV compatibile
								;in quanto BL, n sono entrambi di tipo BYTE)
			
			XOR			BH, BH	;ripulisco il registro BH. Corrisponde a BH = 0
			
			DEC			BX
			
ciclo1:		MUL			BX
			DEC			BX
			LOOP		ciclo1
			MOV			BL, k
			MOV			CL, k
			XOR			CH, CH
			DEC			CX
ciclo2:     DIV			BL
			SUB			BL, 1
			LOOP		ciclo2
			MOV			risultato, AX
			RET
			
			ENDP 		COMBINA
;------------------------------------------------
			
			END
			

 
