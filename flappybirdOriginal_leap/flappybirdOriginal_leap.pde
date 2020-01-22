import de.voidplus.leapmotion.*;
import processing.sound.*;

int x, y;  //bird
int sceneCount = 0 ;

//Pipe myPipe = new Pipe();
Pipe[] myPipe = new Pipe[2];
powerUp myPower = new powerUp();
ready myReady = new ready();
Score myScore = new Score();
Bird myBird;
LeapMotion leap;

int beginX = 600;
int disBeginX = 300;
int beginY = 550; 


int blueX = 500-100;
int pythonX = 700-100;
int rubyX = 300-100;
int blueY = 300 - 200;
int birdY = 600 - 250;

int selectHeight = 340;
int selectWidth = 250;
int selectID = 3;

int owlX = 1000 - 420;
int owlY = 400-170;
int owlWidth = 320;
int owlHeight = 300;
int playCount = 0;
int endCount = 0;
int fingerOut;
float INTERACTION_SPACE_WIDTH = 200; // left-right from user
float INTERACTION_SPACE_DEPTH = 300; // away-and-toward user
float FINGER_DOT = 30;

flyballs[] myBall = new flyballs[25];
flybird myFlybird = new flybird();

PImage bg0, bg1, bg2;
PImage heading;
PImage instruct;
PImage choiceText;
PImage bluej, python, ruby, power;
PImage bluej_boost, python_boost, ruby_boost;
PImage pipeUp, pipeDown;

PImage bluej_fly, python_fly, ruby_fly;
PImage flypipes;


PImage blueJ_home, ruby_home, python_home;
PImage yesButton, noButton;
PImage backButton, howButton, playButton;
PImage owlYes, owlNo, owlQ;
PImage scoreboard;

SoundFile introMusic;
SoundFile blueJGreet, rubyGreet, pythonGreet;
SoundFile blueJHit, rubyHit, pythonHit;
SoundFile owlQV;
SoundFile sound;


/*
1st ending
 */

freeze myFreeze = new freeze();
boolean gameEnd;
int selectCont = 0;

int buttonWidth = 250;
int buttonHeight = 195;
int contX = width + 50;
int contY = 500;
int disContX = contX + 400;
int disContY = contY;

boolean isRead;

int startTime;

void setup() {
  size(1100, 750, OPENGL);
  isRead = false;
  gameEnd = false;
  myBird = new Bird();
  myPipe[0] = new Pipe();
  myPipe[0].renew();
  myPipe[1] = new Pipe();
  myPipe[1].pipeX = 2000;

  leap = new LeapMotion(this).allowGestures("Key_tap, circle");
  for (int i = 0; i < myBall.length; i++) {
    myBall[i] = new flyballs(random(0, width), 40, random(-3, 1), random(-3, 1), 30);
  }
  myFlybird.initialize();
  myPower.statsetup();

  startTime = 0;


  heading = loadImage("heading.png");
  bg0 = loadImage("background_mode0.jpg");
  bg1 =loadImage("background_mode1.jpg");
  bg2= loadImage("background_mode2.jpg");

  instruct = loadImage("instructions.png");

  choiceText = loadImage("font.png");

  bluej = loadImage("BlueJ.png");
  python = loadImage("python_eagle.png");
  ruby = loadImage("ruby_budgee.png");
  power = loadImage("stackoverflow_powerup.png");

  bluej_boost = loadImage("blueJ_flame.png");
  python_boost =loadImage("python_flame.png");
  ruby_boost = loadImage("ruby_flame.png");

  bluej_fly = loadImage("fly_bluej.png");
  python_fly = loadImage("fly_eagle.png");
  ruby_fly = loadImage("fly_ruby.png");

  flypipes = loadImage("fly_pipes.png");
  pipeUp = loadImage("pipe_up.png");
  pipeDown = loadImage("pipe_down.png");

  blueJ_home = loadImage("blueJ_home.png");
  python_home = loadImage("python_home.png");
  ruby_home = loadImage("ruby_home.png");

  yesButton = loadImage("yes.png");
  noButton = loadImage ("no.png");

  backButton = loadImage("back.png");
  howButton = loadImage("how.png");
  playButton = loadImage("play.png");

  scoreboard = loadImage("scoreboard.png");
  scoreboard.resize(710, 500);
  owlQ = loadImage("owl_challenge.png");
  owlNo = loadImage("owl_no.png");
  owlYes =loadImage("owl_win.png");

  introMusic = new SoundFile(this, "introMusic.mp3");
  rubyGreet = new SoundFile(this, "Ruby_letsgo.WAV");
  blueJGreet = new SoundFile(this, "BJ_roll.WAV");
  pythonGreet = new SoundFile(this, "PY_doThis.WAV");

  blueJHit = new SoundFile(this, "BJ_ow.WAV");
  rubyHit = new SoundFile(this, "Ruby_owie.WAV");
  pythonHit = new SoundFile(this, "PY_ouch.WAV");

  sound = new SoundFile(this, "effect.wav");
  owlQV = new SoundFile(this, "owl_challenge.WAV");
  introMusic.amp(0.3);
  introMusic.play();
}


void leapOnKeyTapGesture(KeyTapGesture g) {
  isTapped = true;
}

int currentM = 0;
void leapOnCircleGesture(CircleGesture g, int state) {
  //println("current M: " + currentM);
  //println("current time: " + millis());
  if ( currentM < millis() + 1000) {
    // println("isRead = false");
    isRead= false;
  }

  if (sceneCount == 2) {
    switch(state) {
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      isCircled = true;
      isRead = true;
      currentM = millis();

      println("Is circled");
      break;
    }
  }
}

void draw() {
  switch (sceneCount) {
  case 0:
    image(bg0, 0, 0, width, height);
    cursors.clear();
    image(heading, (width/2 - (heading.width/2)), (height/1.5 - (heading.height)));
    beginButtons.add(new begin(beginX-145, beginY, buttonWidth, buttonHeight, 2, 1, playButton)); //play game
    //beginButtons.add(new begin(disBeginX, beginY, buttonWidth, buttonHeight, 2, 4, howButton)); //instructions

    for (begin b : beginButtons) {
      b.render();
    }

    textSize(40);
    //text("Hold up two fingers to start game", width/6, height-150); 
    //text("Hold up one finger to read instructions", width/8, height-100); 

    for (Hand hand : leap.getHands()) {
      Finger index = hand.getIndexFinger();
      PVector pos = index.getPosition();
      if (hand.isRight()) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 255, 0);
      }
      ellipse(pos.x, pos.y, 30, 30);
      cursors.add(pos);
    }



    for (begin b : beginButtons) {
      b.update(cursors);
    }



    break;
  case 1:
    image(bg0, 0, 0, width, height);
    cursors.clear();
    image(choiceText, 325, 5, 400, 80);
    //println("Now in menu scene");
    buttons.add(new MenuButtons(blueX, blueY, selectWidth, selectHeight, 2, 1, blueJ_home));
    buttons.add(new MenuButtons(pythonX, birdY, selectWidth, selectHeight, 2, 2, python_home));
    buttons.add(new MenuButtons(rubyX, birdY, selectWidth, selectHeight, 2, 3, ruby_home));

    // handle buttons
    for (MenuButtons b : buttons) {
      b.render();
    }

    strokeWeight(3);
    noFill();
    for (Hand hand : leap.getHands()) {
      Finger index = hand.getIndexFinger();
      PVector pos = index.getPosition();
      if (hand.isRight()) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 255, 0);
      }
      ellipse(pos.x, pos.y, 30, 30);
      cursors.add(pos);
    }

    for (MenuButtons b : buttons) {
      b.update(cursors);
    }

    break;

  case 2: 
    image(bg1, 0, 0, width, height);
    myPower.update();
    myBird.control();
    myPower.isCollideP(myBird);


    myBird.display();
    isBoosted = false;



    if (myPower.isCrashed == false) {
      myPower.display();
    }

    myPower.statUpdate();
    myPower.statDisplay();


    isTapped = false;

    if (myPipe[0].pipeX == 400) {
      myPipe[1].renew();
    }

    for (int p = 0; p < myPipe.length; p++) {
      myBird.isCollide(myPipe[p]);
      myScore.addScore();
      myPipe[p].update();
      myPipe[p].display();
    }



    fill(0);
    textSize(80);
    text(myScore.mainScore/2, (width/1.1), (height/8));
    break;

  case 3:  
    image(bg0, 0, 0, 1100, 900);
    //println("Now in prepration scene");
    myReady.instruct();
    for (Hand hand : leap.getHands ()) {
      fingerOut = hand.getOutstretchedFingers().size();
    }
    if (fingerOut == 0) {
      //println("No finger out");
      myReady.startCountdown();
      if (gameEnd == false) {
        sceneCount = 2;
      } else {
        sceneCount = 5;
      }
    }

    break;

  case 4: //Instructions
    image(bg0, 0, 0, width, height);
    cursors.clear();
    image(instruct, 180, 120, 580, 500);
    //println("Now in Instructions");

    instructButtons.add(new instruct(800, 200, buttonWidth, buttonHeight, 2, 0, backButton)); //play game
    instructButtons.add(new instruct(800, 400, buttonWidth, buttonHeight, 2, 1, playButton)); //instructions

    for (begin b : beginButtons) {
      b.render();
    }

    for (Hand hand : leap.getHands()) {
      Finger index = hand.getIndexFinger();
      PVector pos = index.getPosition();
      if (hand.isRight()) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 255, 0);
      }
      ellipse(pos.x, pos.y, 30, 30);
      cursors.add(pos);
    }


    for (begin f : beginButtons) {
      f.update(cursors);
    }


    break;

  case 5: //second gameplay
    int scoreX = 700;
    int scoreY = 200;


    if (playCount == 0) {
      playCount = 1;
      startTime = millis();
    }


    image(bg2, 0, 0, width, height);
    PVector current;


    //println("Now in camera gameplay scene");
   


    image(flypipes, 0, 0, width, 100);

    for (Hand hand : leap.getHands ()) {
      current = hand.getIndexFinger().getRawPositionOfJointTip();
      //println("current: " + current);
      myFlybird.birdposX = map(current.x, -INTERACTION_SPACE_WIDTH, 
        INTERACTION_SPACE_WIDTH, -width, width);

      myFlybird.birdposY = map(current.y, -INTERACTION_SPACE_DEPTH, 
        INTERACTION_SPACE_DEPTH, height*2, 0);
    }

    myFlybird.display();
     for (int i = 0; i < myBall.length; i++) {
      myBall[i].updateLocation(); 
      myBall[i].display();
      myBall[i].isCollideB(myFlybird);
    }
    //text("Score: " + myScore.secondScore, scoreX, scoreY);
    fill(50);
    text("Time : " + (10 - (millis()-startTime)/1000), scoreX, scoreY +100);
    //println(millis() - startTime);

    if ((millis() - startTime) > 10000) {
      sceneCount = 9;
    }
    break;

  case 6: 
    println ("Now in Bird exit portal animation");
    break;

  case 7: // Main ending scene
    if (endCount == 0) {

      endCount = 1;
      owlQV.amp(1);
      owlQV.play();
    }
    gameEnd = true;
    image(bg1, 0, 0, width, height);
    myFreeze.display();
    fill(2, 188, 250);
    
    image(scoreboard, 110,200);
    //rect(110, 200, 710, 500, 18, 18, 18, 18);

    endButtons.add(new mainEnd(contX, contY, buttonWidth, buttonHeight, 2, 1, yesButton)); // continue
    endButtons.add(new mainEnd(disContX, disContY, buttonWidth, buttonHeight, 2, 2, noButton)); //not continue
    image(owlQ, owlX, owlY, 500, 450);






    cursors.clear();

    // handle buttons
    for (mainEnd b : endButtons) {
      b.render();
    }

    strokeWeight(3);
    noFill();
    for (Hand hand : leap.getHands()) {
      Finger index = hand.getIndexFinger();
      PVector pos = index.getPosition();
      if (hand.isRight()) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 255, 0);
      }
      ellipse(pos.x, pos.y, 30, 30);
      cursors.add(pos);
    }

    for (mainEnd b : endButtons) {
      b.update(cursors);
    }


    textSize(70);
    text("SCORE: " + (myScore.mainScore/2), 450, 350);

    break;

  case 8: //test

  case 9: //Final ending
    image(bg0, 0, 0, width, height);
    noStroke();
    fill(2, 188, 250);
    image(scoreboard, 110,200);
    //rect(110, 200, 710, 500, 18, 18, 18, 18);
    if (selectCont == 1) {
      image(owlYes, owlX, owlY+65, 500, 450);
    } 
    if (selectCont == 2) {
      image(owlNo, owlX, owlY+65, 500, 450);
    }

    textSize(70);
    fill(0);
    text("SCORE: " + (myScore.mainScore/2) + " + "  + myScore.secondScore,450, 350);
    int finalscore = (myScore.mainScore/2) + myScore.secondScore;
    text("= " + finalscore , 450, 450);
    

    break;

  default:
    println("Error");
    break;
  }
}
