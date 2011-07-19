
/* Talks to the iPad Arduino project */

#define LENGTH 2

int rxBuffer[128]; 
int rxIndex  = 0;    

boolean serialMessages = false;

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
     
     int port = (int)rxBuffer[0];
     int val = (int)rxBuffer[1];

     if ( port == 99 && val == 1 ) {
       if(serialMessages) Serial.println( "Resetting" );
       delay(30);
       //wdt_enable(WDTO_30MS);
     } else {  
     
       if(serialMessages) {
         Serial.print( "Set: " );
         Serial.print( rxBuffer[0], DEC );
         Serial.print( " to: " );
         Serial.println( rxBuffer[1], DEC );
       }
      
      if( port == 3 || port == 5 || port == 6 || port == 9 || port == 10 || port == 11 ) {
        analogWrite(port, val);
      } else {
      
       if(val == 0 ) {
         digitalWrite(port, LOW);
       } else {
         digitalWrite(port, HIGH);
       }
       
      }
       
       rxIndex = 0;
     }
   }
 }
 delay(10);

}

