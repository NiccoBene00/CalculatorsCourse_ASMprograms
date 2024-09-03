;L'istruzione XOR (AND, OR) esegue l'operazione logica eXOR (AND, OR) bit a bit tra l'operando destinazione
;e l'operando sorgente.

;OSSERVAZIONE: l'istruzione XOR può essere utilizzata per eseguire l'azzeramento del contenuto
;di un registro.

		MOV		AX, 0
		;=
		XOR		AX, AX

;Le due istruzioni sopra sono equivalenti ed eseguono entrambe l'operazione di azzeramento del registro
;AX. La seconda istruzione richiede un numero di cicli di macchina inferiore, ed è dunque preferibile
;rispetto alla prima.