#line 1 "P:/git_repos/smart_home_controller/Testing keypad and LCD/LCD_Keypad_MicroC_Proj.c"
unsigned short kp, cnt, oldstate = 0;
char txt[6];


char keypadPort at PORTD;



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
 cnt = 0;
 Keypad_Init();


 ADCON1 |= 0x0F;
 CMCON |= 7;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_FOURTH_ROW);




 Lcd_Out(1, 1, "1");
 Lcd_Out(2, 1, "2");
 Lcd_Out(1, 1+16, "3");
 Lcd_Out(2, 1+16, "4");

 while (1){
 kp = 0;


 do

 kp = Keypad_Key_Click();
 while (!kp);


 switch (kp) {
 case 1: kp = 49; break;
 case 2: kp = 50; break;
 case 3: kp = 51; break;

 case 5: kp = 52; break;
 case 6: kp = 53; break;
 case 7: kp = 54; break;

 case 9: kp = 55; break;
 case 10: kp = 56; break;
 case 11: kp = 57; break;

 case 13: kp = 42; break;
 case 14: kp = 48; break;
 case 15: kp = 35; break;

 default: kp += 48;
 }

 Lcd_Chr(1, 10, kp);
 }
}
