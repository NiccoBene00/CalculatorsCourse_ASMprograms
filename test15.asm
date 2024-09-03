;Programma che annulla (reset) tutti i numeri negativi in un vettore di numeri 
;interi

;	#define LUNG 20
;	main()
;	{
;		int i, vett[LUNG];
;		for(i = 0; i < LUNG; i++)
;			if(vett[i] < 0)
;				vett[i] = 0;
;		...
;		}
;	}

LUNG		EQU		20
			.MODEL	small
			.DATA
VETT		DW		LUNG DUP (?)
			.CODE
			...
			MOV		SI, 0 ;utilizzo SI come indice del vettore
			MOV		CX, LUNG
ciclo:		CMP		VETT[SI], 0 ;(VETT[SI] < 0) ?
			JNL		lab         ;no: vai a "label"
			MOV		VETT[SI], 0 ;si: azzeramento dell'elemento
lab:		      ADD		SI, 2 ;se arrivo qua allora VETT[SI] maggiore di 0, dunque proseguo 
                                    ;con la scansionse del prossimo elemento di VETT
			LOOP	ciclo
			...
