;Le istruzioni MUL (MULtiply, unsigned) e IMUL (Integer MULtiply) permettono di eseguire il
;prodotto tra numeri interi, rispettivamente senza segno e con segno.

	MUL 	operando
	IMUL	operando

;L’unica differenza tra le due istruzioni è il tipo di dato su cui esse lavorano; l’istruzione MUL
;opera su numeri interi senza segno, l’istruzione IMUL su numeri interi con segno.
;L’operando può essere un registro oppure una locazione di memoria; il suo tipo può essere
;BYTE oppure WORD. Non è ammessa la moltiplicazione per un valore immediato.
;Entrambe le istruzioni aggiornano il valore dei flag CF ed OF, mentre il valore degli altri flag di
;stato è indefinito.
;I due operandi devono avere la stessa lunghezza ed il risultato viene memorizzato in un operando
;avente lunghezza doppia rispetto ad essi. I due casi possibili sono:
;	1.se si specifica un operando di tipo BYTE, il processore esegue la moltiplicazione tra
;	  l’operando ed il contenuto del registro AL ed il risultato è copiato nel registro AX;
;	2.se si specifica un operando di tipo WORD, il processore esegue la moltiplicazione tra
;     l’operando ed il contenuto del registro AX ed il risultato è copiato nei registri DX (word più
;     significativa) ed AX (word meno significativa).

;L’istruzione MUL aggiorna i flag CF ed OF in modo da segnalare se la metà meno significativa 
;dei registri è sufficiente a contenere il risultato:
;	-in una moltiplicazione tra byte i flag CF ed OF valgono 0 se il registro AH è nullo;
;	-in una moltiplicazione tra word i flag CF ed OF valgono 0 se il registro DX è nullo.
;L’istruzione IMUL aggiorna i flag CF ed OF in modo da segnalare se la metà meno significativa
;dei registri è sufficiente a contenere il risultato:
;	-in una moltiplicazione tra byte i flag CF ed OF valgono 0 se il registro AH vale o 0 o FFH a
;	 seconda del segno;
;	-in una moltiplicazione tra word i flag CF ed OF valgono 0 se il registro DX vale o 0 o
;    FFFFH a seconda del segno.