class Enemy extends Collider implements Updater {
  int timer, waitTime = 3000;
  boolean enemyGotHurt;
  Healthbar healthbar;
  EnemyAttack enemyAttack;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    timer = millis();
    healthbar = new Healthbar(1);
    enemyAttack = new EnemyAttack(new PVector(position.x, position.y + 15), 60, 30);
    updateList.add(this);
  }

  void updateObject() {
    enemyAttack.attack();
    if (gameOver.gameOver) {
      position.x = enemy.position.x = random(1500, 1700);
    }
    checkDead();
    if (healthbar != null) {
      healthbar.updateEnemyHealth();
    }
    /// player gets damage
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.ENEMY;
      player.healthbar.isDead = true;
    }
    moveEntity();
    if (!boss.spawnBoss) {
      loopEnemy();
    }
    if (enemyGotHurt) {
      enemyGotHurt = false;
    }
    if (dist(groundObstacle.position.x + groundObstacle.boxWidth/2, groundObstacle.position.y, enemy.position.x - enemy.boxWidth/2, enemy.position.y) < 200) {
      enemy.position.x = groundObstacle.position.x + groundObstacle.boxWidth + 200;
    }
  } 

  void drawObject() {
    if (healthbar != null) {
      healthbar.drawEnemyHealth();
    }
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    enemyAttack.drawAttack();
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
        if (!boss.spawnBoss) {
          healthbar.isDead = false;
          healthbar.currentLives = 1;
        }
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

  class EnemyAttack extends Collider {
    float attackWidth, attackHeight;
    PVector enemyPos;
    boolean enemyCanAttack, attack;

    EnemyAttack(PVector enemyPos, float boxWidth, float boxHeight) {
      super(enemyPos, boxWidth, boxHeight);
      this.enemyPos = enemyPos;
      attackWidth = boxWidth;
      attackHeight = boxHeight;
    }


    void attack() {
      if (player.position.x - enemy.position.x > -1050) {
        enemyCanAttack = true;
      } else {
        enemyCanAttack = false;
      }
      if (enemyCanAttack) {
        enemyPos.y = enemy.position.y;
        attack = true;
        if (coffeePickup.speedBoostActive) {
          enemyPos.x -= background.speed+5;
        } else {
          enemyPos.x -= background.speed+5;
        }
      } else {
        enemyPos.x = enemy.position.x - 50;
      }
      if (collidesWithPlayer(player)) {
        player.healthbar.isDead = true;
      }
      if (enemyPos.x < 0) {
        attack = false;
        enemyPos.x = enemy.position.x-50;
      }
    }

    void drawAttack() {
      if (attack) {
        noStroke();
        image(enemyWeapon, enemyPos.x, enemyPos.y, attackWidth, attackHeight);
      }
    }
  }
}
