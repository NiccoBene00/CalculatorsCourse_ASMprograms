;Segmento di codice che definsce il costrutto IF-THEN in ASSEMBLER

		CMP		op1, op2  ;confronto op1 e op2
		JNcond	cont	  ;(cond) verificata ? 
						  ;no: vai a "cont"
		...				  ;si: ramo then
		...
cont:	...

;Tale frammento di codice esegue il confronto tra gli opernadi op1 e op2;
;l'istruzione di salto verifica un'espresssione relazionale tra gli operandi:
;se la condizione è verificata viene eseguita la sequenza di istruzione 
;successiva (ramo then), altrimenti viene eseguito un salto all'istruzione
;avente etichetta "cont"