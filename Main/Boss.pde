class Boss extends Collider implements Updater {
  boolean spawnBoss = false;
  boolean hasBeenHit, isDead, bossOnScreen;
  float bossScore = 250, bossVelocity = 3;
  int bossHealth = 21, killBonus = 100;
  Healthbar healthbar;
  BossAttack attack;


  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
    healthbar = new Healthbar(bossHealth);
    attack = new BossAttack(new PVector(position.x, position.y + 20), 60, 30);
  }

  void drawObject() {
    fill(255);
    if (healthbar.currentLives > 0) {
      image(skinBoss, position.x, position.y, boxWidth, boxHeight);
    } 
    if (bossOnScreen && spawnBoss) {
      healthbar.drawBossHealth();
    }
    attack.drawAttack();
  }

  void updateObject() {
    bossOnScreen = (position.x < width && position.x > 0) ? true : false;
    if (position.x >= 1000) {
      moveEntity();
    }
    if (highScore.highScore > bossScore && !spawnBoss) {
      spawnBoss = true;
      attack.spawn = millis();
      position.x = 2000;
    }
    if (healthbar.currentLives == 0) {
      spawnBoss = false;
      bossScore += bossScore + killBonus;
      highScore.highScore += killBonus;
      healthbar.currentLives = bossHealth;
    }
    if (!spawnBoss) {
      position.x = -999;
    }
    if (bossOnScreen) {
      moveBoss();
    }
    healthbar.updateBossHealth();
    attack.shoot();
  }

  void moveBoss() {
    position.y -= bossVelocity;
    if (position.y < 100) {
      bossVelocity *= -1;
    } else if (position.y > 500) {
      bossVelocity *= -1;
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  class BossAttack extends Collider {
    PVector attackPos;
    float attackWidth, attackHeight;
    int timer, spawn;
    final int WAIT_TIME = 2000, DELAY = 5000, SPEED_INCREMENT = 3;

    BossAttack(PVector attackPos, float boxWidth, float boxHeight) {
      super(attackPos, boxWidth, boxHeight);
      this.attackPos = attackPos;
      attackWidth = boxWidth;
      attackHeight = boxHeight;
    }

    void drawAttack() {
      if (canAttack()) {
        // draw
        noStroke();
        image(enemyWeapon, attackPos.x, attackPos.y, attackWidth, attackHeight);
      }
    }

    void shoot() {
      if (canAttack()) {
        PVector playerPosition = player.playerVector;
        if (keys[2]) {
          attackPos.x -= SPEED_INCREMENT * 2;
        } else {
          attackPos.x -= SPEED_INCREMENT;
        }
        if (attackPos.x + boxWidth > playerPosition.x) {
          if (playerPosition.y < attackPos.y) {
            attackPos.y -= 2;
          } else if (playerPosition.y > attackPos.y) {
            attackPos.y += 2;
          }
        }
      } else {
        attackPos.x = boss.position.x;
      }
      if (attackPos.x + boxWidth < 0) {
        timer = millis();
      }
      if (collidesWithPlayer(player)) {
        player.healthbar.isDead = true;
      }
    }

    boolean canAttack() {
      boolean attack = false;
      if (timer + WAIT_TIME < millis() && checkTime()) {
        attack = true;
      }
      return attack;
    }

    boolean checkTime() {
      boolean time = false;
      if (spawn + DELAY < millis()) {
        time = true;
      }
      return time;
    }
  }
}
