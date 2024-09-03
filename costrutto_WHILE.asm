;Codice che definisce il costrutto WHILE in ASSEMBLY

ciclo:		CMP		cond			;cond è vera?
			JNcond	cont			;no: esce dal ciclo saltando all'etichetta cont
			
			;blocco istruzioni      ;si: ciclo
			
			JMP		ciclo	        ;ritorna a inizio ciclo
cont:		...

;La differenza rispetto al costrutto REPEAT-UNTIL sta nel fatto che la valutazione
;della condizione è qui effettuata PRIMA di eseguire la sequenza di istruzioni.
;OSSERVAZIONE: se faccio uso di un tale ciclo NON ho la certezza di eseguire almeno un'iterazione.
