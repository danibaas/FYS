class Background implements Updater {
  PImage background;
  PImage backgroundpane;
  PImage backgroundpane2;
  PImage backgroundpane3;
  float backgroundX = 0;
  float backgroundPaneX = 1280;
  float backgroundPaneY = 0;
  float backgroundPane2X = 1920;
  float backgroundPane2Y = 0;
  float backgroundPane3X = 2560;
  float backgroundPane3Y = 0;
  float groundHeight = height - 24;
  float speed = 5;
  boolean walkingForward, walkingBackward, enabled;

  Background() {
    background = loadImage(sketchPath() + "/lib/background.png");
    backgroundpane = loadImage(sketchPath() + "/lib/backgroundpane1.png");
    backgroundpane.resize(640, 800);
    backgroundpane2 = loadImage(sketchPath() + "/lib/backgroundpane2.png");
    backgroundpane2.resize(640, 800);
    backgroundpane3 = loadImage(sketchPath() + "/lib/backgroundpane3.png");
    backgroundpane3.resize(640, 800);
    enabled = true;
    updateList.add(this);
  }

  void drawObject() {
    // background panes
    image(background, backgroundX, 0);
    noStroke();
    //first
    fill(0, 255, 0);
    rect(backgroundPaneX, backgroundPaneY, 640, 800);
    image(backgroundpane, backgroundPaneX, backgroundPaneY);
    //second
    fill(255, 0, 0);
    rect(backgroundPane2X, backgroundPane2Y, 640, 800);
    image(backgroundpane2, backgroundPane2X, backgroundPane2Y);

    //third
    fill(10, 10, 225);
    rect(backgroundPane3X, backgroundPane3Y, 640, 800);
    image(backgroundpane3, backgroundPane3X, backgroundPane3Y);
    stroke(0);

    //ground
    fill(100, 0, 0);
    rect(0-50, groundHeight, width + 50, groundHeight);
  }

  void updateObject() {
    if (!player.hasCollision() && !player.stopMoving && enabled) {
      if (keys[2]) {
        walkingForward = true;
        //achtergrond blok1
        if (walkingForward) { //COLLISION CHECK
          backgroundPaneX -= speed;
          backgroundPane2X -= speed;
          backgroundPane3X -= speed;
          backgroundX -= speed;
        }
        highScore.updateScore();
      } else if (keys[1]) {
        walkingBackward = true;
        if (walkingBackward) {  //COLLISION CHECK
          backgroundPaneX += speed;
          backgroundPane2X += speed;
          backgroundPane3X += speed;
          backgroundX += speed;
        }
      }
      if (walkingForward) { // walkingForward && collision check
        if (backgroundPaneX == 640) {
          backgroundPane2X = 1280;
        }
        if (backgroundPane2X == 640) {
          backgroundPane3X = 1280;
        }
        if (backgroundPane3X == 640) {
          backgroundPaneX = 1280;
        }
      }
      if (walkingBackward) { // walkingForward && collision check
        if (backgroundPaneX == 0) {
          backgroundPane3X = -640;
        }
        if (backgroundPane3X == 0) {
          backgroundPane2X = -640;
        }
        if (backgroundPane2X == 0) {
          backgroundPaneX = -640;
        }
      }
    }
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = true;
      } else if (keyCode == LEFT) {
        keys[1] = true;
      }
    }
  }

  void releasedKey() {
    walkingForward = false;
    walkingBackward = false;
    if (key == CODED) {
      if (keyCode == LEFT) {
        keys[1] = false;
      } else if (keyCode == RIGHT) {
        keys[2] = false;
      }
    }
  }

  void turnOn() {
    enabled = true;
  }

  void turnOff() {
    enabled = false;
  }
}
