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
    attack = new Fireball(fireBall, new PVector(ceil(player.position.x + player.playerWidth/2), yAttack), fireBall.width/4, fireBall.height/4, fireballSpeed);
    attack.shotByPlayer = true;
    int yPos = -50;
    int xPos = 0;
    for (int i = 0; i < 39; i++) {
      Fireball specials = new Fireball(fireBallSpecial, new PVector(xPos, yPos), fireBallSpecial.width/4, fireBallSpecial.height/4, fireballSpeed, true);
      xPos += 33;
      specials.shotByPlayer = true;
      fireballs.add(specials);
    }
    updateList.add(this);
  }

  void updateObject() {
    yAttack = (int) player.playerVector.y;
    if (!attack.hasFired) {
      attack.normalAttack.y = yAttack;
    }
    attack.updateFireball();
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
    if (frameCount - timer >= timeToWait) {
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
}
