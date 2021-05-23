
_main:

;testing.c,13 :: 		void main(){
;testing.c,17 :: 		ADCON0 = 0x05;
	MOVLW      5
	MOVWF      ADCON0+0
;testing.c,18 :: 		ADCON1 = 0x00;
	CLRF       ADCON1+0
;testing.c,19 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;testing.c,21 :: 		Trisa = 0x0F;
	MOVLW      15
	MOVWF      TRISA+0
;testing.c,23 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;testing.c,24 :: 		delay_ms(50);
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
;testing.c,25 :: 		ADC_init();
	CALL       _ADC_Init+0
;testing.c,26 :: 		Trisb = 0x0F;
	MOVLW      15
	MOVWF      TRISB+0
;testing.c,27 :: 		portb = 0x00;
	CLRF       PORTB+0
;testing.c,30 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;testing.c,32 :: 		while(1){
L_main1:
;testing.c,34 :: 		if ((portb.b0 != 1) && (flag2.B0 == 1))
	BTFSC      PORTB+0, 0
	GOTO       L_main5
	BTFSS      _flag2+0, 0
	GOTO       L_main5
L__main30:
;testing.c,35 :: 		flag1.B0 = 1;  //flag1 |= 0x02;     //buzzer ON
	BSF        _flag1+0, 0
	GOTO       L_main6
L_main5:
;testing.c,36 :: 		else flag1.B0 =0; //flag1 = flag1 & 0xFD;
	BCF        _flag1+0, 0
L_main6:
;testing.c,38 :: 		if ((portb.b0 == 1) && (flag2.B1 == 1))
	BTFSS      PORTB+0, 0
	GOTO       L_main9
	BTFSS      _flag2+0, 1
	GOTO       L_main9
L__main29:
;testing.c,39 :: 		flag1.B1 = 1;    //LED
	BSF        _flag1+0, 1
	GOTO       L_main10
L_main9:
;testing.c,40 :: 		else flag1.B1 = 0; //flag1 = flag1 & 0xF7;     //flag1 |= 0x08;
	BCF        _flag1+0, 1
L_main10:
;testing.c,44 :: 		ADCON0 = 0b00001001;
	MOVLW      9
	MOVWF      ADCON0+0
;testing.c,45 :: 		value2 = ADC_Read(1)*4.88;
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
;testing.c,47 :: 		if ((value2>300) && (flag2.B2 == 1))
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       R0+0, 0
	SUBLW      44
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
	BTFSS      _flag2+0, 2
	GOTO       L_main13
L__main28:
;testing.c,48 :: 		flag1.B2 = 1;//flag1 = flag1 | 0x01;
	BSF        _flag1+0, 2
	GOTO       L_main14
L_main13:
;testing.c,49 :: 		else flag1.B2 =0;//flag1 = flag1 & 0xFE; //1111 1110
	BCF        _flag1+0, 2
L_main14:
;testing.c,51 :: 		delay_ms(10);
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
;testing.c,53 :: 		value = ADC_Read(0)*4.88;
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
;testing.c,55 :: 		if ((value>300) && (flag2.B3 == 1))
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVF       R0+0, 0
	SUBLW      44
L__main33:
	BTFSC      STATUS+0, 0
	GOTO       L_main18
	BTFSS      _flag2+0, 3
	GOTO       L_main18
L__main27:
;testing.c,56 :: 		flag1.B3 = 1;
	BSF        _flag1+0, 3
	GOTO       L_main19
L_main18:
;testing.c,57 :: 		else flag1.B3 = 0;
	BCF        _flag1+0, 3
L_main19:
;testing.c,74 :: 		UART1_Write(flag1);
	MOVF       _flag1+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;testing.c,75 :: 		delay_ms(100);
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
;testing.c,79 :: 		kp = 0;
	CLRF       _kp+0
;testing.c,84 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;testing.c,87 :: 		switch (kp) {
	GOTO       L_main21
;testing.c,88 :: 		case  1: flag2.B0 = ~flag2.B0; break; // 1
L_main23:
	MOVLW      1
	XORWF      _flag2+0, 1
	GOTO       L_main22
;testing.c,89 :: 		case  2: flag2.B1 = ~flag2.B1; break;// 2
L_main24:
	MOVLW      2
	XORWF      _flag2+0, 1
	GOTO       L_main22
;testing.c,90 :: 		case  3: flag2.B2 = ~flag2.B2; break;// 3
L_main25:
	MOVLW      4
	XORWF      _flag2+0, 1
	GOTO       L_main22
;testing.c,91 :: 		case  5: flag2.B3 = ~flag2.B3; break;// 4
L_main26:
	MOVLW      8
	XORWF      _flag2+0, 1
	GOTO       L_main22
;testing.c,92 :: 		}                               // Reset key code variable
L_main21:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main26
L_main22:
;testing.c,103 :: 		}
	GOTO       L_main1
;testing.c,104 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
