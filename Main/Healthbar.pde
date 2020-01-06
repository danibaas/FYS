class Healthbar {
  int maxLives, currentLives;
  boolean isDead, savedToDatabase, addMetricEnemy, addMetricBoss;

  Healthbar(int currentLives) {
    this.currentLives = currentLives;
  }

  void updatePlayerHealth() {
    if (isDead) {
      gameOver.drawObject();
      if (!savedToDatabase) {
        highScore.saveHighScore(login.playerName, highScore.highScore);
        savedToDatabase = true;
      }
    }
  }

  void updateEnemyHealth() {
    if (enemy.enemyGotHurt && currentLives > 0) {
      currentLives -= 1;
      enemy.enemyGotHurt = false;
    }
    if (currentLives <= 0) {
      isDead = true;
      if (!addMetricEnemy) {
        metrics.enemiesKilled++;
        addMetricEnemy = true;
      }
    }
    if (!isDead) {
      addMetricEnemy = false;
    }
  }

  void drawEnemyHealth() {
    fill(255, 0, 0);
    for (int iEnemy = 0; iEnemy < currentLives; iEnemy++) {
      rect(enemy.position.x+25*iEnemy, enemy.position.y, enemy.boxWidth/4, enemy.boxHeight-120);
    }
  }

  void updateBossHealth() {
    if (boss.hasBeenHit && currentLives > 0) {
      currentLives -= 1;
      boss.hasBeenHit = false;
    } 
    if (currentLives <= 0) {
      boss.isDead = true;
      if (!addMetricBoss) {
        metrics.bossesKilled++;
        addMetricBoss = true;
      }
    }
    if (!isDead) {
      addMetricBoss = false;
    }
  }

  void drawBossHealth() {
    int boxLifeSize = 50;
    int beginPositionX = 100;
    fill(255, 0, 0);
    for (int i = 0; i < currentLives; i++) {
      fill(255, 0, 0);
      if (beginPositionX+boxLifeSize*i == 100 || beginPositionX+boxLifeSize*(currentLives-1) == beginPositionX+boxLifeSize*i) {
        if (beginPositionX+boxLifeSize*i == 100) {
          rect(beginPositionX+boxLifeSize*i, boxLifeSize, boxLifeSize, boxLifeSize, 25, 0, 0, 25);
        } else {
          rect(beginPositionX+boxLifeSize*i, boxLifeSize, boxLifeSize, boxLifeSize, 0, 25, 25, 0);
        }
      } else {
        rect(beginPositionX+boxLifeSize*i, boxLifeSize, boxLifeSize, boxLifeSize);
      }
    }
  }

  void removeHealth(int remove) {
    currentLives -= remove;
    if (currentLives <= 0) {
      isDead = true; 
      currentLives = 0;
    }
  }
}
