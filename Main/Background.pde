class Background implements Updater { //<>//
  float backgroundX = 0, backgroundPaneX = 1280, backgroundPaneY = 0, backgroundPane2X = 1920, backgroundPane2Y = 0, backgroundPane3X = 2560, backgroundPane3Y = 0;
  float groundHeight = height - 24;
  float speed = characterSelect.getSpeed();

  Background() {
    updateList.add(this);
  }

  void drawObject() {
    // background panes
    image(backgroundImage, backgroundX, 0);
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
    rect(-50, groundHeight, width + 50, groundHeight);
  }

  void updateObject() {
    backgroundPaneX -= speed;
    backgroundPane2X -= speed;
    backgroundPane3X -= speed;
    backgroundX -= speed;
    highScore.updateScore();
    if (backgroundPaneX <= -640) {
      backgroundPaneX = 1280;
    }
    if (backgroundPane2X <= -640) {
      backgroundPane2X = 1280;
    }
    if (backgroundPane3X <= -640) {
      backgroundPane3X = 1280;
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void equalize() {
    backgroundPaneX = ceil(backgroundPaneX/10)*10;
    backgroundPane2X = ceil(backgroundPane2X/10)*10;
    backgroundPane3X = ceil(backgroundPane3X/10)*10;
  }
}
