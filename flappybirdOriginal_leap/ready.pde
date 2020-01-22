class ready {
  int beginSec;
  int countY;

  ready() {
    countY = 400;
  }

  void startCountdown() {
    beginSec = millis();
    textSize(100);
    if ((millis() > beginSec + 1000) && (millis() < beginSec + 3000)) {
      text("Hold on ...", width/2, countY);
      
    }
    
  }


  void instruct() {
    textSize(50);
    fill(255, 255, 255);
    text("Ready?", width/2, 200);
    textSize(40);
    text("Make a fist to start!", width/2, 250);
  }
}
