#line 1 "D:/University/Embedded Systems/Project/smart_home_controller/testing ALL/testing.c"
unsigned int value;
unsigned int value2;
unsigned short int flag1 =0x00;
unsigned short int flag2 = 0xFF;

unsigned short kp = 0;
unsigned short input_digit;
char input_pass[4];

int correct_pass_flag[4];
unsigned short int pass_counter = 0;

char txt[6];


char keypadPort at PORTD;

void main(){
 EEPROM_Write(0x32, 49);
 EEPROM_Write(0x33, 50);
 EEPROM_Write(0x34, 51);
 EEPROM_Write(0x35, 52);

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
 else flag1.B0 = 0;

 if ((portb.b0 == 1) && (flag2.B1 == 1))
 flag1.B1 = 1;
 else flag1.B1 = 0;



 ADCON0 = 0b00001001;
 value2 = ADC_Read(1)*4.88;

 if ((value2>300) && (flag2.B2 == 1))
 flag1.B2 = 1;
 else flag1.B2 = 0;

 delay_ms(10);

 value = ADC_Read(0)*4.88;

 if ((value>300) && (flag2.B3 == 1))
 flag1.B3 = 1;
 else flag1.B3 = 0;
#line 81 "D:/University/Embedded Systems/Project/smart_home_controller/testing ALL/testing.c"
 UART1_Write(flag1);
 delay_ms(100);

 if (!flag1.B7){
 if(pass_counter < 4){


 input_digit = Keypad_Key_Click();
 if(input_digit){
 switch (input_digit) {
 case 1: input_digit = 49; break;
 case 2: input_digit = 50; break;
 case 3: input_digit = 51; break;

 case 5: input_digit = 52; break;
 case 6: input_digit = 53; break;
 case 7: input_digit = 54; break;

 case 9: input_digit = 55; break;
 case 10: input_digit = 56; break;
 case 11: input_digit = 57; break;

 case 13: input_digit = 42; break;
 case 14: input_digit = 48; break;
 case 15: input_digit = 35; break;
 }
 if(EEPROM_read(0x32 + pass_counter) == input_digit) correct_pass_flag[pass_counter] = 1;
 else correct_pass_flag[pass_counter] = 0;

 pass_counter++;
 }
 }
 else{

 pass_counter = 0;

 if(correct_pass_flag[0] &
 correct_pass_flag[1] &
 correct_pass_flag[2] &
 correct_pass_flag[3])
 flag1.B7 = 1;
 else{

 flag1.B7 = 0;
 }
 }
 }
 else{

 kp = 0;
 kp = Keypad_Key_Click();


 switch (kp) {
 case 1: flag2.B0 = ~flag2.B0; break;
 case 2: flag2.B1 = ~flag2.B1; break;
 case 3: flag2.B2 = ~flag2.B2; break;
 case 5: flag2.B3 = ~flag2.B3; break;
 }
 }
#line 162 "D:/University/Embedded Systems/Project/smart_home_controller/testing ALL/testing.c"
}
}
