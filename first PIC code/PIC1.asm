
_main:

;PIC1.c,6 :: 		void main(){
;PIC1.c,7 :: 		ADCON1 |= 0x0f;
	MOVLW      15
	IORWF      ADCON1+0, 1
;PIC1.c,8 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;PIC1.c,10 :: 		Trisa = 0x01;
	MOVLW      1
	MOVWF      TRISA+0
;PIC1.c,12 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;PIC1.c,13 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;PIC1.c,14 :: 		ADC_init();
	CALL       _ADC_Init+0
;PIC1.c,15 :: 		Trisb = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;PIC1.c,16 :: 		portb = 0x00;
	CLRF       PORTB+0
;PIC1.c,18 :: 		while(1){
L_main1:
;PIC1.c,20 :: 		if ((portb.b0 != 1) && (flag2.B0 == 1))
	BTFSC      PORTB+0, 0
	GOTO       L_main5
	BTFSS      _flag2+0, 0
	GOTO       L_main5
L__main13:
;PIC1.c,21 :: 		flag1 |= 0x02;
	BSF        _flag1+0, 1
	GOTO       L_main6
L_main5:
;PIC1.c,22 :: 		else flag1 = flag1 & 0xFD;
	MOVLW      253
	ANDWF      _flag1+0, 1
L_main6:
;PIC1.c,25 :: 		value = ADC_Read(0)*4.88;
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
;PIC1.c,27 :: 		if ((value>300) && (flag2.B1 == 1))
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       R0+0, 0
	SUBLW      44
L__main15:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
	BTFSS      _flag2+0, 1
	GOTO       L_main9
L__main12:
;PIC1.c,28 :: 		flag1 = flag1 | 0x01;
	BSF        _flag1+0, 0
	GOTO       L_main10
L_main9:
;PIC1.c,29 :: 		else flag1 = flag1 & 0xFE;
	MOVLW      254
	ANDWF      _flag1+0, 1
L_main10:
;PIC1.c,44 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;PIC1.c,47 :: 		UART1_Write(flag1);
	MOVF       _flag1+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;PIC1.c,63 :: 		}
	GOTO       L_main1
;PIC1.c,64 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
