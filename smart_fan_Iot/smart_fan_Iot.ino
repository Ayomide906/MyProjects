#include <WebServer.h>
#include <WiFi.h>

// ============= CONFIGURATION =============
const char* ssid = "IOT_Control";
const char* password = "YourPassword";
const int PWM_PIN = 32;        // MOSFET control pin
const int PWM_FREQ = 25000;    // 25kHz for silent operation
const int PWM_RESOLUTION = 8;  // 8-bit (0-255)

// Static IP configuration
// AP Mode IP Configuration
IPAddress staticIP(192, 168, 4, 1);  // ESP32's default AP IP
IPAddress subnet(255, 255, 255, 0);

WebServer server(80);

int currentLevel = 0;          // 0-3 speed levels
int pwmValue = 0;              // Mapped PWM value

// ============= WEB SERVER HANDLERS =============
String generateHTML() {
  return R"(
    <!DOCTYPE html>
    <html>
    <head>
      <title>Fan Control</title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
        body { font-family: Arial; text-align: center; margin-top: 50px; }
        .slider { width: 80%; margin: 20px; }
        .status { 
          color: white; padding: 15px; 
          border-radius: 8px; width: 300px; 
          margin: 20px auto;
          background: #4CAF50;
        }
      </style>
    </head>
    <body>
      <h1>Fan Speed Control</h1>
      <div class="status">Web Control Active</div>
      <input type="range" min="0" max="3" value="0" step="1"
             class="slider" id="speedSlider">
      <p>Current Level: <span id="speedValue">0</span></p>
      
      <script>
        const slider = document.getElementById('speedSlider');
        const speedValue = document.getElementById('speedValue');
        
        slider.oninput = function() {
          speedValue.textContent = this.value;
          fetch(`/setSpeed?value=${this.value}`);
        };
      </script>
    </body>
    </html>
  )";
}

int mapLevelToPWM(int level) {
  return map(level, 0, 3, 0, 255);
}

void handleSetSpeed() {
  if (server.hasArg("value")) {
    currentLevel = server.arg("value").toInt();
    pwmValue = mapLevelToPWM(currentLevel);
    ledcWrite(PWM_PIN, pwmValue);
  }
  server.send(200, "text/plain", "OK");
}

// ============= MAIN PROGRAM =============
void setup() {
  Serial.begin(115200);

  // Preserved original PWM configuration
  ledcAttach(PWM_PIN, PWM_FREQ, PWM_RESOLUTION);
  ledcWrite(PWM_PIN, mapLevelToPWM(currentLevel));

  // WiFi configuration with static IP
  // AP Mode Configuration (ESP32 as hotspot)  // Standard ESP32 AP IP
WiFi.softAPConfig(staticIP, staticIP, subnet);
WiFi.softAP(ssid, password);
Serial.println("Access Point Created");
Serial.print("SSID");
Serial.println(ssid);
Serial.print("Password: ");
Serial.println(password);
Serial.print("IP Address ");
Serial.println(WiFi.softAPIP());

  // Web Server Routes
  server.on("/", []() { server.send(200, "text/html", generateHTML()); });
  server.on("/setSpeed", handleSetSpeed);
  server.begin();
}

void loop() {
  server.handleClient();
}
