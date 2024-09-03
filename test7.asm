;Si presenti il programma copia di un vettore (versione II)

LUNG		EQU		500
			.MODEL	small
			.DATA
			
SORG		DW		LUNG DUP (?) ;definisco una variabile vettore SORG con LUNG elementi non inizializzati
DEST		DW		LUNG DUP (?) ;definisco una variabile vettore DEST con LUNG elementi non inizializzati

			.CODE
			...
			
			MOV		SI, 0 ;inizializzazione del registro indice
			MOV		CX, LUNG ;caricamento in CX del numero di elementi
			
ciclo		MOV		AX, SORG[SI] ;metodo di indirizzamento base&indice
			MOV		DEST[SI], AX
			ADD		SI, 2 ;incremento del displacement (N.B. = lavoro con le word)
			LOOP 	ciclo ;scansione conclusa ? No, allora vai a "ciclo"
			...			  ;Si, passa a questa riga di codice