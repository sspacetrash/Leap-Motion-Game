import de.voidplus.leapmotion.*;

PVector[] handPositions = new PVector[10];
int handPosIndex = 0;

float INTERACTION_SPACE_WIDTH = 300; // left-right from user
float INTERACTION_SPACE_DEPTH = 200; // away-and-toward user
float FINGER_DOT = 30;

LeapMotion leap;

void setup() {
  size(800, 500, OPENGL);
  leap = new LeapMotion(this);
  textAlign(CENTER);
}

void draw() {
  background(100);

  // FPS
  int fps = leap.getFrameRate();
  fill(#00E310);
  text(fps + " fps", 20, 20);

  for (Hand hand : leap.getHands ()) {


    PVector thumbTip = hand.getThumb().getRawPositionOfJointTip();
    PVector indexTip = hand.getIndexFinger().getRawPositionOfJointTip();
    PVector ringTip = hand.getRingFinger().getRawPositionOfJointTip();
    PVector middleTip = hand.getMiddleFinger().
      getRawPositionOfJointTip();
    PVector pinkyTip = hand.getPinkyFinger().getRawPositionOfJointTip();

    handleFinger(thumbTip, "thb");
    handleFinger(indexTip, "idx");
    handleFinger(middleTip, "mdl");
    handleFinger(ringTip, "rng");
    handleFinger(pinkyTip, "pky");

    handPositions[handPosIndex++] = hand.getPalmPosition();
    handPosIndex = handPosIndex % handPositions.length;
    hand.draw();
  }

  if (handPositions[handPositions.length-1] != null) {
    PVector currentPos = handPositions[handPosIndex == 0 ? handPositions.length-1 : handPosIndex-1];
    PVector prevPos = handPositions[handPosIndex];
    PVector handVelocity = PVector.sub(currentPos, prevPos);
    println("hand speed ", handVelocity.mag(), " velocity ", handVelocity);
  }
}



void handleFinger(PVector pos, String id) {

  // map finger tip position to 2D surface
  float x = map(pos.x, -INTERACTION_SPACE_WIDTH, 
    INTERACTION_SPACE_WIDTH, width, 0);
  float y = map(pos.z, -INTERACTION_SPACE_DEPTH, 
    INTERACTION_SPACE_DEPTH, 0, height);

  fill(#00E310);
  noStroke();
  ellipse(x, y, FINGER_DOT, FINGER_DOT);

  // ID
  fill(0);
  text(id, x, y + 5);
}
