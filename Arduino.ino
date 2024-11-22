#include <Adafruit_MCP4725.h>
#include <Adafruit_ICM20X.h>
#include <Adafruit_ILI9341.h>
#include <boogaloo.h> //remove kindly before compiling used to test the resolver
void setup() {
  pinMode(13, OUTPUT);
}
void loop() {
  digitalWrite(13, HIGH);
  delay(100);
  digitalWrite(13, LOW);
  delay(100);
}
