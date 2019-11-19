class Enemy extends Collider implements Updater {
  int timer;
  int waitTime = 3000;
  float enemyAttackY, enemyAttackWidth, enemyAttackHeight;
  float enemyAttackX = position.x;
  boolean enemyGotHurt;
  Healthbar healthbar;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    timer = millis();
    healthbar = new Healthbar(1);
    updateList.add(this);
  }

  void updateObject() {
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

      enemyGotHurt=false;
    }
    if (dist(office.position.x+office.boxWidth/2, office.position.y, enemy.position.x - enemy.boxWidth/2, enemy.position.y) < 200) {
      enemy.position.x = office.position.x + office.boxWidth + 200;
    }
  } 

  void drawObject() {
    if (healthbar != null) {
      healthbar.drawEnemyHealth();
    }
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    rect(enemyAttackX, enemyAttackY, enemyAttackWidth, enemyAttackHeight);
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
    if (healthbar != null && healthbar.isDead) {
      position.x = width + 2*boxWidth; 
      healthbar.isDead = false;
      healthbar.currentLives = 1;
    }
  }

  void loopEnemy() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = enemy.position.x = random(1500, 1700);
      healthbar.currentLives = 1;
    }
  }

  void enemyAttack() {
    enemyAttackY = position.y;
    enemyAttackWidth = 50;
    enemyAttackHeight = 50;
    if (position.x - player.position.x > 100) {
      enemyAttackX -= 5;
    } else {
      enemyAttackX = position.x;
    }
    if (enemyAttackX < 0) {
      enemyAttackX = position.x;
    }

    if (player.position.x + player.boxWidth > enemyAttackX && enemy.position.x < enemyAttackX + enemyAttackWidth && player.position.y < enemyAttackY) {
      enemyAttackX = position.x;
    }
    if (office.position.x + office.boxWidth > enemyAttackX && office.position.x < enemyAttackX + enemyAttackWidth && office.position.y < enemyAttackY) {
      enemyAttackX = position.x;
    }

    if (enemyAttackX < player.position.x + player.playerWidth/2 && enemyAttackY < player.position.y + player.playerHeight/2 && enemyAttackY> player.position.y - player.playerHeight/2) {
    }
  }
}
