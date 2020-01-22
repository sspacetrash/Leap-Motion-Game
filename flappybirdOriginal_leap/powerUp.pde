class powerUp {
  int powerX, powerY;
  int powerHeight, powerWidth;
  int statHeight, statWidth;
  PImage p;

  powerUp() {
    powerHeight = 50;
    powerWidth = 50;
    randomize();
    statHeight = 70;
    statWidth = 70;
    powerCount = 2;
  }

  void randomize() {
    powerY = int(random((powerHeight + 40), height - 80));
    powerX = width;
  }

  void renew() {
    powerX = width;
    powerY = int(random(40, height-50));
    isCrashed = false;
  }

  void update() { 
    powerX -= 2;
    if (powerX+powerWidth<0) {
      renew();
    }
  }

  PVector[] statpos = new PVector[6];
  int statheight, statwidth;
  int powerCount, powerCurrent = 0;
  boolean isCrashed = false;
  int firstX = width/2 + 100;
  int firstY = 80;


  void statsetup() {
    powerCurrent = 1;

    for (int i = 0; i < 5; i++) {
      statpos[i] = new PVector();
      //statpos[i].x = statpos[i-1].x + 70;
      statpos[i].y = 1000;
      statpos[i].x = 1000;
    }
  }

  void statUpdate() {
    for (int i = 0; i < powerCount; i++) {
      statpos[i].x = firstX + (70 + (70*i));
      statpos[i].y = firstY;
    }
  }

  void isCollideP(Bird MyB) {
    float dis = dist(MyB.x, MyB.y, powerX, powerY);
    float overlap = dis - powerWidth/2 - MyB.birdWidth/2;

    if (overlap < 0 && isCrashed == false) {
      powerCount++;
      isCrashed = true;
    }

    //println("powerCount " + powerCount);
  }

  void display() {
    image(power, powerX, powerY, powerWidth, powerHeight);
  }

  void statDisplay() {

    if (powerCount !=0) {
      for (int a = 0; a < (powerCount); a++) {
        //println("statDisplay");
        image(power, statpos[a].x, statpos[a].y, statWidth, statHeight);
        //image(power, width/2, height/2, statWidth, statHeight);
      }
    }
  }
}
