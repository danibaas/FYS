class Healthbar implements Updater {
  PImage stroopwafel;
  int maxLives;
  int currentLives;
  private boolean clickedLastFrame = false;
  boolean dead = false;
  boolean removeAHealth = false;
  boolean addAHealth = false;
  boolean getHealth = false;

  Healthbar() {
    stroopwafel = loadImage(sketchPath() + "/lib/stroopwafel.jpg");
    stroopwafel.resize(35, 35);
    updateList.add(this);
  }

  void updateObject() { 
    if (characterSelect.choseDonDon && !getHealth) {
      getHealth = true;
      maxLives = 6;
      currentLives = 6;
    } else if (characterSelect.choseCorra && !getHealth) {
      getHealth = true;
      maxLives = 3;
      currentLives = 3;
    }
  }

  void drawObject() {
    if(characterSelect.hasChosen){
      
    }
    //Box of lives
    fill(255);
    strokeWeight(3);
    rect(-10, -10, 10+40*currentLives, 60);

    int lifeOffset = 0;
    for (int iLives=0; iLives < currentLives; iLives++) {
      image(stroopwafel, lifeOffset, 5);
      lifeOffset += 40;
    }

    // display gameover screen
    if (dead) {
      gameOver.drawObject();
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
        addHealth();
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
      if (currentLives > 0 ) {
        currentLives--;
      } 
      if (currentLives == 0) {
        dead = true;
      }
    }
  }

  void addHealth() {
    if (!addAHealth && !dead ) {
      addAHealth = true;
      if (currentLives < maxLives && !dead) {
        currentLives++;
      }
    }
  }
}
