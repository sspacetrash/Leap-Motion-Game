
boolean isTapped, isCircled, isBoosted;
int begining = 0;

class Bird {
  int x, y;
  int birdWidth, birdHeight;
  float speed;
  float acceleration;


  Bird() {
    x = width/4;
    y = height/2;
    birdWidth = 80;
    birdHeight = 60;
    speed = 0;
  }

  void isCollide(Pipe myP) {
    if (x + birdWidth-10 + speed > myP.pipeX && 
      x + speed < myP.pipeX + myP.pipeWidth-10 && 
      y + birdHeight-10 > myP.upperBound && 
      y < myP.upperBound + pipeUp.height) {
      println("crash top x");
      sceneCount = 7;
    }

    if (x + birdWidth + speed > myP.pipeX && 
      x + speed < myP.pipeX + myP.pipeWidth-10 && 
      y + birdHeight-5 > myP.upperBound + myP.pipeGap && 
      y < myP.upperBound + myP.pipeGap + pipeUp.height) {
      println("crash bottom x");
      /*
      switch (selectID) {
      case 1: 
        //println("BlueJ Selected");
        blueJHit.play();
        break;

      case 2: 
        //println("python Selected");
        pythonHit.play();
        break;

      case 3: 
        //println("ruby Selected");
        rubyHit.play();
        break;

      default: 
        rubyHit.play();
        break;
      }
      */
      
      sceneCount = 7;
    }
  }
  int boostT;

  void control() {
    /*
    if (begining == 0) {
      isCircled = true;
      begining++;
    }
    */


    acceleration = 0.1;
    speed = speed + acceleration;

    //move bird up
    if (isTapped == true) {
      if (y>5) 
        speed = -4;
      isTapped = false;
    }

    if (isCircled == true) { //ASCII for jump
      if (myPower.powerCount != 0 && isRead != true) {
        if (y>5) 
          speed = -6;
        println("boosted");

        isBoosted = true;
        println("isBoosted");

        myPower.powerCount--;

        isCircled = false;
      }
    }


    //dropping at a speed
    y += speed;

    if ( y  > height) {
      sceneCount = 7;
      y = height;
    }
  }



  void display() {

    pushMatrix();
    translate(x, y);

    if (isCircled == true) {
      switch (selectID) {
      case 1: 
        //println("BlueJ Selected");
        image(bluej, 0, 0, birdWidth, birdHeight);
        break;

      case 2: 
        //println("python Selected");
        image(python, 0, 0, birdWidth, birdHeight);
        break;

      case 3: 
        //println("ruby Selected");
        image(ruby, 0, 0, birdWidth, birdHeight);
        break;

      default: 
        println("error");
        break;
      }
    }

    if (isCircled == false) {
      switch (selectID) {
      case 1: 
        //println("BlueJ Selected");
        image(bluej_boost, 0, 0, birdWidth+20, birdHeight+20);
        break;

      case 2: 
        //println("python Selected");
        image(python_boost, 0, 0, birdWidth+20, birdHeight+20);
        break;

      case 3: 
        //println("ruby Selected");
        image(ruby_boost, 0, 0, birdWidth+20, birdHeight+20);
        break;

      default: 
        println("error");
        break;
      }
    }


    popMatrix();
  }
}
