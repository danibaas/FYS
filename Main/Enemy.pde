class Enemy extends Collider implements Updater {
  PImage skin;
  int timer;
  int waitTime = 3000;
  boolean removedHealthLastFrame = false;
  int healthTimer;
  int holdRemove = 1000;
  float enemyAttackY, enemyAttackWidth, enemyAttackHeight;
  float enemyAttackX=position.x;
  boolean enemyGotHurt;
  Healthbar healthbar;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    skin = loadImage(sketchPath() + "/assets/images/enemy.png");
    skin.resize((int) boxWidth + 10, (int) boxHeight + 10);
    timer = millis();
    healthbar = new Healthbar(4);
    updateList.add(this);
  }

  void updateObject() {
    checkDead();
    //enemyAttack();
    if (healthbar !=null) {
      healthbar.updateEnemyHealth();
    }
    /// player gets damage
    if (collidesWithPlayer(player) && !removedHealthLastFrame) {
      player.colliderType = ColliderType.ENEMY;
      player.healthbar.removeHealth();
      removedHealthLastFrame = true;
      healthTimer = millis();
    }
    moveEntity(false);
    //if (!boss.spawnBoss) {
    loopEnemy();
    //}
    if (healthTimer + holdRemove < millis()) {
      removedHealthLastFrame = false;
    }
    if (enemyGotHurt) {

      enemyGotHurt=false;
    }
    if (dist(office.position.x+office.boxWidth/2, office.position.y, enemy.position.x - enemy.boxWidth/2, enemy.position.y) < 200) {
      enemy.position.x = office.position.x + office.boxWidth + 200;
    }
  } 

  void drawObject() {
    if (healthbar !=null) {
      healthbar.drawEnemyHealth();
    }
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    rect(enemyAttackX, enemyAttackY, enemyAttackWidth, enemyAttackHeight);
    pushMatrix();
    translate(position.x + 100, position.y);
    scale(-1, 1);
    image(skin, 0, 0);
    popMatrix();
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void checkDead() {
    if (healthbar !=null) {
      if (healthbar.dead) {
        position.x = width + 2*boxWidth; 
        healthbar.dead = false;
        healthbar.currentLives=4;
      }
    }
  }

  void loopEnemy() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = enemy.position.x = random(1500, 1700);
      healthbar.currentLives = 4;
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
      healthbar.removeHealth();
    }
  }
}
