;Codice ASSEMBLER che esegue la sottrazione tra numeri rappresentati su 32 bit contenuti
;nelle variabili NUMA e NUMB.

			.MODEL	small
			.DATA
NUMA 		DD		?
NUMB 		DD		?
NUMC 		DD		?
			.CODE
			...
			MOV		AX, WORD PTR NUMA
			SUB		AX, WORD PTR NUMB	;sottrazione tra le 2 word meno significative
			MOV		WORD PTR NUMC, AX
			
			MOV		AX, WORD PTR NUMA+2
			SBB		AX, WORD PTR NUMB+2 ;sottrazione tra le 2 word più significative
										;meno il borrow (prestito) della sottrazione
										;precedente
			MOV		WORD PTR NUMC+2, AX
			...

;OSSERVAZIONE - L’istruzione SBB esegue la sottrazione tra l’operando destinazione e l’operando sorgente:
;il valore del flag CF viene sottratto al risultato ed il valore ottenuto viene copiato nell’operando
;destinazione, mentre l’operando sorgente rimane immutato.
;L’istruzione SBB è utilizzata nel caso di sottrazione tra numeri interi memorizzati su doubleword
;(32 bit) o quadword (64 bit), dove occorre sottrarre una word alla volta, cominciando da quella meno
;significativa.
;Nel caso di sottrazione tra due doubleword occorre:
;	1. sottrarre le due word meno significative utilizzando l’istruzione SUB
;	2. sottrarre le due word più significative utilizzando l’istruzione SBB
;La prima sottrazione può richiedere un prestito (borrow), che deve essere sottratto al risultato
;della seconda sottrazione utilizzando l’istruzione SBB.

;si presenti anche un'altra versione del codice

.MODEL SMALL
.STACK 100H

.DATA
var1		DD		?
var2		DD		?
result		DD      ?

.CODE

MAIN PROC
			MOV		AX, @DATA
			MOV		DS, AX ;Initialize DS with the address of the data segment
			
			MOV		EAX, var1
			MOV		EBX, var2
			XOR		EDX, EDX ;reset EDX register (for clearing the borrow flag)
			
			SUB		EAX, EBX ;here substract var2 from var1 (low 32 bits)
			SBB 	EDX, 0 ;substract the borrow (high 32 bits) from EDX 
						   ;(i.e. borrow flag is substracted from EDX)
			
			MOV		[result], EAX ;store the low 32 bits of the result
			MOV		[result + 4], EDX ;store the high 32 bits of the result 
			
			;Exit the program
			MOV		AH, 4CH ;function to terminate the program
			INT 	21H

MAIN ENDP