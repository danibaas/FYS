class Healthbar {
  PImage stroopwafel;
  int maxLives;
  int currentLives;
  private boolean clickedLastFrame = false;
  boolean dead = false;
  boolean removeAHealth = false;
  boolean addAHealth = false;


  Healthbar(int currentLives) {
    this.currentLives = currentLives;
    stroopwafel = loadImage(sketchPath() + "/lib/stroopwafel.jpg");
    stroopwafel.resize(35, 35);
  }

  void updatePlayerHealth() {
    //When character selected get the lives
    //if (characterSelect.choseDonDon && !getHealth && characterSelect.hasChosen) {
    //  getHealth = true;
    //  maxLives = 6;
    //  currentLives = 6;
    //} else if (characterSelect.choseCorra && !getHealth && characterSelect.hasChosen) {
    //  getHealth = true;
    //  maxLives = 4;
    //  currentLives = 4;
    //}
    if (characterSelect.choseDonDon) {
      if (highScore.highScore > 50 && highScore.highScore < 100) {
        maxLives = 5;
      } else if (highScore.highScore > 100 && highScore.highScore < 150) {
        maxLives = 4;
      } else if (highScore.highScore > 150) {
        maxLives = 3;
      }
      if (currentLives > maxLives) {
        currentLives = maxLives;
      }
    }
    if (characterSelect.choseCorra) {
      if (highScore.highScore > 75 && highScore.highScore < 150) {
        maxLives = 3;
      } else if (highScore.highScore > 150) {
        maxLives = 2;
      } 
      if (currentLives > maxLives) {
        currentLives = maxLives;
      }
    }
  }

  void drawPlayerHealth() {
    //Box of lives
    fill(255);
    strokeWeight(3);
    rect(-10, -10, 10 + 40 * currentLives, 60);

    int lifeOffset = 0;
    for (int iLives = 0; iLives < currentLives; iLives++) {
      image(stroopwafel, lifeOffset, 5);
      lifeOffset += 40;
    }
    // display gameover screen
    if (dead) {
      gameOver.drawObject();
    }
  }

  void updateEnemyHealth() {
    if (enemy.enemyGotHurt && currentLives > 0) {
      currentLives-=1;
      enemy.enemyGotHurt = false;
    }
    if (currentLives<=0) {
      dead = true;
    }
  }

  void drawEnemyHealth() {
    fill(255, 0, 0);
    for (int iEnemy = 0; iEnemy<currentLives; iEnemy++) {
      rect(enemy.position.x+25*iEnemy, enemy.position.y, enemy.boxWidth/4, enemy.boxHeight-120);
    }
  }

  void updateBossHealth() {
    if (boss.bossGotHurt && currentLives>0) {
      currentLives-=1;
      boss.bossGotHurt =false;
    } 
    if (currentLives<=0) {
      boss.bossIsDead=true;
    }
  }

  void drawBossHealth() {
    fill(255, 0, 0);
    for (int iBoss=0; iBoss<currentLives; iBoss++) {
      fill(255, 0, 0);
      rect(boss.position.x, boss.position.y, boss.boxWidth, boss.boxHeight);
    }
  }

  void pressedKeyHealth() {
    //Press 'd' to take damage
    if (keyPressed && key == 'd') {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        removeHealth();
      }
    }
    //Press 'e' to eat a stroopwafel
    if (keyPressed && key == 'e') {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        addHealth();
      }
    }
  }

  void releasedKeyHealth() {
    clickedLastFrame = false;
    removeAHealth = false;
    addAHealth = false;
  }

  void removeHealth() {
    if (!removeAHealth && !dead) {
      removeAHealth = true;
      if (currentLives > 0) {
        currentLives--;
      } 
      if (currentLives == 0) {
        dead = true;
      }
    }
  }

  boolean addHealth() {
    boolean added = false;
    if (!addAHealth && !dead) {
      addAHealth = true;
      if (currentLives < maxLives && !dead) {
        currentLives++;
        added = true;
      }
    }
    return added;
  }
}
