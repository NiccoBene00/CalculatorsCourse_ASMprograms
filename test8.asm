;Frammento di programma che copia la quarta riga di una matrice di 
;4 righe e 5 colonne da una matrice sorgente in una matrice destinazione.
;La soluzione proposta in linguaggio C potrebbe essere

; main(){
; int i, sorg[4][5], dest[4][5];
; ...
; for (i=0 ; i < 5 ; i++)
;	dest[4][i] = sorg[4][i];

NUMRIGHE	EQU		4
NUMCOL		EQU		5
			.MODEL	small
			.DATA
SORG		DW		NUMRIGHE*NUMCOL DUP (?) ;matrice sorgente
DEST		DW 		NUMRIGHE*NUMCOL DUP (?) ;matrice destinazione
			.CODE
			...
			
			MOV		BX, NUMCOL*3*2 ;caricamento in BX dello spiazzamento
								   ;del primo elemento della quarta riga
			MOV		SI, 0 ;inizializzazione del registro SI
			MOV		CX, NUMCOL ;caricamento in CX del numero di colonne
			
ciclo		MOV		AX, SORG[BX][SI]
			MOV 	DEST[BX][SI], AX
			ADD		SI, 2 ;incremento dell'indice di colonna
			LOOP	ciclo ;fine della scansione ? No, allora vai a "ciclo"
			...			  ;Si
