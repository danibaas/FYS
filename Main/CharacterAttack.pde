class CharacterAttack {
  PImage fireBall;
  PImage fireBallSpecial;
  ArrayList<Fireball> fireballs = new ArrayList();
  Fireball a;

  void loadAttack() {
    fireBall = loadImage("Fireball.jpg");
    fireBallSpecial = loadImage("FireballSpecial.jpg");
    a = new Fireball(fireBall, 0, 500, fireBall.width/4, fireBall.height/4, 2);
    int yPos = -50;
    int xPos = 0;
    for (int i=0; i<39; i++) {
      Fireball s = new Fireball(fireBallSpecial, xPos, yPos, fireBallSpecial.width/4, fireBallSpecial.height/4, 2, false);
      xPos+=33;
      fireballs.add(s);
    }
  }

  void drawAttack() {
    if (attack == true) {
      a.drawFireball();
      a.move();
    }
    //if (specialAttack == true) {
    for (Fireball s : fireballs) {
      if (s.getSpecial()) {
        s.drawFireball();
        s.move();
      }
    }
    // }
  }


  boolean clickedLastFrame = false;
  boolean attack = false;

  void pressed() {
    //Activate normale attack by pressing 'a'
    if (keyPressed == true && key == 'a') {
      if (clickedLastFrame == false) {
        attack = true;
        clickedLastFrame = true;
      }
    }
    //Activate speciale attack by pressing 's'
    if (keyPressed == true && key == 's') {
      if (clickedLastFrame == false) {
        clickedLastFrame = true;
        for (Fireball b : fireballs) {
          b.setSpecial(true);
        }
      }
    }
  }

  void released() {
    clickedLastFrame = false;
  }

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

    void move() {
      if (attack == true) {
        xA += 5;
      }
      if (special == true) {
        yS+=5;
      }
      if (xA>1280) {
        attack = false;
        xA=0;
      }
      if (yS>600) {
        special = false;
        yS=0;
      }
      println(yS, xA);
    }

    void setSpecial(boolean specialA) {
      special = specialA ? true : false;
    }

    boolean getSpecial() {
      return special;
    }
  }
}
