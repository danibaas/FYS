class Fireball extends Collider {
  PVector normalAttack, specialAttack;
  int fireballWidth, fireballHeight, fireballSpecialWidth, fireballSpecialHeight, speed;
  final int START_POSITION = ceil(player.position.x + player.playerWidth / 2);
  boolean special, hasFired, shotByPlayer;
  final int PARTICLE_X_MIN = 1;
  final int PARTICLE_X_MAX = 10;
  final int PARTICLE_Y_MIN = 1;
  final int PARTICLE_Y_MAX = 5;
  final int PARTICLE_SIZE_MIN = 1;
  final int PARTICLE_SIZE_MAX = 10;

  Fireball(PVector attack, int fireballWidth, int fireballHeight, int speed) {
    super(attack, fireballWidth, fireballHeight);
    normalAttack = attack;
    this.fireballWidth = fireballWidth;
    this.fireballHeight = fireballHeight;
    this.speed = speed;
    special = false;
  }

  Fireball(PVector attack, int fireballSpecialWidth, int fireballSpecialHeight, int speed, boolean special) {
    super(attack, fireballSpecialWidth, fireballSpecialHeight);
    specialAttack = attack;
    this.fireballSpecialWidth = fireballSpecialWidth;
    this.fireballSpecialHeight = fireballSpecialHeight;
    this.speed = speed;
    this.special = special;
  }

  void drawFireball() {
    if (special) {
      image(fireBallSpecial, specialAttack.x, specialAttack.y, fireballSpecialWidth, fireballSpecialHeight);
    } else {
      image(fireBall, normalAttack.x, normalAttack.y, fireballWidth, fireballHeight);
    }
  }

  void updateFireball() {
    if (!hasFired) {
      collisionList.remove(this);
    } else {
      collisionList.add(this);
    }
  }

  void move() {
    for (Collider collider : collisionList) {
      if (collides(collider) && collider instanceof Enemy) {
        enemy.enemyGotHurt = true;
        enemy.timer = millis();
        if (enemy.enemyGotHurt) {
          for (int i = 0; i < 55; i++) {
            shootParticles.add(new particle(enemy.position.x, enemy.position.y+PARTICLE_OFFSET, -random(PARTICLE_X_MIN, PARTICLE_X_MAX), -random(PARTICLE_Y_MIN, PARTICLE_Y_MAX), random(PARTICLE_SIZE_MIN, PARTICLE_SIZE_MAX),PARTICLE_LIFE));
          }
          if (shootParticles.size()>20) { 
            enemy.position.x = (int) random(enemy.RESPAWN_MIN, enemy.RESPAWN_MAX);
          }
        }
        // enemy.position.x = (int) random(enemy.RESPAWN_MIN, enemy.RESPAWN_MAX);
        highScore.highScore += 20;
        resetAttack();
      }
      if (collides(collider) && collider instanceof Boss) {
        boss.healthbar.removeHealth(1);
        resetAttack();
      }
    }
    if (hasFired) {
      if (normalAttack != null) {
        normalAttack.x += speed;
      }
    }
    if (special) {
      specialAttack.y += speed;
      if (specialAttack.y > 600) {
        resetAttack();
      }
    } else {
      if (normalAttack != null && normalAttack.x >= width) {
        resetAttack();
      }
    }
  }

  void resetAttack() {
    if (!special) {
      hasFired = false;
      normalAttack.x = START_POSITION;
    } else {
      special = false;
      specialAttack.y = -50;
    }
  }

  void setSpecial(boolean specialA) {
    special = specialA ? true : false;
  }

  boolean getSpecial() {
    return special;
  }
}
