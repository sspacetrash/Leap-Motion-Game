class freeze {
  int i;
  freeze() {
    i = 0;
  }
  void display() {

    for (i =0; i< myPipe.length; i++) {
      image(pipeDown, myPipe[i].pipeX, myPipe[i].upperBound);
      image(pipeUp, myPipe[i].pipeX, myPipe[i].upperBound + myPipe[i].pipeGap);
      /*
    println("pipeX: " + myPipe[i].pipeX);
       println("upperBound: " + myPipe[i].upperBound);
       println("lowerBound: " + myPipe[i].lowerBound);
       println("Bird X:" + myBird.x);
       println("Bird Y:" + myBird.y);
       */
    }

    switch (selectID) {
    case 1: 
      //println("BlueJ Selected");
      image(bluej, myBird.x, myBird.y, myBird.birdWidth, myBird.birdHeight);
      break;

    case 2: 
      //println("python Selected");
      image(python, myBird.x, myBird.y, myBird.birdWidth, myBird.birdHeight);
      break;
    case 3: 
      //println("ruby Selected");
      image(ruby, myBird.x, myBird.y, myBird.birdWidth, myBird.birdHeight);
      break;

    default: 
      println("error");
      break;
    }
  }
}
