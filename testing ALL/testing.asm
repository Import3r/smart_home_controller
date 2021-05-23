
_main:

;testing.c,17 :: 		void main(){
;testing.c,18 :: 		EEPROM_Write(0x32, 49);  // ASCII values of password characters (zero starts at value 48)
	MOVLW      50
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      49
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,19 :: 		EEPROM_Write(0x33, 50);
	MOVLW      51
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      50
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,20 :: 		EEPROM_Write(0x34, 51);
	MOVLW      52
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      51
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,21 :: 		EEPROM_Write(0x35, 52);
	MOVLW      53
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      52
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;testing.c,23 :: 		ADCON0 = 0x05;
	MOVLW      5
	MOVWF      ADCON0+0
;testing.c,24 :: 		ADCON1 = 0x00;
	CLRF       ADCON1+0
;testing.c,25 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;testing.c,27 :: 		Trisa = 0x0F;
	MOVLW      15
	MOVWF      TRISA+0
;testing.c,29 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;testing.c,30 :: 		delay_ms(50);
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
;testing.c,31 :: 		ADC_init();
	CALL       _ADC_Init+0
;testing.c,32 :: 		Trisb = 0x0F;
	MOVLW      15
	MOVWF      TRISB+0
;testing.c,33 :: 		portb = 0x00;
	CLRF       PORTB+0
;testing.c,36 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;testing.c,38 :: 		while(1){
L_main1:
;testing.c,40 :: 		if ((portb.b0 != 1) && (flag2.B0 == 1))
	BTFSC      PORTB+0, 0
	GOTO       L_main5
	BTFSS      _flag2+0, 0
	GOTO       L_main5
L__main52:
;testing.c,41 :: 		flag1.B0 = 1;  //flag1 |= 0x02;     //buzzer ON
	BSF        _flag1+0, 0
	GOTO       L_main6
L_main5:
;testing.c,42 :: 		else flag1.B0 = 0; //flag1 = flag1 & 0xFD;
	BCF        _flag1+0, 0
L_main6:
;testing.c,44 :: 		if ((portb.b0 == 1) && (flag2.B1 == 1))
	BTFSS      PORTB+0, 0
	GOTO       L_main9
	BTFSS      _flag2+0, 1
	GOTO       L_main9
L__main51:
;testing.c,45 :: 		flag1.B1 = 1;    //LED
	BSF        _flag1+0, 1
	GOTO       L_main10
L_main9:
;testing.c,46 :: 		else flag1.B1 = 0; //flag1 = flag1 & 0xF7;     //flag1 |= 0x08;
	BCF        _flag1+0, 1
L_main10:
;testing.c,50 :: 		ADCON0 = 0b00001001;
	MOVLW      9
	MOVWF      ADCON0+0
;testing.c,51 :: 		value2 = ADC_Read(1)*4.88;
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
;testing.c,53 :: 		if ((value2>300) && (flag2.B2 == 1))
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVF       R0+0, 0
	SUBLW      44
L__main54:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
	BTFSS      _flag2+0, 2
	GOTO       L_main13
L__main50:
;testing.c,54 :: 		flag1.B2 = 1;//flag1 = flag1 | 0x01;
	BSF        _flag1+0, 2
	GOTO       L_main14
L_main13:
;testing.c,55 :: 		else flag1.B2 = 0;//flag1 = flag1 & 0xFE; //1111 1110
	BCF        _flag1+0, 2
L_main14:
;testing.c,57 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	NOP
;testing.c,59 :: 		value = ADC_Read(0)*4.88;
	CLRF       FARG_ADC_Read_channel+0
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
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;testing.c,61 :: 		if ((value>300) && (flag2.B3 == 1))
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVF       R0+0, 0
	SUBLW      44
L__main55:
	BTFSC      STATUS+0, 0
	GOTO       L_main18
	BTFSS      _flag2+0, 3
	GOTO       L_main18
L__main49:
;testing.c,62 :: 		flag1.B3 = 1;
	BSF        _flag1+0, 3
	GOTO       L_main19
L_main18:
;testing.c,63 :: 		else flag1.B3 = 0;
	BCF        _flag1+0, 3
L_main19:
;testing.c,80 :: 		UART1_Write(flag1);
	MOVF       _flag1+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;testing.c,81 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
;testing.c,83 :: 		if (!flag1.B7){ // if not authenticated
	BTFSC      _flag1+0, 7
	GOTO       L_main21
;testing.c,84 :: 		if(pass_counter < 4){ // when password not complete
	MOVLW      4
	SUBWF      _pass_counter+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main22
;testing.c,88 :: 		input_digit = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _input_digit+0
;testing.c,89 :: 		switch (input_digit) {
	GOTO       L_main23
;testing.c,90 :: 		case  1: input_digit = 49; break; // 1
L_main25:
	MOVLW      49
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,91 :: 		case  2: input_digit = 50; break; // 2
L_main26:
	MOVLW      50
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,92 :: 		case  3: input_digit = 51; break; // 3
L_main27:
	MOVLW      51
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,94 :: 		case  5: input_digit = 52; break; // 4
L_main28:
	MOVLW      52
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,95 :: 		case  6: input_digit = 53; break; // 5
L_main29:
	MOVLW      53
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,96 :: 		case  7: input_digit = 54; break; // 6
L_main30:
	MOVLW      54
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,98 :: 		case  9: input_digit = 55; break;  // 7
L_main31:
	MOVLW      55
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,99 :: 		case 10: input_digit = 56; break;  // 8
L_main32:
	MOVLW      56
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,100 :: 		case 11: input_digit = 57; break;  // 9
L_main33:
	MOVLW      57
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,102 :: 		case 13: input_digit = 42; break;  // '*'
L_main34:
	MOVLW      42
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,103 :: 		case 14: input_digit = 48; break;  // 0
L_main35:
	MOVLW      48
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,104 :: 		case 15: input_digit = 35; break;  // '#'
L_main36:
	MOVLW      35
	MOVWF      _input_digit+0
	GOTO       L_main24
;testing.c,105 :: 		}
L_main23:
	MOVF       _input_digit+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVF       _input_digit+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVF       _input_digit+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _input_digit+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVF       _input_digit+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVF       _input_digit+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _input_digit+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVF       _input_digit+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main32
	MOVF       _input_digit+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVF       _input_digit+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVF       _input_digit+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	MOVF       _input_digit+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main36
L_main24:
;testing.c,107 :: 		if(EEPROM_read(0x32 + pass_counter) == input_digit) correct_pass_flag = 1;
	MOVF       _pass_counter+0, 0
	ADDLW      50
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	XORWF      _input_digit+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main37
	MOVLW      1
	MOVWF      _correct_pass_flag+0
	GOTO       L_main38
L_main37:
;testing.c,108 :: 		else correct_pass_flag = 0;
	CLRF       _correct_pass_flag+0
L_main38:
;testing.c,110 :: 		pass_counter++;
	INCF       _pass_counter+0, 1
;testing.c,111 :: 		}
	GOTO       L_main39
L_main22:
;testing.c,114 :: 		pass_counter = 0;
	CLRF       _pass_counter+0
;testing.c,116 :: 		if(correct_pass_flag) flag1.B7 = 1;
	MOVF       _correct_pass_flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	BSF        _flag1+0, 7
	GOTO       L_main41
L_main40:
;testing.c,120 :: 		flag1.B7 = 0;
	BCF        _flag1+0, 7
;testing.c,121 :: 		}
L_main41:
;testing.c,122 :: 		}
L_main39:
;testing.c,123 :: 		}
	GOTO       L_main42
L_main21:
;testing.c,126 :: 		kp = 0;
	CLRF       _kp+0
;testing.c,127 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;testing.c,130 :: 		switch (kp) {
	GOTO       L_main43
;testing.c,131 :: 		case  1: flag2.B0 = ~flag2.B0; break; // 1
L_main45:
	MOVLW      1
	XORWF      _flag2+0, 1
	GOTO       L_main44
;testing.c,132 :: 		case  2: flag2.B1 = ~flag2.B1; break;// 2
L_main46:
	MOVLW      2
	XORWF      _flag2+0, 1
	GOTO       L_main44
;testing.c,133 :: 		case  3: flag2.B2 = ~flag2.B2; break;// 3
L_main47:
	MOVLW      4
	XORWF      _flag2+0, 1
	GOTO       L_main44
;testing.c,134 :: 		case  5: flag2.B3 = ~flag2.B3; break;// 4
L_main48:
	MOVLW      8
	XORWF      _flag2+0, 1
	GOTO       L_main44
;testing.c,135 :: 		}
L_main43:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main47
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main48
L_main44:
;testing.c,136 :: 		}
L_main42:
;testing.c,158 :: 		}
	GOTO       L_main1
;testing.c,159 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
