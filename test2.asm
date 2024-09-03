;Il seguente programmino esegue la somma del contenuto di due celle di memoria

			.MODEL	small
			.STACK
			.DATA
			
OPD1 		DW		10
OPD2		DW		24
RESULT		DW		?

			.CODE
			.STARTUP
			MOV		AX, OPD1 ;carico in AX il contenuto di OPD1
			ADD		AX, OPD2 ;sommo il contenuto di AX e OPD2  e lo carico in AX
			MOV 	RESULT, AX
			
			.EXIT
			END
			