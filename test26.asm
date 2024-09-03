;Programma che scandisce una string di caratteri e ne visualizza il primo carattere diverso
;dal carattere spazio. Utilizzare SCASB

;Una possibile soluzione nel linguaggio C è la seguente:

;	#include <stdio.h>
;	main()
;	{
;		int i;
;		char string[25];
;		...
;		strcpy(string, "    Fatti non foste a viver come bruti ...  ");
;		for(i = 0; i < 25; i++)
;			if(string[i] != ' ' ){
;				printf("%c", string[i]);
;				break;
;			}
;		...
;	}

		.MODEL	small
		.DATA	
STRING	DB		"    Fatti non foste a viver come bruti ...   "
LUNG	EQU		$-STRING
ST_ADD	DD		STRING
		.CODE
		...
		MOV		AL, " "		;copia in AL del carattere da confrontare
		LES		DI, ST_ADD	;copia in DI dell'offset di STRING
							;copia in ES dell'indirizzo di segmento
		MOV		CX, LUNG	;copia in CX della lunghezza di STRING
		CLD					;scansione in avanti
		REPE	SCASB		;finchè elemento di STRING = " "
		JE		esci		;elemento di STRING = " " ?, Si: vai a "esci"
		DEC		DI			;No: decrementa registro indice
		MOV		DL, [DI]	;copia in DL il valore diverso
		MOV		AH, 02H		;istruzioni per visualizzare a video
		INT 	21H			;istruzioni per visualizzare a video
esci:	...
		

;OSSERVAZIONE: SCASB (si utilizza per stringhe di byte) e SCASW (si utilizza per stringhe di word)
;sono simili alle istruzioni di confronto, con la differenza che esse elaborano solo
;una stringa e confrontano ciascun elemento con un determinato valore. L’istruzione SCASB usa i
;registri AL e DI, mentre l’istruzione SCASW usa i registri AX e DI. I registri AL ed AX contengono
;il valore da confrontare, mentre DI contiene l’offset della stringa da scandire. Ad ogni esecuzione
;dell’istruzione SCASB (o SCASW) viene effettuato il confronto tra il contenuto della locazione di
;memoria avente indirizzo ES:DI ed il contenuto del registro accumulatore.
;Anche le istruzioni SCASB e SCASW utilizzano le istruzioni REPE e REPNE per generare il ciclo:
;REPE per cercare un valore diverso dal contenuto dei registri AL ed AX, REPNE per cercare un
;valore coincidente. Il ciclo di scansione termina al verificarsi di una delle seguenti condizioni:
;	1. la stringa è terminata (il registro CX ha valore nullo)
;	2. è stata trovata una disuguaglianza (nel caso dell’istruzione REPE) o un’uguaglianza (nel caso
;	   dell’istruzione REPNE) tra il contenuto del registro accumulatore e la stringa indirizzata
;	   da DI.