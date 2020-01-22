class Pipe {
  int pipeWidth;
  int upperBound; //upper  pipe passable coordinate y
  int lowerBound; //lower pipe passable coordinate y
  int pipeX;//location x of the pipe
  int pipeGap;

  Pipe() {
    pipeWidth = 150;
    pipeGap = 900;
  }

  void update() { 
    pipeX -= 2;

    if (pipeX+pipeWidth<0) {
      renew();
    }
  }

  void renew() {
    pipeX = width;
    upperBound = int(random(-700, -200));
    lowerBound = upperBound+180;
  }

  void display() {
    stroke(0);
    fill(120, 90, 55);
    //rect(pipeX, -2, pipeWidth, upperBound);
    //rect(pipeX, lowerBound, pipeWidth, height);
    image(pipeDown, pipeX, upperBound);
    image(pipeUp, pipeX, upperBound + pipeGap);
  }
}
