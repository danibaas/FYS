class Fireball extends Collider {
  PImage fireball;
  PImage fireballSpecial;
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

  Fireball(PImage fireball, PVector attack, int fireballWidth, int fireballHeight, int speed) {
    super(attack, fireballWidth, fireballHeight);
    normalAttack = attack;
    this.fireball = fireball;
    this.fireballWidth = fireballWidth;
    this.fireballHeight = fireballHeight;
    this.speed = speed;
    special = false;
  }

  Fireball(PImage fireballSpecial, PVector attack, int fireballSpecialWidth, int fireballSpecialHeight, int speed, boolean special) {
    super(attack, fireballSpecialWidth, fireballSpecialHeight);
    specialAttack = attack;
    this.fireballSpecial = fireballSpecial;
    this.fireballSpecialWidth = fireballSpecialWidth;
    this.fireballSpecialHeight = fireballSpecialHeight;
    this.speed = speed;
    this.special = special;
  }

  void drawFireball() {
    if (special) {
      image(fireballSpecial, specialAttack.x, specialAttack.y, fireballSpecialWidth, fireballSpecialHeight);
    } else {
      image(fireball, normalAttack.x, normalAttack.y, fireballWidth, fireballHeight);
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
        enemy.enemyGotHurt=true;
        resetAttack();
      }
    }
    if (characterAttack.canAttack) {
      normalAttack.x += speed;
    }
    if (special) {
      specialAttack.y += speed;
      if (specialAttack.y > 600) {
        resetSpecialAttack();
      }
    } else {
      if (normalAttack.x > width) {
        resetAttack();
      }
    }
  }

  void resetAttack() {
    characterAttack.canAttack = false;
    normalAttack.x = START_POSITION;
    hasFired = false;
  }
  void resetSpecialAttack() {
    special = false;
    specialAttack.y = -50;
  }

  void setSpecial(boolean specialA) {
    special = specialA ? true : false;
  }

  boolean getSpecial() {
    return special;
  }
}
