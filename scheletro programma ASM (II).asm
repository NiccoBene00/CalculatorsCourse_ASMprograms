;Viene presentato qui uno scheletro di programma ASSEMBLER che fa uso delle direttive MASM per 
;la gestione dei segmenti, utilizzabile per sviluppare programmi contenuti in un'unico file

		.MODEL		small
		.STACK					;stack di 1kbyte
		
		.DATA					;inizia il segmento di dato
		
		...						;dichiarazioni di costanti e variabili
		
		.CODE					;inizia il segmento di codice
		.STARTUP				;inizia la procedura principale

		...						;istruzioni

		.EXIT					;ritorno a MS-DOS
		END						;fine del modulo