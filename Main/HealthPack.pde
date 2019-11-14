class HealthPack extends Collider implements Updater {
  PImage skin;
  int timer;
  int waitTime = 3000;
  boolean hasPickedUp;

  HealthPack(PVector position, float boxWidth, float boxHeight) {
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
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.PICKUP;
      if (player.healthbar.addHealth()) {
        hasPickedUp = true;
      }
    }
    moveEntity(false);
    if (!boss.spawnBoss) {
      loopPickup();
    }
  }

  void loopPickup() {
    if (hasPickedUp) {
      hasPickedUp = false;
      position.x = width + 2 * boxWidth;
      timer = millis();
    }
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
