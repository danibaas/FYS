class CharacterAttack implements Updater {
  // CONSTANTS
  final int FIREBALL_SPEED = 10;
  final int SPECIAL_SPEED = 20;
  final int SPECIAL_FIREBALL_AMOUNT = 39, NORMAL_FIREBALL_AMOUNT = 3;
  final int TIME_TO_WAIT = 600; //how long it takes for special to get ready divide this number with 60 then you get the seconds you have to wait

  ArrayList<Fireball> fireballs = new ArrayList();
  Fireball[] ammunition;
  boolean clickedLastFrame, ready;
  int timer, yAttack; 

  int countDown = TIME_TO_WAIT;

  CharacterAttack() {
    ammunition = new Fireball[NORMAL_FIREBALL_AMOUNT];
    for (int i = 0; i < NORMAL_FIREBALL_AMOUNT; i++) {
      ammunition[i] = new Fireball(new PVector(ceil(player.position.x + player.playerWidth/2), yAttack), fireBall.width/4, fireBall.height/4, FIREBALL_SPEED);
      ammunition[i].shotByPlayer = true;
    }
    int yPos = -50;
    int xPos = 0;
    for (int i = 0; i < SPECIAL_FIREBALL_AMOUNT; i++) {
      Fireball specials = new Fireball(new PVector(xPos, yPos), fireBallSpecial.width/4, fireBallSpecial.height/4, SPECIAL_SPEED, false);
      xPos += 33;
      specials.shotByPlayer = true;
      fireballs.add(specials);
    }
    updateList.add(this);
  }

  void updateObject() {
    yAttack = (int) player.playerVector.y;
    for (int i = 0; i < NORMAL_FIREBALL_AMOUNT; i++) {
      if (!ammunition[i].hasFired) {
        ammunition[i].normalAttack.y = yAttack;
      }
      ammunition[i].updateFireball();
    }
  }

  void drawObject() {
    for (int i = 0; i < NORMAL_FIREBALL_AMOUNT; i++) {
      if (ammunition[i].hasFired) {
        ammunition[i].drawFireball();
        ammunition[i].move();
      }
    }
    for (Fireball s : fireballs) {
      if (s.getSpecial()) {
        s.drawFireball();
        s.move();
      }
    }
    if (ready) {
      fill(0, 255, 0);
      rect(0, 0, 250, 35);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text("SPECIAL READY", 125, 25);
    }
    if (!ready) {
      fill(255, 0, 0);
      rect(0, 0, 250, 35);
      fill(0);
      textAlign(CENTER);
      textSize(20);
      text("SPECIAL NOT READY", 140, 25);
      textAlign(LEFT);
      countDown--;
      text(countDown/60, 5, 25);
      textAlign(CENTER);
    }
    //special is ready om de 10 seconden
    if (frameCount - timer >= TIME_TO_WAIT) {
      ready = true;
    }
  }

  void pressedKey() {
    //Activate normal attack by pressing 'a'
    if (keyPressed && key == 'a') {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        for (int i = 0; i < NORMAL_FIREBALL_AMOUNT; i++) {
          if (!ammunition[i].hasFired) {
            ammunition[i].hasFired = true;
            break;
          }
        }
      }
    }
    //Activate special attack by pressing 's'
    if (keyPressed && key == 's' && ready) {
      if (!clickedLastFrame) {
        clickedLastFrame = true;
        ready = false;
        timer = frameCount;
        countDown = TIME_TO_WAIT;
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
