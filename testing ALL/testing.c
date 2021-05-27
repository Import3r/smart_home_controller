unsigned int value;
unsigned int value2;
unsigned short int flag1 =0x00;    // a trasmitted flag that will constantly be sent to the second controller
unsigned short int flag2 = 0xFF;   // a local flag referring to the states of all the sub-systems, syncs with flag1
unsigned short kp = 0;
unsigned short input_digit;
char input_pass[4];
int correct_pass_flag[4];
unsigned short int pass_counter = 0;

char  keypadPort at PORTD;

void main(){
    // Store password in EEPROM
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

    Keypad_Init();                           // Initialize Keypad

    while(1){
        UART1_Write(flag1);
        delay_ms(100);
        
        /// door sensor
        if ((portb.b0 == 1) && (flag2.B0 == 1)) flag1.B0 = 1;  // Turn buzzer ON/OFF depending on door sensor
        else flag1.B0 = 0;

        // PIR (HAMZA)
        if ((portb.b0 == 1) && (flag2.B1 == 1)) flag1.B1 = 1;  // Turn Light ON/OFF depending on PIR sensor
        else flag1.B1 = 0;

        // temperature sensor
        ADCON0 = 0b00001001;
        value2 = ADC_Read(1)*4.88;
        if ((value2>300) && (flag2.B2 == 1)) flag1.B2 = 1;  // Turn Fan ON/OFF depending on temp sensor
        else flag1.B2 = 0;

        // moisture (Hamza)
        delay_ms(10);
        value = ADC_Read(0)*4.88;
        if ((value>300) && (flag2.B3 == 1)) flag1.B3 = 1;  // Turn water pump ON/OFF depending on moisture sensor
        else flag1.B3 = 0;

        // send control flag1 to the other PIC to adjust outputs and LCD readings
        //
        flag1.B5 = 0;  // a flag to track incorrect passwords

        if (!flag1.B7){  // when not authenticated:
            if(pass_counter < 4){  // when password not complete yet
                input_digit = Keypad_Key_Click();
                if(input_digit){  // Turn input digit to ASCII
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
                    // Check it the entered digit is correct
                    if(EEPROM_read(0x32 + pass_counter) == input_digit) correct_pass_flag[pass_counter] = 1;
                    else correct_pass_flag[pass_counter] = 0;

                    pass_counter++;
                }
            }
            else{  // password input complete
                pass_counter = 0;

                // Set control flag to indicate "correct pass" if all digits are correct
                if(correct_pass_flag[0] & correct_pass_flag[1] &
                correct_pass_flag[2] & correct_pass_flag[3]) flag1.B7 = 1;

                else{  // if password is complete and wrong, set control flag bits to indicate it
                    flag1.B7 = 0;
                    flag1.B6 = 0;
                    flag1.B5 = 1;
                    flag1.B4 = 0;
                }
            }
        }
        else{  // when authenticated:
            kp = 0;
            kp = Keypad_Key_Click();

            switch (kp) {  // Toggle a system ON/OFF depending on key press
                case  1: flag2.B0 = ~flag2.B0; break; // 1
                case  2: flag2.B1 = ~flag2.B1; break;// 2
                case  3: flag2.B2 = ~flag2.B2; break;// 3
                case  5: flag2.B3 = ~flag2.B3; break;// 4
                case 15: {flag2 = 0xFF;
                         pass_counter = 0;
                         flag1 = 0x00;
                         break;}// lock
            }
        }
    }
}