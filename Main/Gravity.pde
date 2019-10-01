class Gravity {

  float x = 140;
  float y = height/4;

  float gravity = 0.1;
  float velocity = 0;
  float upforce = -6;
  float movement = 3.5;
  boolean isUp, isDown, isRight, isLeft, airBorne;

  void jump() {
    velocity += upforce;
    //jump mechanic
  }

  /*void leftmovement() {
   x -= movement;
   }
   
   void rightmovement() {
   x += movement;
   }*/

  boolean isFalling() {
    return (y <= height-25);
  }

  void fall() {
    if (y < height-25) {
      velocity += gravity;
      y += velocity;
      //zwaartekracht functie

      if (y > height - 25) {
        y = height - 25;
        velocity = 0;
        //bal blijft zo binnen het scherm
      } else if (y <= 25) {
        y = 25;
        velocity = 0;
      }
    }
  }

  void move() {
    final int r = 50 >> 1;
    x = constrain(x + movement*(int(isRight) - int(isLeft)), r, width  - r);
    y = constrain(y + movement*(int(isDown)  - int(isUp)), r, height - r);
    //println(velocity, y);
  }

  void show() {
    fill(255);
    rectMode(CENTER);
    rect(x, y, 50, 50);
    rectMode(CORNER);
  }

  boolean setMove(final int k, final boolean b) {
    switch (k) {
    case +'W':
    case UP:
      return isUp = b;

    case +'S':
    case DOWN:
      return isDown = b;

    case +'A':
    case LEFT:
      return isLeft = b;

    case +'D':
    case RIGHT:
      return isRight = b;

    default:
      return b;
    }
  }
}
