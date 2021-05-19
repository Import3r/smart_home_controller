unsigned int v=0;

void main() {
 UART1_Init(9615);
 Trisb = 0x00;
 portb=0x00;

 while(1){
  if(UART1_Data_Ready() == 1)
   portb = UART1_Read();
  else portb = portb;

  //Display Welcome and enter password (recieve from UART not necessary)

  //recieve from UART what to display (Wrong password or dashboard)

  //if wrong password GOTO begining of while loop

  //if dashboard and wants to change password


}
}