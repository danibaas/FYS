class Coffee extends Collider implements Updater {
  boolean speedBoostActive, spawned = true;

  // Constants
  final int WAIT_TIME = 3000;
  final int SPAWN_WAIT_TIME = 15000;
  final int SCORE_THRESHOLD = 100;
  final int RESPAWN_MIN = 1500;
  final int RESPAWN_MAX = 1800;
  final float SPEED_MULTIPLIER = 1.5;
  float boostSpeed;
  int currentTime, previousSpeed, despawnTime;

  // Constructor
  Coffee(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  // Parent method om te tekenen
  void drawObject() {
    if (spawned) {
      image(coffee, position.x, position.y);
    }
  }

  // Parent method om te updaten
  void updateObject() {
    if (gameOver.gameOver) {
      position.x = width + 2*boxWidth;
    }
    if (collidesWithPlayer(player)) {
      if (!speedBoostActive) {
        currentTime = millis(); // Geef begintijd mee voor het meten van de duration van de speed boost
        speedBoostActive = true;
        previousSpeed = (int) background.speed; // Sla de vorige/huidige snelheid op zodat die later teruggezet kan worden
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
      if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) { // Als de boss in het scherm is, beweeg hem uit het scherm
        moveEntity();
      }
    }
    timerThread();
    if (speedBoostActive) { 
      if (player.airBorne && background.speed != previousSpeed) { // Als de speler in de lucht is, zet zijn snelheid naar de normale snelheid ipv de speedboost
        background.speed = previousSpeed;
      } else if (!player.airBorne && background.speed != boostSpeed) { // Als de speler op de grond is, zet zijn snelheid terug op de speedboost snelheid
        background.speed = boostSpeed;
      }
    }
  }

  // Parent method
  void pressedKey() {
  }

  // Parent method
  void releasedKey() {
  }

  // Timer method die alle timers bijhoud
  void timerThread() {
    if (currentTime + WAIT_TIME < millis()) { // Timer voor de duration van de speedboost
      if (speedBoostActive) {
        speedBoostActive = false; 
        background.speed = characterSelect.getSpeed(); // Zet snelheid terug naar de originele snelheid
        despawnTime = millis();
      }
    }
    if (despawnTime + SPAWN_WAIT_TIME < millis() && !spawned) { // Timer voor het respawnen van de boost
      spawned = true;
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
    }
  }

  // Loop de boost
  void loopCoffee() {
    if (position.x + boxWidth < 0 && spawned) { // Als de boost volledig buiten het scherm is, ...
      despawnTime = millis(); // ...geef de begintijd mee voor de timer.
      spawned = false;
    }
  }
}
