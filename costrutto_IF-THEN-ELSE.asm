;Frammento di codice che implementa in ASSEMBLER il costrutto IF-THEN-ELSE

			CMP		op1, op2 ;confronto tra op1 e op2
			Jcond	lab1     ;cond è vera? Si: vai a "lab1"
			
			...				 ;no: ramo else
			
			JMP		continua
			
lab1:		...              ;ramo then

continua:

;Tale frammento di codice esegue il confronto tra gli operandi op1 e op2; l'istruzione
;di salto verifica un'espressione relazionale tra gli operandi: se la condizione è
;verificata viene eseguita la sequenza di istruzioni avente etichetta "lab1" (ramo then),
;altrimenti viene eseguito l'istruzione successiva (ramo else).