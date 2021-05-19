unsigned int value;
unsigned short int flag1 =0x00;    //flag byte to send to the other PIC to control outputs
unsigned short int flag2 = 0xFF;   //flag byte refering to the user control of sub-systems, initialized FF
                                   //as sub-systems are initially activated

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
  //door sensor
  if ((portb.b0 != 1) && (flag2.B0 == 1))
   flag1 |= 0x02;
  else flag1 = flag1 & 0xFD;

  //temperature sensor
  value = ADC_Read(0)*4.88;

  if ((value>300) && (flag2.B1 == 1))
   flag1 = flag1 | 0x01;
  else flag1 = flag1 & 0xFE;

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
  delay_ms(500);

  //send control byte to the other PIC to adjust outputs
  UART1_Write(flag1);

  //Display Welcome and enter password (use UART)

  //read password and compare it to EEPROM read value

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