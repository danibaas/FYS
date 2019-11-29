class Boss extends Collider implements Updater {
  boolean spawnBoss = false;
  boolean hasBeenHit, isDead, getXPBonus, bossOnScreen;
  float bossScore = 20;
  Healthbar healthbar;
  //int timer;
  //int waitTime = 3000;

  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
    healthbar = new Healthbar(8);
  }

  void drawObject() {
    fill(255);
    if (healthbar.currentLives > 0) {
      rect(position.x, position.y, boxWidth, boxHeight);
    } 
    if(bossOnScreen){
      healthbar.drawBossHealth();
    }
  }

  void updateObject() {
    bossOnScreen = (position.x < width && position.x > 0) ? true : false;
    if (position.x >= 1000) {
      moveEntity();
    }
    if (highScore.highScore > bossScore && spawnBoss == false) {
      spawnBoss = true;
      position.x = random(1800, 2000);
      if (bossOnScreen) {
        getXPBonus = false;
      }
    }
    if (healthbar.currentLives == 0) {
      spawnBoss = false;
      if (!getXPBonus) {
        bossScore+=100;
        healthbar.currentLives = 8;
        highScore.highScore += 60;
        getXPBonus = true;
      }
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
