ArrayList<MenuButtons> buttons = new ArrayList<MenuButtons>();
ArrayList<PVector> cursors = new ArrayList<PVector>();



class MenuButtons {
  float x;
  float y;
  int w;
  int h;
  float timeout;
  int ID;
  PImage img;

  boolean inside;
  int startFrame;
  int showPress = 0;
  float secInside = -1;

  MenuButtons(float x, float y, int w, int h, float timeout, int ID, PImage img) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.timeout = timeout;
    this.ID = ID;
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
    img.resize(w, h);
    image(img, x, y);
    //rect(x, y, w, h);

    // show progress in red
    if (secInside > 0 && showPress <= 0) {
      fill(255, 0, 0, 60);
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
  int currentT;
  boolean isHovered = false;
  void update(ArrayList<PVector> cursors) {
    if (oneIsIn(cursors)) {
      if (inside  == true) {
        if (isHovered == false) {
          currentT = millis();


          isHovered = true;
          //rubyGreet.play();
        }
       // println("current time: " + millis());
        // println("current T: " + currentT);
        if ( currentT  < (millis() - 3000)) {
          //println("isHovered = false");
          isHovered= false;
        }

        if (isHovered == true) {
          //rubyGreet.play();
        }

        secInside = (float(frameCount - startFrame)) / frameRate;

        if (secInside > timeout) {
          startFrame = frameCount;
          selectID = ID;
          sceneCount = 3;
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
}
