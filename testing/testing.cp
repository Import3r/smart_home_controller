#line 1 "D:/University/Embedded Systems/testing/testing.c"
unsigned int value;
unsigned int value2;
unsigned short int flag1 =0x00;
unsigned short int flag2 = 0xFF;

unsigned short kp = 0;

char txt[6];


char keypadPort at PORTD;

void main(){



 ADCON0 = 0x05;
 ADCON1 = 0x00;
 CMCON = 7;

 Trisa = 0x0F;

 UART1_Init(9615);
 delay_ms(50);
 ADC_init();
 Trisb = 0x0F;
 portb = 0x00;


 Keypad_Init();

 while(1){

 if ((portb.b0 != 1) && (flag2.B0 == 1))
 flag1.B0 = 1;
 else flag1.B0 =0;

 if ((portb.b0 == 1) && (flag2.B1 == 1))
 flag1.B1 = 1;
 else flag1.B1 = 0;



 ADCON0 = 0b00001001;
 value2 = ADC_Read(1)*4.88;

 if ((value2>300) && (flag2.B2 == 1))
 flag1.B2 = 1;
 else flag1.B2 =0;

 delay_ms(10);

 value = ADC_Read(0)*4.88;

 if ((value>300) && (flag2.B3 == 1))
 flag1.B3 = 1;
 else flag1.B3 = 0;
#line 74 "D:/University/Embedded Systems/testing/testing.c"
 UART1_Write(flag1);
 delay_ms(100);



 kp = 0;




 kp = Keypad_Key_Click();


 switch (kp) {
 case 1: flag2.B0 = ~flag2.B0; break;
 case 2: flag2.B1 = ~flag2.B1; break;
 case 3: flag2.B2 = ~flag2.B2; break;
 case 5: flag2.B3 = ~flag2.B3; break;
 }










}
}
