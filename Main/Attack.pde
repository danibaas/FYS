PImage fireBall;
ArrayList<Fireball> fireballs = new ArrayList();
Fireball a;

void setup() {
  size(1280, 720);
  fireBall = loadImage("Fireball.jpg");
  a = new Fireball(fireBall, 0, 500, fireBall.width/4, fireBall.height/4, 2);
  int yPos = -15;
  int xPos = 50;
  for (int i=0; i<39; i++) {
    Fireball b = new Fireball(fireBall, xPos, yPos-(33*i), fireBall.width/4, fireBall.height/4, 2, true);
    fireballs.add(b);
  }
}

void draw() {
  background(0, 127, 0);

  fill(55, 66, 55);
  rect(0, 500, 1280, 100);

  if (attack == true) {
    a.drawFireball();
    a.move();
  }
  if (specialAttack == true) {
    for (Fireball b : fireballs) {
      b.drawFireball();
      b.move();
      if (b.getSpecial()) {
      }
    }
  }
}


boolean clickedLastFrame = false;
boolean attack = false;
boolean specialAttack = false;

void keyPressed() {
  //Activate normale attack
  if (keyPressed == true && key == 'a') {
    if (clickedLastFrame == false) {
      attack = true;
      clickedLastFrame = true;
    }
  }
  //Activate speciale attack
  if (keyPressed == true && key == 's') {
    if (clickedLastFrame == false) {
      specialAttack = true;
      clickedLastFrame = true;
      for (Fireball b : fireballs) {
        b.setSpecial(true);
      }
    }
  }
}

void keyReleased() {
  clickedLastFrame = false;
}

class Fireball {
  PImage fb;
  int x;
  int y;
  int fbWidth;
  int fbHeight;
  int speed;
  boolean special;

  Fireball(PImage fb, int x, int y, int fbWidth, int fbHeight, int speed) {
    this.fb = fb;
    this.x = x;
    this.y = y;
    this.fbWidth = fbWidth;
    this.fbHeight = fbHeight;
    this.speed = speed;
    special = false;
  }

  Fireball(PImage fb, int x, int y, int fbWidth, int fbHeight, int speed, boolean special) {
    this.fb = fb;
    this.x = x;
    this.y = y;
    this.fbWidth = fbWidth;
    this.fbHeight = fbHeight;
    this.speed = speed;
    this.special = special;
  }

  void drawFireball() {
    if (special) {
      imageMode(CENTER);
      translate(0, 0);
      rotate(radians(90));
      image(fb, x, y, fbWidth, fbHeight);
      translate(0, 0);
      rotate(radians(-90));
    } else {
      image(fb, x, y, fbWidth, fbHeight);
    }
  }

  void move() {
    if (x>600) {
      attack = false;
      specialAttack = false;
      x=0;
    }
    x += speed;
    print(" " + x + " ");
  }

  void setSpecial(boolean specialAttack) {
    special = specialAttack ? true : false;
  }

  void setY(int y) {
    this.y = y;
  }

  boolean getSpecial() {
    return special;
  }
}
