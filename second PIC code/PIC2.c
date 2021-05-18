unsigned int v=0;

void main() {
 UART1_Init(9615);
 Trisb = 0x00;
 portb=0x00;

 while(1){
  if(UART1_Data_Ready() == 1)
   portb = UART1_Read();
  else portb = portb;
   //delay_ms(100);
    //v= 0x03 & v;

}
}