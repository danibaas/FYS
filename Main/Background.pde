class Background implements Updater {
  PImage background;
  float backgroundX = 0;
  float backgroundPaneX = 1280;
  float backgroundPaneY = 0;
  float backgroundPane2X = 1920;
  float backgroundPane2Y = 0;
  float backgroundPane3X = 2560;
  float backgroundPane3Y = 0;
  float groundHeight = height - 24;
  float speed = 10;
  boolean walkingForward;
  boolean walkingBackward;

  Background() {
    background = loadImage(sketchPath() + "/lib/background.png");
    updateList.add(this);
  }
  void drawObject() {
    // background panes
    image(background, backgroundX, 0);
    noStroke();
    //first
    fill(0, 255, 0);
    rect(backgroundPaneX, backgroundPaneY, 640, 800);

    //second
    fill(255, 0, 0);
    rect(backgroundPane2X, backgroundPane2Y, 640, 800);

    //third
    fill(10, 10, 225);
    rect(backgroundPane3X, backgroundPane3Y, 640, 800);
    stroke(0);

    //ground
    fill(100, 0, 0);
    rect(0-50, groundHeight, width + 50, groundHeight);
  }

  void updateObject() {
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        walkingForward = true;
        //achtergrond blok1
        if (!obstacle.collision) {
          backgroundPaneX -= speed;
          backgroundPane2X -= speed;
          backgroundPane3X -= speed;
          backgroundX -= speed;
        }
      } else if (keyCode == LEFT) {
        walkingBackward = true;
        if (!obstacle.collision) {
          backgroundPaneX += speed;
          backgroundPane2X += speed;
          backgroundPane3X += speed;
          backgroundX += speed;
        }
      }
      if (walkingForward && !obstacle.collision) {
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
      if (walkingBackward && !obstacle.collision) {
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

  void releasedKey() {
    walkingForward = false;
    walkingBackward = false;
  }
}
