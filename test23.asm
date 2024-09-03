;Programma che calcola il modulo del contenuto di tutte le celle di un vettore di interi
;Soluzione proposta in linguaggio C

;	main()
;	{
;		int i, vett[10];
;		...
;		for (i = 0; i < 10; i++){
;			if(vett[i] < 0)
;				vett[i] *= -1;
;		}
;		...
;	}

LUNG		EQU		10
			.MODEL	small
			.DATA
VETT		DW		LUNG DUP (?)
			.CODE
			...
			MOV		SI, 0
			MOV		CX, LUNG
ciclo:		CMP		VETT[SI], 0 ;(VETT[SI] < 0) ?
			JNL		continua    ;no: vai a "continua"
			NEG		VETT[SI]    ;si: calcola il modulo dell'elemento
continua:	ADD		SI, 2		;aggiorno indice per scansionare il vettore
			LOOP 	ciclo
			...