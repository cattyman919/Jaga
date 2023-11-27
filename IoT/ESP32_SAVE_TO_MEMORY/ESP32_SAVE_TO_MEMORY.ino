#include <EEPROM.h>

// Ukuran EEPROM yang akan digunakan
const int EEPROM_SIZE = 512;

void setup() {
  Serial.begin(115200);

  // Inisialisasi EEPROM dengan ukuran yang ditentukan
  if (!EEPROM.begin(EEPROM_SIZE)) {
    Serial.println("Gagal menginisialisasi EEPROM");
    return;
  }

  Serial.println("Masukkan string untuk disimpan di EEPROM:");
}

void loop() {
  // Membaca kembali string dari EEPROM
    Serial.print("String yang disimpan: ");
    for (int i = 0; i < EEPROM_SIZE; ++i) {
      char c = EEPROM.read(i);
      if (c == '\0') break;
      Serial.print(c);
    }
    Serial.println();
  // Menunggu input dari Serial Monitor
  if (Serial.available()) {
    // Membaca string dari Serial Monitor
    String inputString = Serial.readStringUntil('\n');
    
    // Menyimpan string ke EEPROM
    for (int i = 0; i < inputString.length(); ++i) {
      EEPROM.write(i, inputString[i]);
    }

    // Menandai akhir string dengan karakter null
    EEPROM.write(inputString.length(), '\0');

    // Menyimpan perubahan ke EEPROM
    if (EEPROM.commit()) {
      Serial.println("String berhasil disimpan di EEPROM");
    } else {
      Serial.println("Gagal menyimpan string ke EEPROM");
    }

    // Membaca kembali string dari EEPROM
    Serial.print("String yang disimpan: ");
    for (int i = 0; i < EEPROM_SIZE; ++i) {
      char c = EEPROM.read(i);
      if (c == '\0') break;
      Serial.print(c);
    }
    Serial.println();

    // Menunggu input string berikutnya
    Serial.println("\nMasukkan string lain untuk disimpan di EEPROM:");
  }
}
