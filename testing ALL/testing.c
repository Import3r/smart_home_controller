unsigned int value;
unsigned int value2;
unsigned short int flag1 =0x00;    //flag byte to send to the other PIC to control outputs
unsigned short int flag2 = 0xFF;   //flag byte refering to the user control of sub-systems, initialized FF
                                   //as sub-systems are initially activated
unsigned short kp = 0;

char txt[6];
//, cnt, oldstate
// Keypad module connections
char  keypadPort at PORTD;

void main(){
 EEPROM_Write(0x32, 1); //initialize password in address 0x32 (higher two digits in lower address)
 EEPROM_Write(0x33, 2); //lower two digits in higher address
 EEPROM_Write(0x34, 3);
 EEPROM_Write(0x35, 4);
 
 ADCON0 = 0x05;
 ADCON1 = 0x00;
 CMCON = 7;

 Trisa = 0x0F;

 UART1_Init(9615);
 delay_ms(50);
 ADC_init();
 Trisb = 0x0F;
 portb = 0x00;
 //Trisd = 0xff;
 //cnt = 0;                                 // Reset counter
 Keypad_Init();                           // Initialize Keypad
 
 while(1){
  //door sensor
  if ((portb.b0 != 1) && (flag2.B0 == 1))
     flag1.B0 = 1;  //flag1 |= 0x02;     //buzzer ON
  else flag1.B0 =0; //flag1 = flag1 & 0xFD;
  
  if ((portb.b0 == 1) && (flag2.B1 == 1))
     flag1.B1 = 1;    //LED
  else flag1.B1 = 0; //flag1 = flag1 & 0xF7;     //flag1 |= 0x08;
  //delay_ms(100);
  
  //temperature sensor
  ADCON0 = 0b00001001;
  value2 = ADC_Read(1)*4.88;

  if ((value2>300) && (flag2.B2 == 1))
    flag1.B2 = 1;//flag1 = flag1 | 0x01;
  else flag1.B2 =0;//flag1 = flag1 & 0xFE; //1111 1110
  
  delay_ms(10);
  //ADCON0 = 0b00000001;
  value = ADC_Read(0)*4.88;

  if ((value>300) && (flag2.B3 == 1))
   flag1.B3 = 1;
  else flag1.B3 = 0;
  /*
  //PIR sensor
  if ((//PIR sensor) && (flag2.B2 == 1))
   flag1 |= 0x04; //set bit
  else flag1 &= 0xFB;     //reset bit
  
  //Moisture sensor
  if ((//moisture) && (flag2.B3 == 1))
   flag1 |= 0x08;  //set bit
  else flag1 &= 0xF7;     //reset bit
  */
  
  //read values once every 0.5 second

  
  //send control byte to the other PIC to adjust outputs
  UART1_Write(flag1);
  delay_ms(100);
  //Display Welcome and enter password (use UART)
  //delay_ms(100);
  //read password and compare it to EEPROM read value
  kp = 0;
  
  // Wait for key to be pressed and released
    //do
    //  kp = Keypad_Key_Press();          // Store key code in kp variable
   kp = Keypad_Key_Click();             // Store key code in kp variable
   // while (!kp);
   // Prepare value for output, transform key to it's ASCII value
    switch (kp) {
      case  1: flag2.B0 = ~flag2.B0; break; // 1
      case  2: flag2.B1 = ~flag2.B1; break;// 2
      case  3: flag2.B2 = ~flag2.B2; break;// 3
      case  5: flag2.B3 = ~flag2.B3; break;// 4
    }                               // Reset key code variable
  //set or reset authintecation flag
  
  //Two options to display: 1- wrong password (use UART):
  //                                 GOTO beginning of while loop
  //
  //                        2- dashboard (use UART):
  //                                 a) read input from user (use UART)
  //                                 b) based on input set/reset flag2 bits
  //                                 c) option to change password (write to EEPROM)
  // authintication flag may not be necessary
}
}