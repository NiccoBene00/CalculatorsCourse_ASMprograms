;Codice che valuta la radice quadrata di un numero.
;Un modo per calcolare la radice quadrata (approssimata) di un numero consiste nel contare
;la quantità di numeri dispari che possono essere sottratti dal numero di partenza.
;La soluzione proposta in linguaggio C è la seguente:

;	main()
;	{
;		int num, sqrt = 0, disp = 1;
;		...
;		while (num >= 0){
;			sqrt++;
;			disp += 2;
;			num -= disp;
;		}
;		...
;	}


			.MODEL	small
			.DATA
NUM			DW		?
VAR			DW		?
SQR			DW		?
			.CODE
			...
			MOV		AX, NUM     ;salvo nel registro AX il numero di cui debbo
						        ;valutare la radice quadrata
			MOV		VAR, NUM	;VAR = NUM
			DEC		VAR			;VAR = VAR - 1
			MOV		BX, 0		;BX conta i numeri dispari sottratti
			MOV		CX, 1		;in CX ci sono i numeri dispari
ciclo:		CMP		VAR, 0		;VAR >= 0 ?
			JNGE	continua	;no: vai a "continua" (JNGE salta se non è maggiore o uguale)
			INC		BX			;si: incrementa il contatore
			ADD		CX, 2		;prossimo numero dispari
			SUB		VAR, CX		;sottrae il numero dispari
			JMP		ciclo
continua:	MOV		SQR, BX 	;copia il risultato in SQR
			...








 