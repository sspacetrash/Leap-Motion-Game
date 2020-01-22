ArrayList<instruct> instructButtons = new ArrayList<instruct>();


class instruct {
  float screenX, screenY, screenWidth, screenHeight;
  int counter;
  int x;
  int y;
  int w;
  int h;
  float timeout;
  int instruct;
  PImage img;

  boolean inside;
  int startFrame;
  int showPress = 0;
  float secInside = -1;

  instruct(int x, int y, int w, int h, float timeout, int instruct, PImage img) {
    screenX = width/2;
    screenY = height/2;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.timeout = timeout;
    this.instruct = instruct;
    this.img = img;
  }

  void render() {

    // white after pressed
    if (showPress > 0) {
      fill(255);
      showPress--;
    } else {
      fill(100);
    }
    noStroke();
    img.resize(w-20, h-20);
    image(img, x, y);
    //rect(x, y, w, h);

    // show progress in red
    if (secInside > 0 && showPress <= 0) {
      fill(255, 0, 0);
      rect(x, y, secInside/timeout * w, h);
    }

    fill(255);
    textAlign(CENTER);
    textSize(30);
    //text(""+timeout, x + w/2, y + h/2 + 15);
  }

  boolean oneIsIn(ArrayList<PVector> points) {
    for (PVector v : points) {
      if (v.x >= x && v.x <= x + w && v.y >= y && v.y <= y + h) {
        return true;
      }
    }
    return false;
  }

  void update(ArrayList<PVector> cursors) {
    if (oneIsIn(cursors)) {
      if (inside  == true) {
        secInside = (float(frameCount - startFrame)) / frameRate;

        if (secInside > timeout) {
          startFrame = frameCount;
          sceneCount = instruct;
          pressed();
        }
      } else {
        inside = true;
        startFrame = frameCount;
      }
    } else {
      inside = false;
      secInside = -1;
    }
  }

  void pressed() {
    showPress = 10;
    secInside = -1;
  }

  void displayScoreboard() {

    fill(255, 165, 0);
    noStroke();
    ellipse(screenX, screenY, screenWidth, screenHeight); 
    /*
    if (screenWidth < 400){
     screenWidth +=5;
     screenHeight +=5;
     }
     */
    textSize(100);
    fill(255, 255, 255);
    text(("Score: " + myScore.mainScore), width/2, height/2);
  }
}
