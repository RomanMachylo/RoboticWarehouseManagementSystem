/*
 * Arduino Uno + ESP8266 ESP-01S Sensor Client for Business Central
 * Reads sensors and sends data to BC API via Wi-Fi
 */

#include <SoftwareSerial.h>

// ESP8266 pins (RX, TX)
SoftwareSerial esp8266(2, 3);

// Configuration
const char* WIFI_SSID = "YourWiFiSSID";
const char* WIFI_PASSWORD = "YourWiFiPassword";
const char* BC_HOST = "your-bc-server.com";
const int BC_PORT = 443;  // Use 80 for HTTP, 443 for HTTPS
const char* BC_API_PATH = "/BC190/api/v2.0/companies(your-company-id)/sensorDataAPI";
const char* BC_AUTH = "Basic base64encodedusername:password";  // Replace with your encoded credentials
const char* SENSOR_ID = "ARD-001";
const char* WAREHOUSE_CODE = "WH01";

// Sensor pins
const int TEMP_SENSOR_PIN = A0;      // Temperature sensor (e.g., TMP36)
const int HUMIDITY_SENSOR_PIN = A1;   // Humidity sensor (e.g., DHT11 analog output)
const int SMOKE_SENSOR_PIN = A2;      // Smoke/Gas sensor (e.g., MQ-2)
const int MOTION_SENSOR_PIN = 4;      // Motion sensor (PIR)
const int DOOR_SENSOR_PIN = 5;        // Door sensor (Reed switch)

// Timing
unsigned long lastSendTime = 0;
const unsigned long SEND_INTERVAL = 60000;  // Send every 60 seconds

void setup() {
  Serial.begin(9600);
  esp8266.begin(115200);
  
  // Initialize sensor pins
  pinMode(MOTION_SENSOR_PIN, INPUT);
  pinMode(DOOR_SENSOR_PIN, INPUT);
  
  Serial.println("Initializing...");
  delay(2000);
  
  // Initialize ESP8266 and connect to WiFi
  initializeAndConnect();
}

void loop() {
  if (millis() - lastSendTime >= SEND_INTERVAL) {
    sendSensorDataToBC();
    lastSendTime = millis();
  }
  delay(100);
}

void sendSensorDataToBC() {
  Serial.println("\n=== Reading Sensors and Sending to BC ===");
  
  // Read all sensors
  float temperature = readTemperature();
  float humidity = readHumidity();
  float smokeLevel = readSmokeLevel();
  int motionDetected = digitalRead(MOTION_SENSOR_PIN);
  int doorOpen = digitalRead(DOOR_SENSOR_PIN);
  
  Serial.print("Temperature: "); Serial.print(temperature); Serial.println(" C");
  Serial.print("Humidity: "); Serial.print(humidity); Serial.println(" %");
  Serial.print("Smoke: "); Serial.print(smokeLevel); Serial.println(" ppm");
  Serial.print("Motion: "); Serial.println(motionDetected ? "Detected" : "None");
  Serial.print("Door: "); Serial.println(doorOpen ? "Open" : "Closed");
  
  // Send Temperature
  sendSingleSensorData("Temperature", temperature, "°C");
  delay(2000);
  
  // Send Humidity
  sendSingleSensorData("Humidity", humidity, "%");
  delay(2000);
  
  // Send Smoke
  sendSingleSensorData("Smoke", smokeLevel, "ppm");
  delay(2000);
  
  // Send Motion
  sendSingleSensorData("Motion", motionDetected, "bool");
  delay(2000);
  
  // Send Door Status
  sendSingleSensorData("Door Status", doorOpen, "bool");
  delay(2000);
  
  Serial.println("=== Data transmission complete ===\n");
}

void sendSingleSensorData(const char* sensorType, float value, const char* unit) {
  // Build JSON payload
  String jsonPayload = "{";
  jsonPayload += "\"sensorId\":\"" + String(SENSOR_ID) + "\",";
  jsonPayload += "\"warehouseCode\":\"" + String(WAREHOUSE_CODE) + "\",";
  jsonPayload += "\"sensorType\":\"" + String(sensorType) + "\",";
  jsonPayload += "\"value\":" + String(value, 2) + ",";
  jsonPayload += "\"unitOfMeasure\":\"" + String(unit) + "\",";
  jsonPayload += "\"readingDateTime\":\"" + getCurrentDateTime() + "\"";
  jsonPayload += "}";
  
  int contentLength = jsonPayload.length();
  
  Serial.print("Sending "); Serial.print(sensorType); Serial.print(": ");
  
  // Start TCP connection
  esp8266.println("AT+CIPSTART=\"TCP\",\"" + String(BC_HOST) + "\"," + String(BC_PORT));
  delay(2000);
  
  if (esp8266.find("OK")) {
    Serial.println("Connection established");
    
    // Prepare HTTP request
    String httpRequest = "POST " + String(BC_API_PATH) + " HTTP/1.1\r\n";
    httpRequest += "Host: " + String(BC_HOST) + "\r\n";
    httpRequest += "Authorization: " + String(BC_AUTH) + "\r\n";
    httpRequest += "Content-Type: application/json\r\n";
    httpRequest += "Content-Length: " + String(contentLength) + "\r\n";
    httpRequest += "Connection: close\r\n\r\n";
    httpRequest += jsonPayload;
    
    // Send data length
    esp8266.print("AT+CIPSEND=");
    esp8266.println(httpRequest.length());
    delay(1000);
    
    if (esp8266.find(">")) {
      // Send HTTP request
      esp8266.print(httpRequest);
      delay(2000);
      
      // Read response
      unsigned long timeout = millis();
      while (millis() - timeout < 5000) {
        while (esp8266.available()) {
          char c = esp8266.read();
          Serial.write(c);
        }
      }
      Serial.println("\nResponse received");
    } else {
      Serial.println("Failed to send data");
    }
    
    // Close connection
    esp8266.println("AT+CIPCLOSE");
    delay(1000);
  } else {
    Serial.println("Connection failed");
  }
}

void initializeAndConnect() {
  Serial.println("Configuring ESP8266...");
  
  // Reset ESP8266
  sendATCommand("AT+RST", 5000);
  delay(2000);
  
  // Set to station mode
  sendATCommand("AT+CWMODE=1", 2000);
  
  // Connect to WiFi
  String connectCmd = "AT+CWJAP=\"" + String(WIFI_SSID) + "\",\"" + String(WIFI_PASSWORD) + "\"";
  Serial.println("Connecting to WiFi...");
  sendATCommand(connectCmd.c_str(), 10000);
  
  // Check connection
  sendATCommand("AT+CIFSR", 2000);
  
  // Set single connection mode
  sendATCommand("AT+CIPMUX=0", 2000);
  
  Serial.println("ESP8266 ready!");
}

void sendATCommand(const char* command, int timeout) {
  esp8266.println(command);
  long int time = millis();
  
  Serial.print("Sending: ");
  Serial.println(command);
  
  while ((time + timeout) > millis()) {
    while (esp8266.available()) {
      char c = esp8266.read();
      Serial.write(c);
    }
  }
}

float readTemperature() {
  // TMP36 sensor: 10mV/°C, 500mV at 0°C
  int reading = analogRead(TEMP_SENSOR_PIN);
  float voltage = reading * (5.0 / 1024.0);
  float temperatureC = (voltage - 0.5) * 100.0;
  return temperatureC;
}

float readHumidity() {
  // Simple analog humidity sensor (0-100%)
  int reading = analogRead(HUMIDITY_SENSOR_PIN);
  float humidity = (reading / 1024.0) * 100.0;
  return humidity;
}

float readSmokeLevel() {
  // MQ-2 sensor analog reading (convert to ppm approximation)
  int reading = analogRead(SMOKE_SENSOR_PIN);
  float smokePPM = reading * (5000.0 / 1024.0);  // Rough conversion
  return smokePPM;
}

String getCurrentDateTime() {
  // For simplicity, return current millis as timestamp
  // In production, use RTC module for accurate time
  unsigned long currentMillis = millis();
  return "2025-12-05T" + formatTime(currentMillis);
}

String formatTime(unsigned long ms) {
  unsigned long seconds = ms / 1000;
  unsigned long minutes = seconds / 60;
  unsigned long hours = minutes / 60;
  
  hours = hours % 24;
  minutes = minutes % 60;
  seconds = seconds % 60;
  
  String time = "";
  if (hours < 10) time += "0";
  time += String(hours) + ":";
  if (minutes < 10) time += "0";
  time += String(minutes) + ":";
  if (seconds < 10) time += "0";
  time += String(seconds);
  
  return time;
}
