;Segmento di programma che implementa un ciclo di istruzioni ripetuto 10 volte

RIP		EQU		10
		...
		MOV		COUNT, RIP
lab1:	CMP		COUNT, 0  ;confronto se (COUNT = 0) ?
		JNG		lab2      ;se condizione vera 
		...				  ;esegui istruzioni (se condizione falsa)
		DEC		COUNT     ;decremento COUNT di un'unità
		JMP		lab1
lab2:	...