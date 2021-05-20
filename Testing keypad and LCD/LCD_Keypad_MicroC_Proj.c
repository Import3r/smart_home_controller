unsigned short kp, cnt, oldstate = 0;
char txt[6];

// Keypad module connections
char  keypadPort at PORTD;
// End Keypad module connections

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
  cnt = 0;                                 // Reset counter
  Keypad_Init();                           // Initialize Keypad

  // LCD preparations ========
  ADCON1 |= 0x0F;                             // Configure AN pins as digital I/O
  CMCON  |= 7;                      // Disable comparators
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);                     // Clear display
  Lcd_Cmd(_LCD_FOURTH_ROW);
  //Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
  
  // =========================

  Lcd_Out(1, 1, "1");
  Lcd_Out(2, 1, "2");
  Lcd_Out(1, 1+16, "3");
  Lcd_Out(2, 1+16, "4");

  while (1){
    kp = 0;                                // Reset key code variable

    // Wait for key to be pressed and released
    do
      // kp = Keypad_Key_Press();          // Store key code in kp variable
      kp = Keypad_Key_Click();             // Store key code in kp variable
    while (!kp);
   // Prepare value for output, transform key to it's ASCII value

    switch (kp) {
      case  1: kp = 49; break; // 1
      case  2: kp = 50; break; // 2
      case  3: kp = 51; break; // 3
      
      case  5: kp = 52; break; // 4
      case  6: kp = 53; break; // 5
      case  7: kp = 54; break; // 6
      
      case  9: kp = 55; break; // 7
      case 10: kp = 56; break;  // 8
      case 11: kp = 57; break;  // 9
      
      case 13: kp = 42; break;  // '*'
      case 14: kp = 48; break;  // 0
      case 15: kp = 35; break;  // '#'
      
      default: kp += 48;
    }

    Lcd_Chr(1, 10, kp);                    // Print key ASCII value on LCD
  }
}