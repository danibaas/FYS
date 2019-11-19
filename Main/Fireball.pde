class Fireball extends Collider {
  PVector normalAttack;
  PVector specialAttack;
  int fireballWidth;
  int fireballHeight;
  int fireballSpecialWidth;
  int fireballSpecialHeight;
  final int START_POSITION = ceil(player.position.x + player.playerWidth / 2);
  int speed;
  boolean special;
  boolean hasFired = false;
  boolean shotByPlayer = false;

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
        resetAttack();
      }
      if (collides(collider) && collider instanceof Boss) {
        boss.hasBeenHit = true;
        resetAttack();
      }
    }
    if (characterAttack.canAttack) {
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
      if (normalAttack != null && normalAttack.x > width) {
        resetAttack();
      }
    }
  }

  void resetAttack() {
    if (!special) {
      characterAttack.canAttack = false;
      normalAttack.x = START_POSITION;
      hasFired = false;
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
