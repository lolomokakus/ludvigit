#define PIN_CLOCK 22
#define PIN_LATCH 11
#define PIN_DATA 12

#define BUTTON_A 1
#define BUTTON_B 2
#define BUTTON_X 3
#define BUTTON_Y 4
#define BUTTON_L 5
#define BUTTON_R 6
#define BUTTON_SELECT 7
#define BUTTON_START 8

bool current_buttons[12];
bool previous_buttons[12] = {false, false, false, false, false, false, false, false, false, false, false, false};
static const int buttons[12] = {BUTTON_B, BUTTON_Y, BUTTON_SELECT, BUTTON_START, 0, 0, 0, 0, BUTTON_A, BUTTON_X, BUTTON_L, BUTTON_R};

bool button_read() {
  const bool b = (digitalRead(PIN_DATA) == LOW);
  digitalWrite(PIN_CLOCK, LOW);
  digitalWrite(PIN_CLOCK, HIGH);
  return b;
}

int hat_angle() {
  if(!current_buttons[4] && current_buttons[5] && current_buttons[6] && current_buttons[7]) {
    return 180;
  } else if(current_buttons[4] && !current_buttons[5] && current_buttons[6] && current_buttons[7]) {
    return 0;
  } else if(current_buttons[4] && current_buttons[5] && !current_buttons[6] && current_buttons[7]) {
    return 90;
  } else if(current_buttons[4] && current_buttons[5] && current_buttons[6] && !current_buttons[7]) {
    return 270;
  } else if(!current_buttons[4] && current_buttons[5] && !current_buttons[6] && current_buttons[7]) {
    return 135;
  } else if(!current_buttons[4] && current_buttons[5] && current_buttons[6] && !current_buttons[7]) {
    return 225;
  } else if(current_buttons[4] && !current_buttons[5] && !current_buttons[6] && current_buttons[7]) {
    return 45;
  } else if(current_buttons[4] && !current_buttons[5] && current_buttons[6] && !current_buttons[7]) {
    return 315;
  } else if(!current_buttons[4] && !current_buttons[5] && !current_buttons[6] && current_buttons[7]) {
    return 90;
  } else if(!current_buttons[4] && !current_buttons[5] && current_buttons[6] && !current_buttons[7]) {
    return 270;
  } else if(!current_buttons[4] && current_buttons[5] && !current_buttons[6] && !current_buttons[7]) {
    return 180;
  } else if(current_buttons[4] && !current_buttons[5] && !current_buttons[6] && !current_buttons[7]) {
    return 0;
  } else {
    return -1;
  }
}

void setup() {
  pinMode(PIN_CLOCK, OUTPUT);
  pinMode(PIN_LATCH, OUTPUT);
  pinMode(PIN_DATA, INPUT);
  digitalWrite(PIN_CLOCK, HIGH);
  digitalWrite(PIN_LATCH, HIGH);
  digitalWrite(PIN_DATA, HIGH);
}

void loop() {
  digitalWrite(PIN_LATCH, LOW);
  for(int b = 0; b < 12; b++) {
    current_buttons[b] = button_read();
  }
  digitalWrite(PIN_LATCH, HIGH);
  if(!(current_buttons[4] == previous_buttons[4] && current_buttons[5] == previous_buttons[5] && current_buttons[6] == previous_buttons[6] && current_buttons[7] == previous_buttons[7])) {
    Joystick.hat(hat_angle());
  }
  for(int b = 0; b < 12; b++) {
    if(b >= 4 && b <= 7) {
      continue;
    }
    if(current_buttons[b] != previous_buttons[b]) {
      if(current_buttons[b]) {
        Joystick.button(buttons[b], 1);
      } else {
        Joystick.button(buttons[b], 0);
      }
    }
  }
  for(int b = 0; b < 12; b++) {
    previous_buttons[b] = current_buttons[b];
  }
  delay(5);
}
