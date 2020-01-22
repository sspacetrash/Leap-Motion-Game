

class Score {
  int mainScore;
  int secondScore;
  Score() {
    mainScore = 0;
    secondScore = 0;
  }

  void addScore() {
    for (int i = 0; i < myPipe.length; i++) {
      int pipeloc = myPipe[i].pipeX + myPipe[i].pipeWidth;
      if (pipeloc == 276) {
        println("add");
        mainScore++;
        sound.play();
      }
    }
  }

  void flyScore() {
    secondScore = (10 - (millis()-startTime)/1000);
  }
}
