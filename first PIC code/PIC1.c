unsigned int value;
unsigned int flag1 =0x00;

void main(){
 ADCON1 |= 0x0f;
 CMCON = 7;

 Trisa = 0x01;

 UART1_Init(9615);
 delay_ms(10);
 ADC_init();
 Trisb = 0x01;
 portb = 0x00;

 while(1){
  if (portb.b0 != 1)
   flag1 |= 0x02;
  else flag1 = flag1 & 0xFD;

  value = ADC_Read(0)*4.88;

  if(value>300)
   flag1 = flag1 | 0x01;
  else flag1 = flag1 & 0xFE;

  UART1_Write(flag1);

 }
 }