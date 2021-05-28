
_main:

;testing2.c,19 :: 		void main() {
;testing2.c,20 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;testing2.c,21 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;testing2.c,22 :: 		portd=0x00;
	CLRF       PORTD+0
;testing2.c,25 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;testing2.c,26 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,27 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,30 :: 		ADCON1 |= 0x0F;
	MOVLW      15
	IORWF      ADCON1+0, 1
;testing2.c,31 :: 		CMCON |= 7;
	MOVLW      7
	IORWF      CMCON+0, 1
;testing2.c,33 :: 		while(1){
L_main0:
;testing2.c,34 :: 		if(UART1_Data_Ready() == 1){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;testing2.c,35 :: 		PORTD = UART1_Read();  // Receive the flags from first controller
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;testing2.c,37 :: 		if(PORTD == 0x00){     //Restart or initialize system
	MOVF       PORTD+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;testing2.c,38 :: 		dashboard_flag = 0;
	CLRF       _dashboard_flag+0
;testing2.c,39 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,40 :: 		}
L_main3:
;testing2.c,42 :: 		if(portd.B7 == 0 & portd.B6 == 0&
	BTFSC      PORTD+0, 7
	GOTO       L__main21
	BSF        114, 0
	GOTO       L__main22
L__main21:
	BCF        114, 0
L__main22:
	BTFSC      PORTD+0, 6
	GOTO       L__main23
	BSF        3, 0
	GOTO       L__main24
L__main23:
	BCF        3, 0
L__main24:
	BTFSS      114, 0
	GOTO       L__main25
	BTFSS      3, 0
	GOTO       L__main25
	BSF        114, 0
	GOTO       L__main26
L__main25:
	BCF        114, 0
L__main26:
;testing2.c,43 :: 		portd.B5 == 1 & portd.B4 == 0){  // Check if an incorrect password was entered
	BTFSC      PORTD+0, 5
	GOTO       L__main27
	BCF        3, 0
	GOTO       L__main28
L__main27:
	BSF        3, 0
L__main28:
	BTFSS      114, 0
	GOTO       L__main29
	BTFSS      3, 0
	GOTO       L__main29
	BSF        114, 0
	GOTO       L__main30
L__main29:
	BCF        114, 0
L__main30:
	BTFSC      PORTD+0, 4
	GOTO       L__main31
	BSF        3, 0
	GOTO       L__main32
L__main31:
	BCF        3, 0
L__main32:
	BTFSS      114, 0
	GOTO       L__main33
	BTFSS      3, 0
	GOTO       L__main33
	BSF        114, 0
	GOTO       L__main34
L__main33:
	BCF        114, 0
L__main34:
	BTFSS      114, 0
	GOTO       L_main4
;testing2.c,44 :: 		Lcd_Out(1, 1, "WRONG PASSWORD!! ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,45 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;testing2.c,46 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,47 :: 		}
	GOTO       L_main6
L_main4:
;testing2.c,48 :: 		else if(!portd.B7){    // prompts user for pass when not authenticated
	BTFSC      PORTD+0, 7
	GOTO       L_main7
;testing2.c,50 :: 		Lcd_Out(1, 1, "ENTER PASSWORD: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,51 :: 		}
	GOTO       L_main8
L_main7:
;testing2.c,52 :: 		else if(!dashboard_flag) {  // Displays welcome message if the password is correct
	MOVF       _dashboard_flag+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;testing2.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,54 :: 		Lcd_Out(1, 1, "Welcome :) ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,55 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;testing2.c,56 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;testing2.c,57 :: 		dashboard_flag = 1;
	MOVLW      1
	MOVWF      _dashboard_flag+0
;testing2.c,58 :: 		}
	GOTO       L_main11
L_main9:
;testing2.c,60 :: 		Lcd_Out(1, 1, "1.DOOR: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,61 :: 		Lcd_Out(2, 1, "2.GARAGE: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,62 :: 		Lcd_Out(1, 1+16, "3.GARDEN: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,63 :: 		Lcd_Out(2, 1+16, "4.COOLING: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;testing2.c,66 :: 		if(portd.B0) Lcd_Out(1, 9, "ON ");
	BTFSS      PORTD+0, 0
	GOTO       L_main12
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main13
L_main12:
;testing2.c,67 :: 		else Lcd_Out(1, 9, "OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main13:
;testing2.c,69 :: 		if(portd.B1) Lcd_Out(2, 11, "ON ");
	BTFSS      PORTD+0, 1
	GOTO       L_main14
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main15
L_main14:
;testing2.c,70 :: 		else Lcd_Out(2, 11, "OFF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main15:
;testing2.c,72 :: 		if(portd.B2) Lcd_Out(1, 11+16, "ON ");
	BTFSS      PORTD+0, 2
	GOTO       L_main16
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      27
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main17
L_main16:
;testing2.c,73 :: 		else Lcd_Out(1, 11+16, "OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      27
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main17:
;testing2.c,75 :: 		if(portd.B3) Lcd_Out(2, 12+16, "ON ");
	BTFSS      PORTD+0, 3
	GOTO       L_main18
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      28
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main19
L_main18:
;testing2.c,76 :: 		else Lcd_Out(2, 12+16, "OFF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      28
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr15_testing2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main19:
;testing2.c,77 :: 		}
L_main11:
L_main8:
L_main6:
;testing2.c,78 :: 		}
L_main2:
;testing2.c,79 :: 		}
	GOTO       L_main0
;testing2.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
