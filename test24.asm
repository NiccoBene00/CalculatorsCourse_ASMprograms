;Programma ASSEMBLER che determina l'area di un triangolo

		.MODEL	small
		.DATA
BASE	DB		?
ALTEZZA	DB		?
AREA	DW		?
		.CODE
		...
		
		;Devo eseguire AREA = (BASE*ALTEZZA)/2
		
		MOV		AL, BASE ;copia in AL della variabile BASE
		
		MUL		ALTEZZA  ;AX = BASE * ALTEZZA
						 ;L'istruzione MUL infatti esegue la moltiplicazione tra il contenuto del registro
						 ;AL con il contenuto direttamente specificato (in questo caso la variabile ALTEZZA)
						 ;Pone il risultato dentro il registro AX
						 ;Questo è il funzionamento dell'istruzione MUL nel caso l'operando specificato
						 ;(nel nostro caso ALTEZZA) sia implementato per BYTE.
						 ;Qualora fosse definito per WORD allora MUL subisce dei cambiamenti.
						 
		SHR		AX, 1	 ;divisione per 2
						 ;Approfitto del fatto che in binario dividere per potenze del due corrisponde
						 ;a eseguire una shift verso destra di tot posizioni
		
		MOV		AREA, AX ;copia di AX nella variabile AREA
		...
		
		END