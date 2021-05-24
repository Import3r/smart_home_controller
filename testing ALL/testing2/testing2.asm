
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
;testing2.c,43 :: 		if(!portd.B7)
	BTFSC      PORTD+0, 7
	GOTO       L_main3
;testing2.c,44 :: 		Lcd_Out(1, 1, "Enter password: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main4
L_main3:
;testing2.c,45 :: 		else if(!dashboard_flag) {
	MOVF       _dashboard_flag+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;testing2.c,46 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,47 :: 		Lcd_Out(1, 1, "Welcome :) ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,48 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;testing2.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,50 :: 		dashboard_flag = 1;}
	MOVLW      1
	MOVWF      _dashboard_flag+0
	GOTO       L_main7
L_main5:
;testing2.c,52 :: 		Lcd_Out(1, 1, "1.DOOR: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,53 :: 		Lcd_Out(2, 1, "2.GARAGE: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,54 :: 		Lcd_Out(1, 1+16, "3.GARDEN: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,55 :: 		Lcd_Out(2, 1+16, "4.COOLING: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,57 :: 		if(portd.B0) Lcd_Out(1, 9, "ON ");
	BTFSS      PORTD+0, 0
	GOTO       L_main8
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main9
L_main8:
;testing2.c,58 :: 		else Lcd_Out(1, 9, "OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main9:
;testing2.c,60 :: 		if(portd.B1) Lcd_Out(2, 11, "ON ");
	BTFSS      PORTD+0, 1
	GOTO       L_main10
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main11
L_main10:
;testing2.c,61 :: 		else Lcd_Out(2, 11, "OFF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main11:
;testing2.c,63 :: 		if(portd.B2) Lcd_Out(1, 11+16, "ON ");
	BTFSS      PORTD+0, 2
	GOTO       L_main12
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      27
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main13
L_main12:
;testing2.c,64 :: 		else Lcd_Out(1, 11+16, "OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      27
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main13:
;testing2.c,66 :: 		if(portd.B3) Lcd_Out(2, 12+16, "ON ");
	BTFSS      PORTD+0, 3
	GOTO       L_main14
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      28
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main15
L_main14:
;testing2.c,67 :: 		else Lcd_Out(2, 12+16, "OFF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      28
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main15:
;testing2.c,69 :: 		}
L_main7:
L_main4:
;testing2.c,79 :: 		}
L_main2:
;testing2.c,82 :: 		}
	GOTO       L_main0
;testing2.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
