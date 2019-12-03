class Boss extends Collider implements Updater {
  boolean spawnBoss = false;
  boolean hasBeenHit, isDead, bossOnScreen;
  float bossScore = 10;
  int bossHealth = 8, killBonus = 60;
  Healthbar healthbar;


  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
    healthbar = new Healthbar(bossHealth);
  }

  void drawObject() {
    fill(255);
    if (healthbar.currentLives > 0) {
      rect(position.x, position.y, boxWidth, boxHeight);
      image(skinBoss, position.x, position.y, boxWidth, boxHeight);
    } 
    if (bossOnScreen && spawnBoss) {
      healthbar.drawBossHealth();
    }
    //println(bossScore);
  }

  void updateObject() {
    bossOnScreen = (position.x < width && position.x > 0) ? true : false;
    if (position.x >= 1000) {
      moveEntity();
    }
    if (highScore.highScore > bossScore && spawnBoss == false) {
      spawnBoss = true;
      position.x = 2000;
    }
    if (healthbar.currentLives == 0) {
      spawnBoss = false;
      bossScore += bossScore + killBonus;
      highScore.highScore += killBonus;
      healthbar.currentLives = bossHealth;
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
