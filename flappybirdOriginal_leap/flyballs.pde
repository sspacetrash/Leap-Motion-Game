class flyballs {
  int birdsize;
  float ballsize = 20;
  float x, y;
  float xspeed, yspeed;

  flyballs(float xloc, float yloc, float _xspeed, float _yspeed, float _radius) { 
    x = xloc;
    y = yloc;
    xspeed = _xspeed;
    yspeed = _yspeed;
    ballsize = _radius;
  }




  void updateLocation() {
    //update both x and y location
    x = x + xspeed;
    y = y + yspeed;
    //the ball bounces back when it reaches the edge of the window 
    if ((x > width) || (x < 0)) {
      xspeed = xspeed * -1;
    }
    if ((y > height) || (y < 0)) { 
      yspeed = yspeed * -1;
    }
  }

  void display() { 
    stroke(0, 50);
    ellipse(x, y, ballsize, ballsize);
  }

  void isCollideB(flybird MyF) {
    if ((MyF.birdposX + MyF.birdWidth > x) && (MyF.birdposX < x + ballsize) && (MyF.birdposX + MyF.birdWidth > y) && (MyF.birdposY < y + ballsize)) {
      sceneCount = 9;
      //xspeed = xspeed * -1;
      //yspeed = yspeed * -1;
      myScore.flyScore();
    }
    
  }
}
