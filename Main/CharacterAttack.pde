class CharacterAttack implements Updater {
  PImage fireBall;
  PImage fireBallSpecial;
  ArrayList<Fireball> fireballs = new ArrayList();
  Fireball attack;
  private boolean clickedLastFrame = false;
  private boolean canAttack = false;
  private boolean ready = false;
  private int timer; 
  int timeToWait = 1800; //how long it takes for special to get ready devide this number with 60 then you get the seconds you have to wait
  int countDown = timeToWait;
  int yAttack;
  int fireballSpeed = 5;

  CharacterAttack() {
    fireBall = loadImage(sketchPath() + "/lib/Fireball.jpg");
    fireBallSpecial = loadImage(sketchPath() + "/lib/FireballSpecial.jpg");
    attack = new Fireball(fireBall, 140, yAttack, fireBall.width/4, fireBall.height/4, fireballSpeed);
    int yPos = -50;
    int xPos = 0;
    for (int i=0; i<39; i++) {
      Fireball specials = new Fireball(fireBallSpecial, xPos, yPos, fireBallSpecial.width/4, fireBallSpecial.height/4, fireballSpeed, false);
      xPos+=33;
      fireballs.add(specials);
    }
    updateList.add(this);
  }

  void updateObject() {
    yAttack = (int) player.playerVector.y;
    if (!attack.hasFired) {
      attack.yA = yAttack;
    }
  }

  void drawObject() {
    if (canAttack) {
      attack.drawFireball();
      attack.move();
    }
    for (Fireball s : fireballs) {
      if (s.getSpecial()) {
        s.drawFireball();
        s.move();
      }
    }
    if (ready) {
      fill(0, 255, 0);
      rect(0, 50, 250, 35);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text("SPECIAL READY", 125, 75);
    }
    if (!ready) {
      fill(255, 0, 0);
      rect(0, 50, 250, 35);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text("SPECIAL NOT READY", 140, 75);
      textAlign(LEFT);
      countDown--;
      text(countDown/60, 5, 75);
      textAlign(CENTER);
    }
    //special is ready om de 10 seconden
    if (frameCount - timer >=timeToWait) {
      ready = true;
    }
  }

  void pressedKey() {
    //Activate normal attack by pressing 'a'
    if (keyPressed && key == 'a') {
      if (!clickedLastFrame) {
        canAttack = true;
        clickedLastFrame = true;
        attack.hasFired = true;
      }
    }
    //Activate special attack by pressing 's'
    if (keyPressed && key == 's' && ready) {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        ready = false;
        timer = frameCount;
        countDown = timeToWait;
        for (Fireball s : fireballs) {
          s.setSpecial(true);
        }
      }
    }
  }

  void releasedKey() {
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

    void move() {
      if (canAttack == true) {
        xA += speed;
      }
      if (special == true) {
        yS += speed;
      }
      if (xA>1280 && !special) {
        canAttack = false;
        xA = 140;
        hasFired = false;
      }
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
}
