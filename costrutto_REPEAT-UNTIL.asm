;Codice che definisce il costrutto REPEAT-UNTIL in ASSEMBLER

lab:		;blocco istruzioni
			CMP			cond ;(cond) è vera?
			Jcond		lab  ;si: ripete il ciclo
			
;oppure

lab:		;blocco istruzioni
			CMP			cond ;(cond) è falsa?
			JNcond		lab  ;si: ripete il ciclo
			
;Quindi nel ciclo REPEAT-UNTIL si esegue prima il blocco di istruzioni e poi si valuta la condizione
;OSSERVAZIONE: se faccio uso di un tale ciclo ho la certezza che almeno un'iterazione verrà eseguita.