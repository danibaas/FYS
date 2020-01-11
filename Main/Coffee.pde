class Coffee extends Collider implements Updater {
  boolean speedBoostActive, spawned = true;
  final int WAIT_TIME = 3000;
  final int SPAWN_WAIT_TIME = 15000;
  final int SCORE_THRESHOLD = 100;
  final int RESPAWN_MIN = 1500;
  final int RESPAWN_MAX = 1800;
  final float SPEED_MULTIPLIER = 1.5;
  float boostSpeed;
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
        background.speed = boostSpeed;
        boostSpeed = floor(characterSelect.getSpeed() * SPEED_MULTIPLIER);
        spawned = false;
      }
    }
    if (!boss.spawnBoss) {
      loopCoffee();
      if (keys[2] && highScore.highScore > SCORE_THRESHOLD) { 
        moveEntity();
      }
    } else {
      if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) {
        moveEntity();
      }
    }
    timerThread();
    if (speedBoostActive) {
      if (player.airBorne && background.speed != previousSpeed) {
        background.speed = previousSpeed;
      } else if (!player.airBorne && background.speed != boostSpeed) {
        background.speed = boostSpeed;
      }
    }
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
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
    }
  }

  void loopCoffee() {
    if (position.x + boxWidth < 0 && spawned) {
      despawnTime = millis();
      spawned = false;
    }
  }
}
