
/* Talks to the iPad Arduino project */

#define LENGTH 2

int rxBuffer[128]; 
int rxIndex  = 0;    

void setup() {
  //wdt_disable();
  Serial.begin(9600);
  Serial.println("Ardunio reset");
  
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  
  digitalWrite( 12, HIGH);
  digitalWrite( 13, HIGH);
  delay(500);
  digitalWrite( 12, LOW ); 
  digitalWrite( 13, LOW ); 
}

void loop (){
 //wdt_disable(); 
 
 if (Serial.available() > 0) {

   rxBuffer[rxIndex++] = Serial.read();
   if (rxIndex == LENGTH) {

     if ( rxBuffer[0] == 99 && rxBuffer[1] == 1 ) {
       Serial.println( "Resetting" );
       delay(30);
       //wdt_enable(WDTO_30MS);
     } else {  
     
       Serial.print( "Set: " );
       Serial.print( rxBuffer[0], DEC );
       Serial.print( " to: " );
       Serial.println( rxBuffer[1], DEC );

       if( rxBuffer[1] == 0 ) {
         digitalWrite((int)rxBuffer[0], LOW);
       } else {
         digitalWrite((int)rxBuffer[0], HIGH);
       }
       rxIndex = 0;
     }
   }
 }
 delay(10);

}

