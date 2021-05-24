unsigned int value;
unsigned int value2;
unsigned short int flag1 =0x00;    //flag byte to send to the other PIC to control outputs
unsigned short int flag2 = 0xFF;   //flag byte refering to the user control of sub-systems, initialized FF
                                   //as sub-systems are initially activated
unsigned short kp = 0;
unsigned short input_digit;
char input_pass[4];
//unsigned short int correct_pass_flag = 1;
int correct_pass_flag[4];
unsigned short int pass_counter = 0;

char txt[6];
//, cnt, oldstate
// Keypad module connections
char  keypadPort at PORTD;

void main(){
 EEPROM_Write(0x32, 49);  // ASCII values of password characters (zero starts at value 48)
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
 //Trisd = 0xff;
 //cnt = 0;                                 // Reset counter
 Keypad_Init();                           // Initialize Keypad
 
 while(1){
 //door sensor
  if ((portb.b0 != 1) && (flag2.B0 == 1))
     flag1.B0 = 1;  //flag1 |= 0x02;     //buzzer ON
  else flag1.B0 = 0; //flag1 = flag1 & 0xFD;
  
  if ((portb.b0 == 1) && (flag2.B1 == 1))
     flag1.B1 = 1;    //LED
  else flag1.B1 = 0; //flag1 = flag1 & 0xF7;     //flag1 |= 0x08;
  //delay_ms(100);
  
  //temperature sensor
  ADCON0 = 0b00001001;
  value2 = ADC_Read(1)*4.88;

  if ((value2>300) && (flag2.B2 == 1))
    flag1.B2 = 1;//flag1 = flag1 | 0x01;
  else flag1.B2 = 0;//flag1 = flag1 & 0xFE; //1111 1110
  
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

   if (!flag1.B7){ // if not authenticated
     if(pass_counter < 4){ // when password not complete
     // keep printing "Please enter password"
     // keep taking digits
     input_digit = Keypad_Key_Click();
     if(input_digit){
       switch (input_digit) {
          case  1: input_digit = 49; break; // 1
          case  2: input_digit = 50; break; // 2
          case  3: input_digit = 51; break; // 3

          case  5: input_digit = 52; break; // 4
          case  6: input_digit = 53; break; // 5
          case  7: input_digit = 54; break; // 6

          case  9: input_digit = 55; break;  // 7
          case 10: input_digit = 56; break;  // 8
          case 11: input_digit = 57; break;  // 9

          case 13: input_digit = 42; break;  // '*'
          case 14: input_digit = 48; break;  // 0
          case 15: input_digit = 35; break;  // '#'
        }
        if(EEPROM_read(0x32 + pass_counter) == input_digit) correct_pass_flag[pass_counter] = 1;
        else correct_pass_flag[pass_counter] = 0;

        pass_counter++;
      }
     }
     else{ // password complete
     //check if password is correct, if not go back to "passsword not complete"
       pass_counter = 0;
       
       if(correct_pass_flag[0] &
          correct_pass_flag[1] &
          correct_pass_flag[2] &
          correct_pass_flag[3])
          flag1.B7 = 1;
       else{ // password complete and wrong
       // print wrong password
       flag1.B7 = 0;
       }
     }
   }
   else{
   // the authenticated functionality
   kp = 0;
   kp = Keypad_Key_Click();             // Store key code in kp variable
   
   // Prepare value for output, transform key to it's ASCII value
    switch (kp) {
      case  1: flag2.B0 = ~flag2.B0; break; // 1
      case  2: flag2.B1 = ~flag2.B1; break;// 2
      case  3: flag2.B2 = ~flag2.B2; break;// 3
      case  5: flag2.B3 = ~flag2.B3; break;// 4
    }
   }

  
  //Display Welcome and enter password (use UART)
  //delay_ms(100);
  //read password and compare it to EEPROM read value

  
  // Wait for key to be pressed and released
    //do
    //  kp = Keypad_Key_Press();          // Store key code in kp variable
                            // Reset key code variable
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