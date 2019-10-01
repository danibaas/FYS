class Gravity {

  float x = 140;
  float y = height/4;

  float gravity = 0.1;
  float velocity = 0;
  float upforce = -6;
  float movement = 3.5;

  void jump() {
    velocity += upforce;
    //jump mechanic
  }

  void leftmovement() {
    x -= movement;
  }

  void rightmovement() {
    x += movement;
  }

  void fall() {
    velocity += gravity;
    y += velocity;
    //zwaartekracht functie

    if (y > height) {
      y = height;
      velocity = 0;
      //bal blijft zo binnen het scherm
    }
  }

  void show() {
    fill(255);
    rectMode(CENTER);
    rect(x, y, 50, 50);
    rectMode(CORNER);
  }
}
