class Healthbar {
  int maxLives, currentLives;
  boolean isDead;

  Healthbar(int currentLives) {
    this.currentLives = currentLives;
  }

  void updatePlayerHealth() {
    if (isDead) {
      gameOver.drawObject();
    }
  }

  void updateEnemyHealth() {
    if (enemy.enemyGotHurt && currentLives > 0) {
      currentLives -= 1;
      enemy.enemyGotHurt = false;
    }
    if (currentLives <= 0) {
      isDead = true;
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
    }
  }

  void drawBossHealth() {
    fill(255, 0, 0);
    for (int iBoss = 0; iBoss < currentLives; iBoss++) {
      fill(255, 0, 0);
      rect(boss.position.x+25*iBoss, boss.position.y, boss.boxWidth/4, boss.boxHeight-120);
    }
  }
}
