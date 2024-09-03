;Codice che definisce il costrutto FOR in ASSEMBLY

			MOV		CX, numero
ciclo:		;blocco istruzioni
			LOOP	ciclo ;decremento di CX e valuto CX = 0 ?
						  ;no: vai a "ciclo"
			...			  ;si: esci da "ciclo"

;La sequenza di operazioni è la seguente:
;	1. caricamento in CX del numero di ripetizioni del ciclo (numero)
;	2. esecuzione del blocco di istruzioni (sequenza)
;	3. decremento del contenuto del registro CX
;	4. controllo sul contenuto del registro CX:
;		a. se CX è diverso da 0 salta a passo 2
;		b. se CX è uguale a 0 esce dal ciclo 