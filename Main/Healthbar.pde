class Healthbar implements Updater {
  PImage stroopwafel;
  int lives = 6;
  int iMax = 6;
  private boolean clickedLastFrame = false;
  boolean dead = false;
  boolean removeAHealth = false;
  boolean addAHealth = false;

  Healthbar() {
    stroopwafel = loadImage("stroopwafel.jpg");
    updateList.add(this);
  }

  void updateObject() {
  }

  void drawObject() {
    //Box of lives
    fill(255);
    strokeWeight(3);
    rect(-10, -10, 310, 60);

    int x = 0;
    for (int i=0; i < iMax; i++) {
      image(stroopwafel, x, 0, stroopwafel.width/8, stroopwafel.height/8);
      x += 50;
    }
    // display gameover screen
    if (dead) {
      gameover.drawObject();
    }
  }

  void pressedKey() {
    //Press 'd' to take damage
    if (keyPressed && key == 'd') {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        removeHealth();
      }
    }
    //Press 'e' to eat a stroopwafel
    if (keyPressed && key == 'e') {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        healthbar.addHealth();
      }
    }
  }

  void releasedKey() {
    clickedLastFrame = false;
    removeAHealth = false;
    addAHealth = false;
  }

  void removeHealth() {
    if (!removeAHealth && !dead) {
      removeAHealth = true;
      if (lives > 0 ) {
        lives--;
        iMax--;
      } 
      if (lives == 0) {
        dead = true;
      }
    }
  }

  void addHealth() {
    if (!addAHealth && !dead ) {
      addAHealth = true;
      if (lives < 6 && !dead) {
        lives++;
        iMax++;
      }
    }
  }
}
