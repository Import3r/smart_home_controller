
_main:

;testing.c,14 :: 		void main(){
;testing.c,16 :: 		EEPROM_Write(0x32, 49);  // ASCII values of password characters (zero starts at value 48)
	MOVLW      50
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      49
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,17 :: 		EEPROM_Write(0x33, 50);
	MOVLW      51
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      50
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,18 :: 		EEPROM_Write(0x34, 51);
	MOVLW      52
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      51
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,19 :: 		EEPROM_Write(0x35, 52);
	MOVLW      53
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      52
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,21 :: 		ADCON0 = 0x05;
	MOVLW      5
	MOVWF      ADCON0+0
;testing.c,22 :: 		ADCON1 = 0x00;
	CLRF       ADCON1+0
;testing.c,23 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;testing.c,24 :: 		Trisa = 0x0F;
	MOVLW      15
	MOVWF      TRISA+0
;testing.c,25 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;testing.c,26 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
	NOP
;testing.c,27 :: 		ADC_init();
	CALL       _ADC_Init+0
;testing.c,28 :: 		Trisb = 0x0F;
	MOVLW      15
	MOVWF      TRISB+0
;testing.c,29 :: 		portb = 0x00;
	CLRF       PORTB+0
;testing.c,31 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;testing.c,33 :: 		while(1){
L_main1:
;testing.c,34 :: 		UART1_Write(flag1);                  //transmit flag that controls outputs
	MOVF       _flag1+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;testing.c,35 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;testing.c,38 :: 		if ((portb.b0 == 1) && (flag2.B0 == 1)) flag1.B0 = 1;  // Turn buzzer ON/OFF depending on door sensor
	BTFSS      PORTB+0, 0
	GOTO       L_main6
	BTFSS      _flag2+0, 0
	GOTO       L_main6
L__main54:
	BSF        _flag1+0, 0
	GOTO       L_main7
L_main6:
;testing.c,39 :: 		else flag1.B0 = 0;
	BCF        _flag1+0, 0
L_main7:
;testing.c,42 :: 		if ((portb.b1 == 1) && (flag2.B1 == 1)) flag1.B1 = 1;  // Turn Light ON/OFF depending on PIR sensor
	BTFSS      PORTB+0, 1
	GOTO       L_main10
	BTFSS      _flag2+0, 1
	GOTO       L_main10
L__main53:
	BSF        _flag1+0, 1
	GOTO       L_main11
L_main10:
;testing.c,43 :: 		else flag1.B1 = 0;
	BCF        _flag1+0, 1
L_main11:
;testing.c,46 :: 		ADCON0 = 0b00001001;
	MOVLW      9
	MOVWF      ADCON0+0
;testing.c,47 :: 		value2 = ADC_Read(1)*4.88;
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      246
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      _value2+0
	MOVF       R0+1, 0
	MOVWF      _value2+1
;testing.c,48 :: 		if ((value2>300) && (flag2.B3 == 1)) flag1.B3 = 1;  // Turn Fan ON/OFF depending on temp sensor
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       R0+0, 0
	SUBLW      44
L__main56:
	BTFSC      STATUS+0, 0
	GOTO       L_main14
	BTFSS      _flag2+0, 3
	GOTO       L_main14
L__main52:
	BSF        _flag1+0, 3
	GOTO       L_main15
L_main14:
;testing.c,49 :: 		else flag1.B3 = 0;
	BCF        _flag1+0, 3
L_main15:
;testing.c,52 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	NOP
;testing.c,53 :: 		moisture_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _moisture_value+0
	MOVF       R0+1, 0
	MOVWF      _moisture_value+1
	MOVF       R0+2, 0
	MOVWF      _moisture_value+2
	MOVF       R0+3, 0
	MOVWF      _moisture_value+3
;testing.c,54 :: 		moisture_value = ( moisture_value * 100) / (1023);
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _moisture_value+0
	MOVF       R0+1, 0
	MOVWF      _moisture_value+1
	MOVF       R0+2, 0
	MOVWF      _moisture_value+2
	MOVF       R0+3, 0
	MOVWF      _moisture_value+3
;testing.c,55 :: 		if ((moisture_value<50) && (flag2.B2 == 1)) flag1.B2 = 1;  // Turn water pump ON/OFF depending on moisture sensor
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	BTFSS      _flag2+0, 2
	GOTO       L_main19
L__main51:
	BSF        _flag1+0, 2
	GOTO       L_main20
L_main19:
;testing.c,56 :: 		else flag1.B2 = 0;
	BCF        _flag1+0, 2
L_main20:
;testing.c,60 :: 		flag1.B5 = 0;  // a flag to track incorrect passwords
	BCF        _flag1+0, 5
;testing.c,62 :: 		if (!flag1.B7){  // when not authenticated:
	BTFSC      _flag1+0, 7
	GOTO       L_main21
;testing.c,63 :: 		if(pass_counter < 4){  // when password not complete yet
	MOVLW      4
	SUBWF      _pass_counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main22
;testing.c,64 :: 		input_digit = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _input_digit+0
;testing.c,65 :: 		if(input_digit){  // Turn input digit to ASCII
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
;testing.c,66 :: 		switch (input_digit) {
	GOTO       L_main24
;testing.c,67 :: 		case  1: input_digit = 49; break; // 1
L_main26:
	MOVLW      49
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,68 :: 		case  2: input_digit = 50; break; // 2
L_main27:
	MOVLW      50
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,69 :: 		case  3: input_digit = 51; break; // 3
L_main28:
	MOVLW      51
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,71 :: 		case  5: input_digit = 52; break; // 4
L_main29:
	MOVLW      52
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,72 :: 		case  6: input_digit = 53; break; // 5
L_main30:
	MOVLW      53
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,73 :: 		case  7: input_digit = 54; break; // 6
L_main31:
	MOVLW      54
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,75 :: 		case  9: input_digit = 55; break;  // 7
L_main32:
	MOVLW      55
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,76 :: 		case 10: input_digit = 56; break;  // 8
L_main33:
	MOVLW      56
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,77 :: 		case 11: input_digit = 57; break;  // 9
L_main34:
	MOVLW      57
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,79 :: 		case 13: input_digit = 42; break;  // '*'
L_main35:
	MOVLW      42
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,80 :: 		case 14: input_digit = 48; break;  // 0
L_main36:
	MOVLW      48
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,81 :: 		case 15: input_digit = 35; break;  // '#'
L_main37:
	MOVLW      35
	MOVWF      _input_digit+0
	GOTO       L_main25
;testing.c,82 :: 		}
L_main24:
	MOVF       _input_digit+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _input_digit+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _input_digit+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVF       _input_digit+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _input_digit+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _input_digit+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVF       _input_digit+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _input_digit+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVF       _input_digit+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVF       _input_digit+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVF       _input_digit+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main36
	MOVF       _input_digit+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main37
L_main25:
;testing.c,84 :: 		if(EEPROM_read(0x32 + pass_counter) == input_digit) correct_pass_flag[pass_counter] = 1;
	MOVF       _pass_counter+0, 0
	ADDLW      50
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	XORWF      _input_digit+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main38
	MOVF       _pass_counter+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _correct_pass_flag+0
	MOVWF      FSR
	MOVLW      1
	MOVWF      INDF+0
	MOVLW      0
	INCF       FSR, 1
	MOVWF      INDF+0
	GOTO       L_main39
L_main38:
;testing.c,85 :: 		else correct_pass_flag[pass_counter] = 0;
	MOVF       _pass_counter+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _correct_pass_flag+0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
L_main39:
;testing.c,87 :: 		pass_counter++;
	INCF       _pass_counter+0, 1
;testing.c,88 :: 		}
L_main23:
;testing.c,89 :: 		}
	GOTO       L_main40
L_main22:
;testing.c,91 :: 		pass_counter = 0;
	CLRF       _pass_counter+0
;testing.c,94 :: 		if(correct_pass_flag[0] & correct_pass_flag[1] &
	MOVF       _correct_pass_flag+2, 0
	ANDWF      _correct_pass_flag+0, 0
	MOVWF      R0+0
	MOVF       _correct_pass_flag+1, 0
	ANDWF      _correct_pass_flag+3, 0
	MOVWF      R0+1
;testing.c,95 :: 		correct_pass_flag[2] & correct_pass_flag[3]) flag1.B7 = 1;
	MOVF       _correct_pass_flag+4, 0
	ANDWF      R0+0, 1
	MOVF       _correct_pass_flag+5, 0
	ANDWF      R0+1, 1
	MOVF       _correct_pass_flag+6, 0
	ANDWF      R0+0, 1
	MOVF       _correct_pass_flag+7, 0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main41
	BSF        _flag1+0, 7
	GOTO       L_main42
L_main41:
;testing.c,98 :: 		flag1.B7 = 0;
	BCF        _flag1+0, 7
;testing.c,99 :: 		flag1.B6 = 0;
	BCF        _flag1+0, 6
;testing.c,100 :: 		flag1.B5 = 1;
	BSF        _flag1+0, 5
;testing.c,101 :: 		flag1.B4 = 0;
	BCF        _flag1+0, 4
;testing.c,102 :: 		}
L_main42:
;testing.c,103 :: 		}
L_main40:
;testing.c,104 :: 		}
	GOTO       L_main43
L_main21:
;testing.c,106 :: 		kp = 0;
	CLRF       _kp+0
;testing.c,107 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;testing.c,109 :: 		switch (kp) {  // Toggle a system ON/OFF depending on key press
	GOTO       L_main44
;testing.c,110 :: 		case  1: flag2.B0 = ~flag2.B0; break; // 1
L_main46:
	MOVLW      1
	XORWF      _flag2+0, 1
	GOTO       L_main45
;testing.c,111 :: 		case  2: flag2.B1 = ~flag2.B1; break;// 2
L_main47:
	MOVLW      2
	XORWF      _flag2+0, 1
	GOTO       L_main45
;testing.c,112 :: 		case  3: flag2.B2 = ~flag2.B2; break;// 3
L_main48:
	MOVLW      4
	XORWF      _flag2+0, 1
	GOTO       L_main45
;testing.c,113 :: 		case  5: flag2.B3 = ~flag2.B3; break;// 4
L_main49:
	MOVLW      8
	XORWF      _flag2+0, 1
	GOTO       L_main45
;testing.c,114 :: 		case 15:{flag2 = 0xFF;               // lock option when # is pressed
L_main50:
	MOVLW      255
	MOVWF      _flag2+0
;testing.c,115 :: 		pass_counter = 0;
	CLRF       _pass_counter+0
;testing.c,116 :: 		flag1 = 0x00;
	CLRF       _flag1+0
;testing.c,117 :: 		break;
	GOTO       L_main45
;testing.c,119 :: 		}
L_main44:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main47
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main48
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main49
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main50
L_main45:
;testing.c,120 :: 		}
L_main43:
;testing.c,121 :: 		}
	GOTO       L_main1
;testing.c,122 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
