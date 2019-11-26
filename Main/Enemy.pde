class Enemy extends Collider implements Updater {
  int timer, waitTime = 3000;
  float enemyAttackY, enemyAttackWidth = 20, enemyAttackHeight = 20, enemyAttackX = position.x;
  boolean enemyCanAttack, attack, fired, enemyGotHurt;
  Healthbar healthbar;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    timer = millis();
    healthbar = new Healthbar(1);
    updateList.add(this);
  }

  void updateObject() {
    if (gameOver.gameOver) {
      position.x = enemy.position.x = random(1500, 1700);
    }
    checkDead();
    //enemyAttack();
    if (healthbar != null) {
      healthbar.updateEnemyHealth();
    }
    /// player gets damage
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.ENEMY;
      player.healthbar.isDead = true;
    }
    moveEntity();
    //if (!boss.spawnBoss) {
    loopEnemy();
    //}
    if (enemyGotHurt) {
      enemyGotHurt = false;
    }
    if (dist(groundObstacle.position.x + groundObstacle.boxWidth/2, groundObstacle.position.y, enemy.position.x - enemy.boxWidth/2, enemy.position.y) < 200) {
      enemy.position.x = groundObstacle.position.x + groundObstacle.boxWidth + 200;
    }
    if (player.position.x - position.x > -1050) {
      enemyCanAttack = true;
    } else {
      enemyCanAttack = false;
    }
    if (enemyCanAttack) {
      enemyAttackY = position.y;
      attack = true;
      if (coffeePickup.speedBoostActive) {
        enemyAttackX -= background.speed+5;
      } else {
        enemyAttackX -= background.speed+5;
      }
    } else {
      enemyAttackX = position.x - 50;
    }
    if (enemyAttackX < player.position.x + player.playerWidth/2 && enemyAttackY < player.position.y + player.playerHeight/2 && enemyAttackY> player.position.y - player.playerHeight/2) {
      player.healthbar.isDead = true;
    }
    if (enemyAttackX < 0) {
      attack = false;
      enemyAttackX = position.x-50;
    }
  } 

  void drawObject() {
    if (healthbar != null) {
      healthbar.drawEnemyHealth();
    }
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    if (attack) {
      fill(0, 0, 255);
      rect(enemyAttackX, enemyAttackY, enemyAttackWidth, enemyAttackHeight);
    }
    pushMatrix();
    translate(position.x + 100, position.y);
    scale(-1, 1);
    image(skinEnemy, 0, 0);
    popMatrix();
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void checkDead() {
    if (healthbar != null) {
      if (healthbar.isDead) {
        position.x = width + 2*boxWidth; 
        healthbar.isDead = false;
        healthbar.currentLives = 1;
      }
    }
  }

  void loopEnemy() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = enemy.position.x = random(1500, 1700);
      healthbar.currentLives = 1;
    }
  }
}
