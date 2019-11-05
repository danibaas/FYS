class Enemy extends Collider implements Updater {
  PImage skin;
  int timer;
  int waitTime = 3000;
  int health = 10;
  boolean removedHealthLastFrame = false;
  int healthTimer;
  int holdRemove = 1000;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    skin = loadImage(sketchPath() + "/lib/enemy.png");
    skin.resize((int) boxWidth + 10, (int) boxHeight + 10);
    timer = millis();
    updateList.add(this);
  }

  void updateObject() {
    checkDead();
    if (collidesWithPlayer(player) && !removedHealthLastFrame) {
      player.colliderType = ColliderType.ENEMY;
      healthbar.removeHealth();
      removedHealthLastFrame = true;
      healthTimer = millis();
    }
    moveEntity(false);
    loopEnemy();
    if (healthTimer + holdRemove < millis()) {
       removedHealthLastFrame = false; 
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

  void checkDead() {
    if (health < 1) {
      position.x = width + 2*boxWidth; 
      health = 10;
    }
  }

  void loopEnemy() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = width + 2*boxWidth;
    }
  }
}
