;Il seguente programma esegue la copia della variabile VAR1, contenuta nel segmento
;DSEG, nella variabile VAR2, contenuta nel segmento ESEG.

DSEG		SEGMENT		PARA PUBLIC 'DATA'
VAR1		DB			0					;variabile VAR1 contenuta nel segmento DSEG
DSEG		ENDS

ESEG		SEGMENT		PARA PUBLIC 'DATA'
VAR2		DB			0					;variabile VAR2 contenuta nel segmento ESEG
ESEG		ENDS

CSEG		SEGMENT		PARA PUBLIC 'CODE'
			ASSUME		CS:CSEG, SS:STACK ;associa al registro CS il segmento CSEG
										  ;e al registro SS il segmento STACK
BEGIN:		ASSUME		DS:DSEG  ;associa al registro DS il segmento DSEG
			ASSUME		ES:ESEG  ;associa al registro ES il segmento ESEG
			
			MOV			AX, DSEG ;copia dell'indirizzo del segmento DSEG nel registro DS
								 ;passando attraverso AX
			MOV			DS, AX	 
			
			MOV 		AX, ESEG ;copia dell'indirizzo del segmento ESEG nel registro ES
								 ;passando attraverso AX
			MOV			ES, AX   
			
			
			MOV			AL, VAR1 ;VAR1 si trova nel segmento DSEG
			MOV			VAR2, AL ;VAR2 si trova nel segmento ESEG
CSEG		ENDS

STACK 		SEGMENT		PARA STACK 'STACK'
			DB			64 DUP("STACK")
STACK		ENDS

;OSSERVAZIONE: la direttiva ASSUME serve per associare un registro di segmento a un segmento
;di memoria. La sintassi è la seguente:
;	
;	ASSUME segreg:segloc
;
;I registri di segmento (segreg) possono essere CS, DS, ES, SS, mentre il campo segloc è il
;nome di un segmento definito attraverso la direttiva SEGMENT. La direttiva ASSUME mette in 
;relazio un registro di segmento con un segmento logico, ma non si occupa di inizializzare il
;registro stesso 

END 		

