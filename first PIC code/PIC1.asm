
_main:

;PIC1.c,4 :: 		void main(){
;PIC1.c,5 :: 		ADCON1 |= 0x0f;
	MOVLW      15
	IORWF      ADCON1+0, 1
;PIC1.c,6 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;PIC1.c,8 :: 		Trisa = 0x01;
	MOVLW      1
	MOVWF      TRISA+0
;PIC1.c,10 :: 		UART1_Init(9615);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;PIC1.c,11 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
;PIC1.c,12 :: 		ADC_init();
	CALL       _ADC_Init+0
;PIC1.c,13 :: 		Trisb = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;PIC1.c,14 :: 		portb = 0x00;
	CLRF       PORTB+0
;PIC1.c,16 :: 		while(1){
L_main1:
;PIC1.c,17 :: 		if (portb.b0 != 1)
	BTFSC      PORTB+0, 0
	GOTO       L_main3
;PIC1.c,18 :: 		flag1 |= 0x02;
	BSF        _flag1+0, 1
	GOTO       L_main4
L_main3:
;PIC1.c,19 :: 		else flag1 = flag1 & 0xFD;
	MOVLW      253
	ANDWF      _flag1+0, 1
	MOVLW      0
	ANDWF      _flag1+1, 1
L_main4:
;PIC1.c,21 :: 		value = ADC_Read(0)*4.88;
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
;PIC1.c,23 :: 		if(value>300)
	MOVF       R0+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main8
	MOVF       R0+0, 0
	SUBLW      44
L__main8:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;PIC1.c,24 :: 		flag1 = flag1 | 0x01;
	BSF        _flag1+0, 0
	GOTO       L_main6
L_main5:
;PIC1.c,25 :: 		else flag1 = flag1 & 0xFE;
	MOVLW      254
	ANDWF      _flag1+0, 1
	MOVLW      0
	ANDWF      _flag1+1, 1
L_main6:
;PIC1.c,27 :: 		UART1_Write(flag1);
	MOVF       _flag1+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;PIC1.c,29 :: 		}
	GOTO       L_main1
;PIC1.c,30 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
