class Fireball {
  PImage fb;
  PImage fbs;
  int xA;
  int xS;
  int yA;
  int yS;
  int fbWidth;
  int fbHeight;
  int fbsWidth;
  int fbsHeight;
  int speed;
  boolean special;
  boolean hasFired = false;

  Fireball(PImage fb, int xA, int yA, int fbWidth, int fbHeight, int speed) {
    this.fb = fb;
    this.xA = xA;
    this.yA = yA;
    this.fbWidth = fbWidth;
    this.fbHeight = fbHeight;
    this.speed = speed;
    special = false;
  }

  Fireball(PImage fbs, int xS, int yS, int fbsWidth, int fbsHeight, int speed, boolean special) {
    this.fbs = fbs;
    this.xS = xS;
    this.yS = yS;
    this.fbsWidth = fbsWidth;
    this.fbsHeight = fbsHeight;
    this.speed = speed;
    this.special = special;
  }

  void drawFireball() {
    if (special) {
      image(fbs, xS, yS, fbsWidth, fbsHeight);
    } else {
      image(fb, xA, yA, fbWidth, fbHeight);
    }
  }
  
  void collision(){
    //println (enemy.health);
      if (enemy.position.x + enemy.boxWidth > xA && enemy.position.x < xA + fbWidth && enemy.position.y < yA) {
      enemy.health -=10;
      characterAttack.canAttack = false;
      hasFired = false;
      xA = 140;
    }
  }

  void move() {
    collision();
    if (characterAttack.canAttack == true) {
      xA += speed;
    }
    if (special == true) {
      yS += speed;
    }
    /*if (xA>1280 && !special) {
      characterAttack.canAttack = false;
      xA = 140;
      hasFired = false;
    }*/
    if (yS>600) {
      special = false;
      yS = -50;
    }
  }

  void setSpecial(boolean specialA) {
    special = specialA ? true : false;
  }

  boolean getSpecial() {
    return special;
  }
}
