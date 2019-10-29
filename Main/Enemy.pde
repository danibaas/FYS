class Enemy extends Collider implements Updater {
  PImage skin;
  int timer;
  int waitTime = 3000;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    skin = loadImage(sketchPath() + "/lib/enemy.png");
    skin.resize((int) boxWidth + 10, (int) boxHeight + 10);
    timer = millis();
    updateList.add(this);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      healthbar.removeHealth();
    }
    if (!player.hasCollision()) {
      moveEntity(false);
      loopEnemy();
    }
  }
  void loopEnemy() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = width + 2*boxWidth;
    }
  } 

  void drawObject() {
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    pushMatrix();
    translate(position.x + 100, position.y);
    scale(-1, 1);
    image(skin, 0, 0);
    popMatrix();
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
