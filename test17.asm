;Programma ASSEMBLY che legge da tastiera 10 caratteri e li visualizza su video.

.MODEL SMALL
.STACK 100H

.DATA
DIM			EQU		10
VECT		DB		DUP (?)	;define a vector by byte 'cause i have to store character
promptmsg	DB		"Enter 10 characters: $"

.CODE
MAIN PROC
			MOV		AX, @DATA ;DATA is a variable that holds the value of the location memory
			MOV		DS, AX 
			
			;Display prompt
			MOV		AH, 09H ;DOS functin to display a string
			MOV		DX, OFFSET promptmsg ;so DX points to the string to display
			INT		21H ;call DOS interrupt
			
			;Read 10 characters from keyboard
			MOV		SI, OFFSET VECT ;register SI points to the beginning of the vector
			MOV		CX, DIM ;register CX used as counter for reading 10 characters
			

READ_LOOP:
			MOV		AH, 01H ;DOS function to read a character
			INT		21H ;call DOS interrupt
			
			MOV		[SI], AL ;store the read character into the vector at the position marked
							 ;by index SI.
							 ;Infact with the function 01H, we can find the read element inside AL
							 ;register.
			INC		SI ;move to the next position in the array
			LOOP	READ_LOOP ;repeat cycle for 10 times
			
			MOV		SI, OFFSET VECT ;reset SI to the start of the vector
			
DISPLAY_LOOP:
			
			MOV		AH, 02H ;DOS function to display a character
			MOV		DL, [SI] ;load register DL from the vector 
			INT		21H ;call DOS interrupt
			
			INC		SI ;move to the next value in the vector
			LOOP	DISPLAY_LOOP
			
			;Exit the program
			MOV		AH, 4CH ;function to terminate the program
			INT		21H ;call DOS interrupt
			
MAIN ENDP

END MAIN