class Coffee extends Collider implements Updater {
  boolean speedBoostActive, spawned = true;
  final int WAIT_TIME = 3000;
  final int SPAWN_WAIT_TIME = 15000;
  int currentTime, previousSpeed, despawnTime;

  Coffee(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    if (spawned) {
      image(coffee, position.x, position.y);
    }
  }

  void updateObject() {
    if (gameOver.gameOver) {
      position.x = width + 2*boxWidth;
    }
    if (collidesWithPlayer(player)) {
      if (!speedBoostActive) {
        currentTime = millis();
        speedBoostActive = true;
        previousSpeed = (int) background.speed;
        background.equalize();
        if (characterSelect.choseDonDon) {
          background.speed = 8;
        } else {
          background.speed = characterSelect.getSpeed() * 2;
        }
        spawned = false;
      }
    }
    if (keys[2]) { 
      moveEntity();
    }
    if (!boss.spawnBoss) {
      loopCoffee();
    }
    timerThread();
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

  void timerThread() {
    if (currentTime + WAIT_TIME < millis()) {
      if (speedBoostActive) {
        speedBoostActive = false; 
        background.speed = characterSelect.getSpeed();
        despawnTime = millis();
      }
    }
    if (despawnTime + SPAWN_WAIT_TIME < millis() && !spawned) {
      spawned = true;
      position.x = (int) random(1500, 1800);
    }
  }

  void loopCoffee() {
    if (position.x + boxWidth < 0 && spawned) {
      despawnTime = millis();
      spawned = false;
    }
  }
}
