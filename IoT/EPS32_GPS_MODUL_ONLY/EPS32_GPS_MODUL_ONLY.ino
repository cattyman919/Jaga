#include <TinyGPSPlus.h>

TinyGPSPlus gps;

double totalDistance = 0;
double lat1, lon1, lat2, lon2;
// Threshold untuk perubahan koordinat, diukur dalam meter
const double coordinateChangeThreshold = 10; // misalnya 10 meter
void setup() {
  Serial.begin(115200);
  Serial2.begin(9600);
  Serial.println("nyala");
  delay(3000);
}

void updateSerial(){
  delay(500);
  while (Serial.available())  {
    Serial2.write(Serial.read());//Forward what Serial received to Software Serial Port
  }
  while (Serial2.available())  {
    Serial.write(Serial2.read());//Forward what Software Serial received to Serial Port
  }
}

void displayInfo()
{
  Serial.print(F("Location: "));
  if (gps.location.isValid()){
    Serial.print(gps.location.lat(), 6);
    Serial.print(F(","));
    Serial.print(gps.location.lng(), 6);

    lat2 = gps.location.lat();
    lon2 = gps.location.lng();

    if (lat1 != 0 && lon1 != 0) {
            double distanceBetweenPoints = TinyGPSPlus::distanceBetween(lat1, lon1, lat2, lon2);
          Serial.print(" distance : ");
          Serial.print(distanceBetweenPoints);
          // Periksa apakah perubahan koordinat melebihi threshold
          if (distanceBetweenPoints >= coordinateChangeThreshold) {
            totalDistance += distanceBetweenPoints;
          }
            lat1 = lat2;
        lon1 = lon2;
    }else {
          // First time reading
          lat1 = lat2;
          lon1 = lon2;
    }
      Serial.print(" Distance traveled (meters): ");
            Serial.println(totalDistance);
  }else{
    Serial.println(F("INVALID"));
  }
  delay(1000); // waits for a second
}

void loop() {
  //updateSerial();
  while (Serial2.available() > 0){
        if (gps.encode(Serial2.read())){
                displayInfo();
        }
          
  }
  if (millis() > 5000 && gps.charsProcessed() < 10)
  {
    Serial.println(F("No GPS detected: check wiring."));
    while (true);
  }
}