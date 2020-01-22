class flybird {
  int birdHeight, birdWidth;

  float intialX, initalY;
  float birdposX, birdposY;

  flybird() {
    birdHeight = 60;
    birdWidth = 180;
  }
  void initialize() {
    birdposX = 400;
    birdposY = 400;
  }
  void display() {


    switch (selectID) {
    case 1: 
      //println("BlueJ Selected");
      image(bluej_fly, birdposX, birdposY, birdWidth, birdHeight);
      break;

    case 2: 
      //println("python Selected");
      image(python_fly, birdposX, birdposY, birdWidth, birdHeight);
      break;

    case 3: 
      //println("ruby Selected");
      image(ruby_fly, birdposX, birdposY, birdWidth, birdHeight);
      break;

    default: 
      println("error");
      break;
    }
  }
}
