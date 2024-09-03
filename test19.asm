;Pezzo di programma ASSEMBLY che valuta la somma tra due numeri rappresentati su 32 bit.
;I due numeri sono contenuti nelle variabili NUMA  E NUMB; pongo il risultato in NUMC.

			.MODEL	small
			.DATA
NUMA		DD		?
NUMB		DD		?
NUMC		DD		?
			.CODE
			...
			MOV		AX, WORD PTR NUMA	;converti NUMA in tipo word e lo metto in AX
			ADD		AX, WORD PTR NUMB	;sommo tra loro le 2 word meno significative
			MOV		WORD PTR NUMC, AX
			MOV		AX, WORD PTR NUMA+2
			ADC		AX, WORD PTR NUMB+2	;sommo tra loro le 2 word più significative
										;più l'eventuale carry della somma precedente
			MOV		WORD PTR NUMC+2, AX
			...

;OSSERVAZIONE: l'istruzione ADC (ADd with Carry)
;				
;				ADC	destinazione, sorgente
;
;			   somma al contenuto dell'operando destinazione il contenuto dell'operando
;			   sorgente e il valore del flag CF e il tutto viene memorizzato nell'operando
;			   destinazione, lasciando invarianto l'operando sorgente.
;			   Quindi se il flag CF vale 0 l'istruzione ADC si comporta come ADD; altrimenti
;			   aggiunge 1 alla sommma dei due operandi.
;			   ADC si rivela utile quando devo addizionare numeri memorizzati su doubleword
;	           (32 bit) o quadword (64 bit).
;			   Nel caso di somma tra due doubleword occorre:
;			   	1. sommare le due word meno significative utilizzando ADD
;			    2. sommare le due word più significative utilizzando ADC
;			   La prima somma può infatti generare un riporto (carry), che deve essere sommato
;			   al risultato della seconda addizione utilizzando ADC.
			
			
;si presenti anche un'altra versione del codice

.MODEL	SMALL
.STACK	100H

.DATA
var1		DD		?
var2		DD		?
result		DD		?

.CODE

MAIN PROC
			MOV		AX, @DATA
			MOV		DS, AX ;Initialize DS register with the address of the data segment
			
			MOV		EAX, var1 ;load the first 32-bit variable into EAX.
							  ;EAX is a 32-bit register where its lower 16-bit part is exactly
							  ;the register AX
			MOV		EBX, var2
			XOR		EDX, EDX ;reset EDX, clearing the carry flag
			
			ADD		EAX, EBX ;store the sum of the content of EAX and EBX inside EAX
			ADC		EDX, 0 ;add the carry to EDX 
			
			MOV     [result], EAX ;store the low 32 bits of the result
			MOV     [result + 4], EDX ;store the high 32 bits of the result
			
			;Exit the programma
			MOV 	AH, 4CH
			INT 	21H

MAIN ENDP
END MAIN