class CharacterAttack {
  PImage fireBall;
  PImage fireBallSpecial;
  ArrayList<Fireball> fireballs = new ArrayList();
  Fireball attack;
  private boolean clickedLastFrame = false;
  private boolean canAttack = false;
  private boolean ready = false;
  int timer;

  void loadAttack() {
    fireBall = loadImage("Fireball.jpg");
    fireBallSpecial = loadImage("FireballSpecial.jpg");
    attack = new Fireball(fireBall, 0, 500, fireBall.width/4, fireBall.height/4, 2);
    int yPos = -50;
    int xPos = 0;
    for (int i=0; i<39; i++) {
      Fireball specials = new Fireball(fireBallSpecial, xPos, yPos, fireBallSpecial.width/4, fireBallSpecial.height/4, 2, false);
      xPos+=33;
      fireballs.add(specials);
    }
  }

  void drawAttack() {
    if (canAttack == true) {
      attack.drawFireball();
      attack.move();
    }
    for (Fireball s : fireballs) {
      if (s.getSpecial()) {
        s.drawFireball();
        s.move();
      }
    }
  }

  void drawBeam() {
    if (ready) {
      fill(0, 255, 0);
      rect(400, 0, 400, 50);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text("SPECIAL READY!!!!!!", 600, 25);
    }
    if (!ready) {
      fill(255, 0, 0);
      rect(400, 0, 400, 50);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text("SPECIAL NOT READY!!!!!!", 600, 25);
    }
    //special is ready om de 3 seconden
    if (frameCount - timer >=180) {
      ready = true;
    }
  }

  void pressed() {
    //Activate normal attack by pressing 'a'
    if (keyPressed == true && key == 'a') {
      if (clickedLastFrame == false) {
        canAttack = true;
        clickedLastFrame = true;
      }
    }
    //Activate special attack by pressing 's'
    if (keyPressed == true && key == 's') {
      if (clickedLastFrame == false) {
        clickedLastFrame = true;
        ready = false;
        timer = frameCount;
        for (Fireball s : fireballs) {
          s.setSpecial(true);
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
      if (canAttack == true) {
        xA += 5;
      }
      if (special == true) {
        yS += 5;
      }
      if (xA>1280 && !special) {
        canAttack = false;
        xA = 0;
      }
      if (yS>600) {
        special = false;
        yS = 0;
      }
    }

    void setSpecial(boolean specialA) {
      special = specialA ? true : false;
    }

    boolean getSpecial() {
      return special;
    }
  }
}
