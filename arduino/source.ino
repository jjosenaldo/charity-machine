#include <SPI.h>
#include <MFRC522.h>
#include <Servo.h>
#include <SoftwareSerial.h>

#define NUMBER_OF_SERVOS 2

#define SERVO_0_PIN 3 //PINO SERVO 0
#define SERVO_1_PIN 6 //PINO SERVO 1

#define RFID_SS_PIN 10 //PINO SDA RFID
#define RFID_RST_PIN 9 //PINO DE RESET RFID
#define TRIG_PIN 5     //PINO TRIG
#define ECHO_PIN 7     //PINO ECHO

#define CLOSED 180
#define OPEN 0 

#define SLOT_1 55
#define SLOT_2 165

#define RX_PIN 2 //PINO DIGITAL (RX)
#define TX_PIN 4 //PINO DIGITAL (TX)

SoftwareSerial bluetooth(RX_PIN, TX_PIN);
MFRC522 rfid(RFID_SS_PIN, RFID_RST_PIN);

enum STATE {
  IDLE,
  WAITING_SERVO_SELECTION,
  ROTATING_SERVO,
  WAITING_COLLECTION
};

int selected_degree = 0;
String current_user_rfid = "";

bool start_delivery_signal = false;
bool prev_motion_signal = false;
bool motion_signal = false;

STATE current_state = IDLE;

Servo servo_door;
Servo servo_selection;

void setup_bluetooth() {
  bluetooth.begin(9600);
}

void receive_bluetooth_message() {
  if(bluetooth.available()){
    selected_degree = bluetooth.read();
    Serial.print("DEGREE: ");
    Serial.println(selected_degree);
    start_delivery_signal = true;
  }
}

void setup_servo() {
  servo_door.attach(SERVO_0_PIN);
  servo_selection.attach(SERVO_1_PIN);
  servo_door.write(CLOSED);	
  move_servo(SLOT_1);	
  delay(2000);
  move_servo(SLOT_2);
  delay(2000);
  move_servo(SLOT_1);
  delay(2000);	
  servo_door.write(OPEN);	
  delay(2000);
  servo_door.write(CLOSED);	
  delay(2000);
}

void setup_rfid_reader() {
  SPI.begin(); //INICIALIZA O BARRAMENTO SPI
  rfid.PCD_Init(); //INICIALIZA MFRC522
}

void setup_motion_sensor() {
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  digitalWrite(TRIG_PIN, LOW);
}

void setup() {
  Serial.begin(9600); 
  setup_bluetooth();
  setup_servo();
  setup_rfid_reader();
  setup_motion_sensor();
}

void send_rfid_info() {
  Serial.println(current_user_rfid);
  String message = "a" + current_user_rfid + "$";
  bluetooth.write(message.c_str());
  current_state = WAITING_SERVO_SELECTION;
  // set_servo(0, OPEN);
  // set_servo(1, OPEN);
  // delay(1000);
  // set_servo(0, CLOSED);
  // set_servo(1, CLOSED);
}

void send_waiting_collection_message() {
  bluetooth.write("b$");
}

void send_machine_free_message() {
  bluetooth.write("c$");
}

bool hasCardToRead() {
  return rfid.PICC_IsNewCardPresent() && rfid.PICC_ReadCardSerial();
}

String readCardId() {
  String strID = "";
  for (byte i = 0; i < 4; i++) {
    strID +=
    (rfid.uid.uidByte[i] < 0x10 ? "0" : "") +
    String(rfid.uid.uidByte[i], HEX) +
    (i!=3 ? ":" : "");
  }
  strID.toUpperCase();

  rfid.PICC_HaltA(); //PARADA DA LEITURA DO CARTÃO
  rfid.PCD_StopCrypto1(); //PARADA DA CRIPTOGRAFIA NO PCD
  
  return strID;
}

void handle_rfid_signal()
{
  if (!hasCardToRead()) {
    return ;
  }
  current_user_rfid = readCardId();
  Serial.println(current_user_rfid);
  if (current_user_rfid != "" && current_state == IDLE) {
    send_rfid_info();
  }
  current_user_rfid = "";
}

bool receive_motion_signal()
{
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  float duration = pulseIn(ECHO_PIN, HIGH);
  float distance = duration * 0.034 / 2;
  return distance < 10;
}

void handle_sensors_data() {
  handle_rfid_signal();
  prev_motion_signal = motion_signal;
  motion_signal = receive_motion_signal();
  if (prev_motion_signal != motion_signal) {
    Serial.println(motion_signal);
  }
}

void move_servo(int degree) {
  int curr_degree = servo_selection.read();
  int dir = curr_degree > degree ? -1 : 1;
  for(int i = curr_degree; i != degree; i+=dir) {
      servo_selection.write(i);	
      delay(5);
  }
  Serial.print("degree ");	
  Serial.println(degree);
}

void loop() {
  receive_bluetooth_message();
  handle_sensors_data();
  
  if (start_delivery_signal) {
    if(current_state == WAITING_SERVO_SELECTION) {
      Serial.println("start servo");
      current_state = ROTATING_SERVO;
      move_servo(selected_degree);
      delay(2000);
      servo_door.write(OPEN);	
      delay(2000);
    }
    if(current_state == ROTATING_SERVO && motion_signal) {
      Serial.println("stop servo");
      current_state = WAITING_COLLECTION;
      servo_door.write(CLOSED);	
      send_waiting_collection_message();
    }
    if(current_state == WAITING_COLLECTION && !motion_signal) {
      Serial.println("free");
      current_state = IDLE;
      start_delivery_signal = false;
      send_machine_free_message();
    }
  }
}