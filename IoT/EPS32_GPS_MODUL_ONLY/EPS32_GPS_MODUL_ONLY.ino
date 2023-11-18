#include <TinyGPSPlus.h>

TinyGPSPlus gps;

double totalDistance = 0;
double lat1, lon1, lat2, lon2;
// Threshold untuk perubahan koordinat, diukur dalam meter
const double coordinateChangeThreshold = 10; // misalnya 10 meter
// Menambahkan buffer untuk menyimpan pembacaan GPS terakhir
const int numReadings = 5;
double latReadings[numReadings];
double lonReadings[numReadings];
int readIndex = 0;
void setup() {
  Serial.begin(115200);
  Serial2.begin(9600);
   // Inisialisasi buffer pembacaan
  for (int i = 0; i < numReadings; i++) {
    latReadings[i] = 0.0;
    lonReadings[i] = 0.0;
  }
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
double average(double readings[], int numReadings) {
    double total = 0;
    for (int i = 0; i < numReadings; i++) {
        total += readings[i];
    }
    return total / numReadings;
}
void displayInfo()
{
  Serial.print(F("Location: "));
  if (gps.location.isValid()){
    Serial.print(gps.location.lat(), 6);
    Serial.print(F(","));
    Serial.print(gps.location.lng(), 6);

     // Menyimpan pembacaan GPS terbaru ke dalam buffer
    latReadings[readIndex] = gps.location.lat();
    lonReadings[readIndex] = gps.location.lng();
    readIndex = (readIndex + 1) % numReadings;

    // Menghitung rata-rata dari pembacaan
    lat2 = average(latReadings, numReadings);
    lon2 = average(lonReadings, numReadings);


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