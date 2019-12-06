class Background implements Updater { //<>//
  float backgroundX = 0, backgroundPaneX = 1280, backgroundPaneY = 0, backgroundPane2X = 1920, backgroundPane2Y = 0, backgroundPane3X = 2560, backgroundPane3Y = 0;
  float groundHeight = height - 24;
  float speed = characterSelect.getSpeed();
  // CONSTANTS
  final int PANEL_WIDTH = 640;
  final int PANEL_HEIGHT = 800;
  final int PANEL_DESPAWN_BORDER = -640;
  final int RESPAWN_X = 1280;
  final int GROUND_X = -50;
  final int GROUND_WIDTH = width + 50;

  Background() {
    updateList.add(this);
  }

  void drawObject() {
    // background panes
    image(backgroundImage, backgroundX, 0);
    noStroke();

    //first
    image(backgroundpane, backgroundPaneX, backgroundPaneY);

    //second
    image(backgroundpane2, backgroundPane2X, backgroundPane2Y);

    //third
    image(backgroundpane3, backgroundPane3X, backgroundPane3Y);
    stroke(0);

    //ground
    fill(100, 0, 0);
    rect(GROUND_X, groundHeight, GROUND_WIDTH, groundHeight);
  }

  void updateObject() {
    if(keys[2] == true){
    backgroundPaneX -= speed;
    backgroundPane2X -= speed;
    backgroundPane3X -= speed;
    backgroundX -= speed;
    highScore.updateScore();}
    if (backgroundPaneX <= PANEL_DESPAWN_BORDER) {
      backgroundPaneX = RESPAWN_X;
    }
    if (backgroundPane2X <= PANEL_DESPAWN_BORDER) {
      backgroundPane2X = RESPAWN_X;
    }
    if (backgroundPane3X <= PANEL_DESPAWN_BORDER) {
      backgroundPane3X = RESPAWN_X;
    }
  }

  void pressedKey() {
        if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = true;
      }
     }
  }

  void releasedKey() {
           if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = false;
      }
     }
  }

  void equalize() {
    backgroundPaneX = ceil(backgroundPaneX/10)*10;
    backgroundPane2X = ceil(backgroundPane2X/10)*10;
    backgroundPane3X = ceil(backgroundPane3X/10)*10;
  }
}
