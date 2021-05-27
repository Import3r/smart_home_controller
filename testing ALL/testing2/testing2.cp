#line 1 "D:/University/Embedded Systems/Project/smart_home_controller/testing ALL/testing2/testing2.c"
unsigned short int dashboard_flag = 0;


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


void main() {
 UART1_Init(9615);
 TRISD = 0x00;
 portd=0x00;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 ADCON1 |= 0x0F;
 CMCON |= 7;

 while(1){
 if(UART1_Data_Ready() == 1){
 PORTD = UART1_Read();

 if(PORTD == 0x00){ dashboard_flag = 0;
 Lcd_Cmd(_LCD_CLEAR);
 }
 if(portd.B7 == 0 & portd.B6 == 0&
 portd.B5 == 1 & portd.B4 == 0){
 Lcd_Out(1, 1, "WRONG PASSWORD!! ");
 delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
 }
 else if(!portd.B7){

 Lcd_Out(1, 1, "ENTER PASSWORD: ");
 }
 else if(!dashboard_flag) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Welcome :) ");
 delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
 dashboard_flag = 1;
 }
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
 }
 }
}
