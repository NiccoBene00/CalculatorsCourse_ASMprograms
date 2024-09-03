;Programma ASSEMBLY che conta il numero di spazi inclusi in una stringa di caratteri. La soluzione
;prevede l'utilizzo dell'istruzione LODSB.
;Una possibile soluzione in C è la seguente:

;	main()
;	{
;		char sorg[100];
;		int i, count = 0;
;		...
;		for (i = 0; i < 100; i++)
;			if(sorg[i] == ' ' ) count++;
;		...
;	}

LUNG	EQU		100
		.MODEL	small
		.DATA
SORG	DB		LUNG DUP (?)
		.CODE
		...
		LEA		SI, SORG	;inizializzazione di SI
		MOV		CX, LUNG	;inizializzazione
		XOR		BX, BX		;BX: contatore di spazi inizializzato a 0
		CLD					;scansione in avanti
ciclo: 	LODSB				;copia in AL l'elemento SORG
		CMP		AL, ' '		;AL = ' ' ?
		JNE		next		;No: vai a "next"
		INC 	BX			;Si: incrementa BX
next:	LOOP	ciclo		;CX = 0 ? No: vai a "ciclo"
		...					;Si: fine

;OSSERVAZIONE: Le istruzioni LODSB (LOaD Byte String) e LODSW (LOaD Word String) permettono di copiare
;un elemento di una stringa rispettivamente nei registri AL e AX

