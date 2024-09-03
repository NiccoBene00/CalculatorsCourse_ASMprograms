;Programma che somma gli elementi di un vettore di numeri interi fino a quando
;il valore della somma diviene un numero positivo maggiore di 50. Una possibile realizzazione nel
;linguaggio C è la seguente:

;	#define LUNG 10
;	main()
;	{
;		int vett[10], i, somma;
;		...
;		i = 1;
;		somma = vett[0];
;		while ( (somma <= 50) && (i < LUNG) )
;			somma += vett[i++];
;		...
;	}

.MODEL	SMALL
.STACK	100H

.DATA
DIM			EQU		10
vector		DW		DIM DUP (?)
SUM			DW		0 ;neutral element for the sum

.CODE

MAIN PROC
			MOV		AX, @DATA
			MOV		DS, AX
			
			MOV		CX, DIM ;number of elements in the vector
			LEA		SI, vector ;load effective address of the vector inside SI register
			
SUM_LOOP:
			ADD		AX, [SI] ;sum content of AX with element in position SI
			CMP		AX, 50 ;here I'm comparing current sum with the value 50
			JG		DISPLAY_SUM ;if the content of AX is greater (JG) than 50 then jump to 
							    ;label "DISPLAY_SUM"
			ADD		SI, 2 ;move to the next element of the vector
			LOOP	SUM_LOOP ;repeat until all elements are processed
			
DISPLAY_SUM:
			MOV		SUM, AX 
			
END_PROGRAM:
			;Exit the program
			MOV		AH, 4CH ;function to terminate the program
			INT		21H ;call DOS interrupt
			
			
		