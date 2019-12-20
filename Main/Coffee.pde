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
        if (characterSelect.choseDonDon) {
          background.speed = 8;
        } else {
          background.speed = characterSelect.getSpeed() * 2;
        }
        spawned = false;
      }
    }
    if (!boss.spawnBoss) {
      loopCoffee();
      if (keys[2] && highScore.highScore > 100) { 
        moveEntity();
      }
    } else {
      if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) {
        moveEntity();
      }
    }
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
