class Enemy extends Collider implements Updater {
  int timer;
  final int WAIT_TIME = 5000;
  final int RESPAWN_MIN = 1800;
  final int RESPAWN_MAX = 2100;
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
    if (!healthbar.isDead && canWalk()) {
      moveEntity();
    }
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
    enemyAttack.drawAttack();
    image(skinEnemy, position.x, position.y);
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = true;
      }
    }
  }

  void releasedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = false;
      }
    }
  }

  void checkDead() {
    if (healthbar != null) {
      if (healthbar.isDead) {
        if (canWalk()) {
          if (!boss.spawnBoss) {
            healthbar.isDead = false;
            healthbar.currentLives = 1;
          }
        }
      }
    }
  }

  void loopEnemy() {
    if (position.x + boxWidth < 0 && canWalk()) {
      timer = millis(); 
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
      healthbar.currentLives = 1;
    }
  }

  boolean canWalk() {
    boolean walk = false;
    if (timer + WAIT_TIME < millis() && keys[2]) {
      walk = true;
    }
    return walk;
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
