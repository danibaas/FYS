class Coffee extends Collider implements Updater {
  PImage coffee;
  boolean speedBoostActive, spawned = true;
  final int WAIT_TIME = 3000;
  final int SPAWN_WAIT_TIME = 5000;
  int currentTime;
  int previousSpeed;
  int despawnTime;

  Coffee(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    coffee = loadImage(sketchPath() + "/lib/coffee.png");
    coffee.resize((int) boxWidth, (int) boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    if (spawned) {
      fill(255);
      rect(position.x, position.y, boxWidth, boxHeight);
      image(coffee, position.x, position.y);
    }
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      if (!speedBoostActive) {
        currentTime = millis();
        speedBoostActive = true;
        previousSpeed = (int) background.speed;
        background.speed = characterSelect.getSpeed() * 2;
        spawned = false;
      }
    }
    moveEntity(false);
    loopCoffee();
    timerThread();
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void timerThread() {
    if (currentTime + WAIT_TIME < millis()) {
      if (speedBoostActive) {
        speedBoostActive = false; 
        background.speed = characterSelect.getSpeed();
      }
    }
    if (despawnTime + SPAWN_WAIT_TIME < millis() && !spawned) {
      spawned = true;
      position.x = width + 2*boxWidth;
    }
  }

  void loopCoffee() {
    if (position.x + boxWidth < 0) {
      despawnTime = millis();
      spawned = false;
    }
  }
}
