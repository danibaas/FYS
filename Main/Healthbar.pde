class Healthbar {
  PImage stroopwafel;
  int lives = 6;
  int iMax = 6;
  boolean clickedLastFrame = false;
  boolean dead = false;

  void loadHealth() {
    stroopwafel = loadImage("stroopwafel.jpg");
  }

  void removeHealth() {
    if (lives > 0 ) {
      lives-=1;
      iMax-=1;
      if (lives == 0) {
        dead = true;
      }
    }
  }

  void addHealth() {
    if (lives < 6 && dead == false) {
      lives++;
      iMax++;
    }
  }

  void drawHealthbar() {
    background(255);
    //Box of lives
    fill(255);
    strokeWeight(3);
    rect(-10, -10, 310, 60);

    //fill(0);
    //strokeWeight(1);
    //textSize(25);
    //text("lives: " + lives, 0, 75);

    int x = 0;
    for (int i=0; i < iMax; i++) {
      image(stroopwafel, x, 0, stroopwafel.width/8, stroopwafel.height/8);
      x += 50;
    }
    // display gameover screen
    if (dead) {
      //  fill(0);
      //  textSize(50);
      //  text("GAME OVER", 500, 360);
    }
  }

  void pressedKey() {
    //Press 'd' to take damage
    if (keyPressed == true && key == 'd') {
      if (clickedLastFrame == false) {
        clickedLastFrame = true;
        if (lives > 0) {
          lives--;
          iMax--;
          if (lives == 0) {
            dead = true;
          }
        }
      }
    }
    //Press 'o' to eat a stroopwafel
    if (keyPressed == true && key == 'o') {
      if (clickedLastFrame == false) {
        clickedLastFrame = true;
        if (lives < 6 && dead == false) {
          lives++;
          iMax++;
        }
      }
    }
  }

  void releasedKey() {
    clickedLastFrame = false;
  }
}
