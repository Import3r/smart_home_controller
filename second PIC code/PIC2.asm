
_main:

;PIC2.c,3 :: 		void main() {
;PIC2.c,4 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;PIC2.c,5 :: 		Trisb = 0x00;
	CLRF       TRISB+0
;PIC2.c,6 :: 		portb=0x00;
	CLRF       PORTB+0
;PIC2.c,8 :: 		while(1){
L_main0:
;PIC2.c,9 :: 		if(UART1_Data_Ready() == 1)
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;PIC2.c,10 :: 		portb = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_main3
L_main2:
;PIC2.c,11 :: 		else portb = portb;
L_main3:
;PIC2.c,15 :: 		}
	GOTO       L_main0
;PIC2.c,16 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
