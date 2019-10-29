class Pickup extends Collider implements Updater {
  PImage skin;
  int timer;
  int waitTime = 3000;

  Pickup(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    skin = loadImage(sketchPath() + "/lib/healthkit.png");
    skin.resize((int) boxWidth, (int) boxHeight);
    timer = millis();
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    image(skin, position.x, position.y);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) { // collision check
      healthbar.addHealth();
    }
    if (!player.hasCollision()) {
      moveEntity(false);
      loopPickup();
    }
  }
  void loopPickup() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = width + 2*boxWidth;
    }
  } 

  void pressedKey() {
  }

  void releasedKey() {
  }
}
