;Pezzo di programma ASSEMBLY che valuta la somma tra due numeri rappresentati su 64 bit.
;I due numeri sono contenuti nelle variabili NUMA E NUMB; pongo il risultato in NUMC.

			.MODEL	small
			.DATA
NUMA		DQ		?
NUMB		DQ		?
NUMC		DQ		?
			.CODE
			...
			
			;sommo le prime due word meno significative
			MOV			AX, WORD PTR NUMA 
			ADD			AX, WORD PTR NUMB
			MOV			WORD PTR NUMC, AX
		
			;sommo le seconde due word meno significative
			MOV			AX, WORD PTR NUMA+2
			ADC			AX, WORD PTR NUMB+2 ;utilizzo ADC in quanto devo tener conto del CF
			MOV			WORD PTR NUMC+2, AX
		
			;sommo le terze word 
			MOV			AX, WORD PTR NUMA+4
			ADC			AX, WORD PTR NUMB+4 ;utilizzo ADC in quanto devo tener conto del CF
			MOV			WORD PTR NUMC+4, AX
		
			;sommo le word più significative
			MOV			AX, WORD PTR NUMA+6
			ADC			AX, WORD PTR NUMB+6 ;utilizzo ADC in quanto devo tener conto del CF
			MOV			WORD PTR NUMC+6, AX
			
			.EXIT
			END