
_main:

;testing2.c,19 :: 		void main() {
;testing2.c,20 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;testing2.c,21 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;testing2.c,22 :: 		portd=0x00;
	CLRF       PORTD+0
;testing2.c,24 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;testing2.c,25 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,26 :: 		Lcd_Cmd(_LCD_FOURTH_ROW);
	MOVLW      212
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,27 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,36 :: 		ADCON1 |= 0x0F;
	MOVLW      15
	IORWF      ADCON1+0, 1
;testing2.c,37 :: 		CMCON |= 7;
	MOVLW      7
	IORWF      CMCON+0, 1
;testing2.c,39 :: 		while(1){
L_main0:
;testing2.c,41 :: 		if(UART1_Data_Ready() == 1){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;testing2.c,42 :: 		PORTD = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;testing2.c,43 :: 		Lcd_Chr(1, 9, PORTD.B0+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,44 :: 		Lcd_Chr(1, 8, PORTD.B1+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 1
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,45 :: 		Lcd_Chr(1, 7, PORTD.B2+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 2
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,46 :: 		Lcd_Chr(1, 6, PORTD.B3+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 3
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,47 :: 		Lcd_Chr(1, 5, PORTD.B4+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 4
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,48 :: 		Lcd_Chr(1, 4, PORTD.B5+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 5
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,49 :: 		Lcd_Chr(1, 3, PORTD.B6+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 6
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,50 :: 		Lcd_Chr(1, 2, PORTD.B7+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      0
	BTFSC      PORTD+0, 7
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;testing2.c,51 :: 		}
L_main2:
;testing2.c,56 :: 		}
	GOTO       L_main0
;testing2.c,57 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
