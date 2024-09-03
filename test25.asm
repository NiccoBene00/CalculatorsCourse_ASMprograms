;Il seguente frammento di codice esegue un confronto tra le due stringhe STR1 e STR2; il confronto
;termina non appena viene riscontrata una differenza.

			.MODEL		small
LUNG		EQU			100
			.DATA
STR1		DB			LUNG DUP (?)
STR2		DB			LUNG DUP (?)
			.CODE
			...
			PUSH		DS
			POP			ES
			LEA			SI, STR1
			LEA			DI, STR2
			MOV			CX, LUNG
			CLD
			REPE		CMPSB		;l'istruzione CMPSB viene utilizzata per confrontare stringhe di byte
			...

;Il seguente frammento di codice esegue un confronto tra le due stringhe STR1 e STR2; il confronto
;termina non appena viene riscontrata un'uguaglianza tra due elementi. 

			.MODEL		small
LUNG		EQU			100
			.DATA
STR1		DB			LUNG DUP (?)
STR2		DB			LUNG DUP (?)
			.CODE
			...
			PUSH		DS
			POP			ES
			LEA			SI, STR1
			LEA			DI, STR2
			MOV			CX, LUNG
			CLD
			REPNE		CMPSB		;l'istruzione CMPSB viene utilizzata per confrontare stringhe di byte
			...

;A confronto terminato, bisogna essere in grado di distinguere tra le due condizioni di terminazione:
;poiché ogni esecuzione dell’istruzione di confronto aggiorna i flag, analizzando lo stato del flag
;ZF è possibile determinare se la condizione di uguaglianza è stata verificata oppure no. In particolare
;si è soliti ricorrere ad un’istruzione di salto condizionato: JE per saltare se il confronto ha dato
;esito positivo, JNE nel caso contrario.

