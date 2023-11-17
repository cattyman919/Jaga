#include <WiFi.h>

#define TIMER_PERIOD pdMS_TO_TICKS(6000)  // 10 minutes

// WiFi credentials
const char* ssid = "Wipi";
const char* password = "yjho8080";

// Function to connect to WiFi
void connectToWiFi() {
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Establishing connection to WiFi..");
  }

  Serial.println("Connected to WiFi");
}

// Timer callback function
void TimerCallback(TimerHandle_t xTimer) {
    Serial.println("Timer Callback Function Executed on Core 1");
    // Your function execution code here
    Serial.println("Sent Data,");
}

// Task that will run on core 1
void TaskOnCore1(void * parameter) {

  // Create a periodic timer
    TimerHandle_t timer = xTimerCreate("MyTimer", TIMER_PERIOD, pdTRUE, (void *)0, TimerCallback);

    if (timer != NULL) {
        // Start the timer
        xTimerStart(timer, 0);
    }

    // Loop forever
    for (;;) {

        // Check WiFi connection
        if (WiFi.status() != WL_CONNECTED) {
          Serial.println("WiFi connection lost. Reconnecting...");
          connectToWiFi(); // Attempt to reconnect
        }

        // The task does nothing else but could be extended for other functionalities
        vTaskDelay(pdMS_TO_TICKS(1000)); // Just to prevent watchdog timer reset
    }
}

void setup() {
  Serial.begin(115200);
  
  // Connect to WiFi
  connectToWiFi();

  // Create a task that runs on core 1
  xTaskCreatePinnedToCore(
    TaskOnCore1,   /* Task function */
    "TaskOnCore1", /* Name of the task */
    10000,         /* Stack size of task */
    NULL,          /* Parameter of the task */
    1,             /* Priority of the task */
    NULL,          /* Task handle to keep track of created task */
    1);            /* Core where the task should run */
}

void loop() {
  // Empty loop
}
