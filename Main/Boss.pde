class Boss extends Collider implements Updater {
  boolean spawnBoss = false;
  boolean hasBeenHit, isDead, getXPBonus;
  float bossScore = 20;
  Healthbar healthbar;
  //int timer;
  //int waitTime = 3000;

  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
    healthbar = new Healthbar(2);
  }

  void drawObject() {
    fill(255);
    if (healthbar.currentLives > 0) {
      rect(position.x, position.y, boxWidth, boxHeight);
    } else {
    }
    healthbar.drawBossHealth();
  }

  void updateObject() {
    if (position.x >= 1000) {
      moveEntity();
    }
    if (highScore.highScore > bossScore && spawnBoss == false) {
      spawnBoss = true;
      position.x = random(1800, 2000);
    }
    if (healthbar.currentLives == 0) {
      spawnBoss = false;
    }
    if (healthbar.currentLives == 0 && !getXPBonus) {
      getXPBonus = true;
      highScore.highScore += 60;
    }
    if (!spawnBoss) {
      position.x = -999;
    }
    healthbar.updateBossHealth();
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
