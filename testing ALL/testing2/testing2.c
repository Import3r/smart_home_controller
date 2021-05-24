unsigned short int dashboard_flag = 0;

// LCD module connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End LCD module connections

void main() {
 UART1_Init(9615);
 TRISD = 0x00;
 portd=0x00;
 
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);                     // Clear display
  Lcd_Cmd(_LCD_FOURTH_ROW);
  Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off

  // =========================

 // Lcd_Out(1, 1, "1");
 // Lcd_Out(2, 1, "2");
 // Lcd_Out(1, 1+16, "3");
 // Lcd_Out(2, 1+16, "4");
  
  ADCON1 |= 0x0F;
  CMCON |= 7;
 
 while(1){

 if(UART1_Data_Ready() == 1){
    PORTD = UART1_Read();
    if(!portd.B7)
         Lcd_Out(1, 1, "Enter password: ");
    else if(!dashboard_flag) {
         Lcd_Cmd(_LCD_CLEAR);                     // Clear display
         Lcd_Out(1, 1, "Welcome :) ");
         delay_ms(1000);
         Lcd_Cmd(_LCD_CLEAR);                     // Clear display
         dashboard_flag = 1;}
    else{
         Lcd_Out(1, 1, "1.DOOR: ");
         Lcd_Out(2, 1, "2.GARAGE: ");
         Lcd_Out(1, 1+16, "3.GARDEN: ");
         Lcd_Out(2, 1+16, "4.COOLING: ");
         
         if(portd.B0) Lcd_Out(1, 9, "ON ");
         else Lcd_Out(1, 9, "OFF");

         if(portd.B1) Lcd_Out(2, 11, "ON ");
         else Lcd_Out(2, 11, "OFF");
         
         if(portd.B2) Lcd_Out(1, 11+16, "ON ");
         else Lcd_Out(1, 11+16, "OFF");
         
         if(portd.B3) Lcd_Out(2, 12+16, "ON ");
         else Lcd_Out(2, 12+16, "OFF");

    }
    //if(PORTD || 0b)
    /*Lcd_Chr(1, 9, PORTD.B0+48);
    Lcd_Chr(1, 8, PORTD.B1+48);
    Lcd_Chr(1, 7, PORTD.B2+48);
    Lcd_Chr(1, 6, PORTD.B3+48);
    Lcd_Chr(1, 5, PORTD.B4+48);
    Lcd_Chr(1, 4, PORTD.B5+48);
    Lcd_Chr(1, 3, PORTD.B6+48);
    Lcd_Chr(1, 2, PORTD.B7+48); */
   }
 //else PORTD = PORTD;
 //Lcd_Out(1, 3, "Hello!");
}
}