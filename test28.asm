;Programma ASSEMBLER che determina il fattoriale di un numero letto da tastiera.
;NOTA: il programa proposto non permette, a causa delle dimensioni del risultato, di calcolare il fattoriale
;di numeri maggiori di 8.

			.MODEL		large
EXTRN	 	INPUT:FAR, OUTPUT:FAR, ACAPO:FAR
			
			.DATA
			
OUT_VAL	 	DW			0
PROMPT		DB			'VALORE DI INPUT: $'
			
			.STACK
			.CODE
			.STARTUP
			
			MOV			DX, OFFSET PROMPT ;lettura del parametro da tasetiera, dunque lo sposto in DX
			MOV			AH, 9
			INT 		21H
			
			CALL		INPUT
			
			MOV			BX, DX ;sposto il contenuto di DX in BX
			
			CALL		FACT
			
			CALL		ACAPO
			
			MOV			DX, AX
			
			CALL		OUTPUT
			
			.EXIT			

;La procedura FACT calcola il fattoriale di un numero: prende il parametro di input in BX e lascia il risultato in AX

FACT		PROC		NEAR

			PUSH		BX	;salvataggio del registro BX sullo stack
			
			CMP			BX, 1 ;confronto il contenuto di BX con 1
			JE			return ;JE salta a "return" sse il contenuto di BX è uguale a 1
			
			DEC			BX	;se condizione di JE non rispettata significa che ho un numero maggiore di 1,
							;dunque lo decremento
							
			CALL		FACT ;chiamata ricorsiva alla procedura FACT
			
			INC			BX ;incremento BX
			
			MUL			BX
			
			JMP			fine

return:		MOV			AX, 1
			
			XOR			DX, DX

fine:		POP			BX

			RET

FACT		ENDP
			END
			
;OSSERVAZIONE: L’Assembler permette la recursione, che deve essere gestita dal programmatore stesso.
;Nulla infatti vieta che una procedura richiami se stessa: in tal caso l’indirizzo di ritorno messo
;nello stack è quello della procedura stessa, e nello stack si accumuleranno tanti di questi indirizzi,
;quante sono state le chiamate recursive.