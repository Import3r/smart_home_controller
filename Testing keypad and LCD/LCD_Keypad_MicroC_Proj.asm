
_main:

;LCD_Keypad_MicroC_Proj.c,24 :: 		void main() {
;LCD_Keypad_MicroC_Proj.c,25 :: 		cnt = 0;                                 // Reset counter
	CLRF       _cnt+0
;LCD_Keypad_MicroC_Proj.c,26 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;LCD_Keypad_MicroC_Proj.c,29 :: 		ADCON1 |= 0x0F;                             // Configure AN pins as digital I/O
	MOVLW      15
	IORWF      ADCON1+0, 1
;LCD_Keypad_MicroC_Proj.c,30 :: 		CMCON  |= 7;                      // Disable comparators
	MOVLW      7
	IORWF      CMCON+0, 1
;LCD_Keypad_MicroC_Proj.c,31 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;LCD_Keypad_MicroC_Proj.c,32 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD_Keypad_MicroC_Proj.c,33 :: 		Lcd_Cmd(_LCD_FOURTH_ROW);
	MOVLW      212
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD_Keypad_MicroC_Proj.c,38 :: 		Lcd_Out(1, 1, "1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_LCD_Keypad_MicroC_Proj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD_Keypad_MicroC_Proj.c,39 :: 		Lcd_Out(2, 1, "2");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_LCD_Keypad_MicroC_Proj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD_Keypad_MicroC_Proj.c,40 :: 		Lcd_Out(1, 1+16, "3");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_LCD_Keypad_MicroC_Proj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD_Keypad_MicroC_Proj.c,41 :: 		Lcd_Out(2, 1+16, "4");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      17
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_LCD_Keypad_MicroC_Proj+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD_Keypad_MicroC_Proj.c,43 :: 		while (1){
L_main0:
;LCD_Keypad_MicroC_Proj.c,44 :: 		kp = 0;                                // Reset key code variable
	CLRF       _kp+0
;LCD_Keypad_MicroC_Proj.c,47 :: 		do
L_main2:
;LCD_Keypad_MicroC_Proj.c,49 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;LCD_Keypad_MicroC_Proj.c,50 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;LCD_Keypad_MicroC_Proj.c,53 :: 		switch (kp) {
	GOTO       L_main5
;LCD_Keypad_MicroC_Proj.c,54 :: 		case  1: kp = 49; break; // 1
L_main7:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,55 :: 		case  2: kp = 50; break; // 2
L_main8:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,56 :: 		case  3: kp = 51; break; // 3
L_main9:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,58 :: 		case  5: kp = 52; break; // 4
L_main10:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,59 :: 		case  6: kp = 53; break; // 5
L_main11:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,60 :: 		case  7: kp = 54; break; // 6
L_main12:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,62 :: 		case  9: kp = 55; break; // 7
L_main13:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,63 :: 		case 10: kp = 56; break;  // 8
L_main14:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,64 :: 		case 11: kp = 57; break;  // 9
L_main15:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,66 :: 		case 13: kp = 42; break;  // '*'
L_main16:
	MOVLW      42
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,67 :: 		case 14: kp = 48; break;  // 0
L_main17:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,68 :: 		case 15: kp = 35; break;  // '#'
L_main18:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_main6
;LCD_Keypad_MicroC_Proj.c,70 :: 		default: kp += 48;
L_main19:
	MOVLW      48
	ADDWF      _kp+0, 1
;LCD_Keypad_MicroC_Proj.c,71 :: 		}
	GOTO       L_main6
L_main5:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	GOTO       L_main19
L_main6:
;LCD_Keypad_MicroC_Proj.c,73 :: 		Lcd_Chr(1, 10, kp);                    // Print key ASCII value on LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;LCD_Keypad_MicroC_Proj.c,74 :: 		}
	GOTO       L_main0
;LCD_Keypad_MicroC_Proj.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
