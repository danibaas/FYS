class Enemy extends Collider implements Updater {
  int timer;
  final int WAIT_TIME = 5000;
  final int RESPAWN_MIN = 1800;
  final int RESPAWN_MAX = 2100;
  final int ATTACK_POSITION = 15;
  final int ATTACK_WIDTH = 60;
  final int ATTACK_HEIGHT = 30;
  boolean enemyGotHurt;
  Healthbar healthbar;
  EnemyAttack enemyAttack;

//constructor
  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    timer = millis();
    healthbar = new Healthbar(1);
    enemyAttack = new EnemyAttack(new PVector(position.x, position.y + ATTACK_POSITION), ATTACK_WIDTH, ATTACK_HEIGHT);
    updateList.add(this);
  }
// method to update the enemy
  void updateObject() {
    enemyAttack.attack();
    if (gameOver.gameOver) {
      position.x = random(RESPAWN_MIN, RESPAWN_MAX);
    }
    checkDead();
    if (healthbar != null) {
      healthbar.updateEnemyHealth();
    }
    /// player gets damage
    if (collidesWithPlayer(player)) {
      player.healthbar.isDead = true;
    }
    if (!boss.spawnBoss) {
      loopEnemy();
      if (!healthbar.isDead && canWalk()) {
        moveEntity();
      }
    } else {
      if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) {
        moveEntity();
      }
    }
    if (enemyGotHurt) {
      enemyGotHurt = false;
    }
    if (dist(groundObstacle.position.x + groundObstacle.boxWidth/2, groundObstacle.position.y, enemy.position.x - enemy.boxWidth/2, enemy.position.y) < 200) {
      enemy.position.x = groundObstacle.position.x + groundObstacle.boxWidth + 200;
    }
  } 
// method to drow the enemy to the screen
  void drawObject() {
    if (healthbar != null) {
      healthbar.drawEnemyHealth();
    }
    enemyAttack.drawAttack();
    image(skinEnemy, position.x, position.y);
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
// if the enemy is dead, he must respawn at a place further in the level
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
// if you walk past the enemy, he must respawn at a place further in the level
  void loopEnemy() {
    if (position.x + boxWidth < 0 && canWalk()) {
      timer = millis(); 
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
      healthbar.currentLives = 1;
    }
  }
// makes sure you don't run into the enemy instantly when you kill him
  boolean canWalk() {
    boolean walk = false;
    if (timer + WAIT_TIME < millis() && keys[2] && highScore.highScore > 200) {
      walk = true;
    }
    return walk;
  }

  class EnemyAttack extends Collider {
    float attackWidth, attackHeight;
    PVector enemyPos;
    boolean outOfScreen, attack;
    int timer;
    final int WAIT_TIME = 2500;
    final int ATTACK_DISTANCE = -1050;
    final int ATTACK_OFFSET = 50;
//constructor
    EnemyAttack(PVector enemyPos, float boxWidth, float boxHeight) {
      super(enemyPos, boxWidth, boxHeight);
      this.enemyPos = enemyPos;
      attackWidth = boxWidth;
      attackHeight = boxHeight;
    }
// enemy can only attack when he's in the screen
    boolean canAttack() {
      boolean attack = false;
      if (player.position.x - enemy.position.x > ATTACK_DISTANCE && (outOfScreen || !attack) && (timer + WAIT_TIME < millis())) {
        attack = true;
      } else {
        attack = false;
      }
      return attack;
    }
// the attack spawns and moves
    void attack() {
      if (canAttack()) {
        enemyPos.y = enemy.position.y;
        attack = true;
        if (coffeePickup.speedBoostActive) {
          enemyPos.x -= background.speed+5;
        } else {
          enemyPos.x -= background.speed+5;
        }
      } else {
        enemyPos.x = enemy.position.x - ATTACK_OFFSET;
      }
      if (collidesWithPlayer(player)) {
        player.healthbar.isDead = true;
        attack = false;
      }
      if (enemyPos.x < 0) {
        attack = false;
        timer = millis();
        outOfScreen = true;
        enemyPos.x = enemy.position.x-ATTACK_OFFSET;
      } else {
        outOfScreen = false;
      }
    }
// attack is drawn
    void drawAttack() {
      if (attack) {
        noStroke();
        image(enemyWeapon, enemyPos.x, enemyPos.y, attackWidth, attackHeight);
      }
    }
  }
}
