#line 1 "D:/University/Embedded Systems/Project/smart_home_controller/first PIC code/PIC1.c"
unsigned int value;
unsigned short int flag1 =0x00;
unsigned short int flag2 = 0xFF;


void main(){
 ADCON1 |= 0x0f;
 CMCON = 7;

 Trisa = 0x01;

 UART1_Init(9615);
 delay_ms(100);
 ADC_init();
 Trisb = 0x01;
 portb = 0x00;

 while(1){

 if ((portb.b0 != 1) && (flag2.B0 == 1))
 flag1 |= 0x02;
 else flag1 = flag1 & 0xFD;


 value = ADC_Read(0)*4.88;

 if ((value>300) && (flag2.B1 == 1))
 flag1 = flag1 | 0x01;
 else flag1 = flag1 & 0xFE;
#line 44 "D:/University/Embedded Systems/Project/smart_home_controller/first PIC code/PIC1.c"
 delay_ms(500);


 UART1_Write(flag1);
#line 63 "D:/University/Embedded Systems/Project/smart_home_controller/first PIC code/PIC1.c"
}
}
