class Gravity {
  float xObject = 140;
  float yObject = height/4;
  float gravity = 0.07;
  float velocity = 0;
  float upforce = -3.5;
  float movement = 3.5;
  boolean isUp, isDown, isRight, isLeft, airBorne;

  void jump() {
    velocity += upforce;
    //jump mechanic
  }

  boolean isFalling() {
    return (yObject <= height-25);
  }

  void move() {
    if (yObject < height-25) {
      airBorne = true;
      velocity += gravity;
      yObject += velocity;
      //zwaartekracht functie
      if (yObject >= height - 25) {
        yObject = height - 25;
        velocity = 0;
        airBorne = false;
        //bal blijft zo binnen het scherm
      } else if (yObject <= 25) {
        yObject = 25;
        velocity = 0;
      }
    }
    final int r = 50 >> 1;
    xObject = constrain(xObject + movement*(int(isRight) - int(isLeft)), r, width  - r);
    yObject = constrain(yObject + movement*(int(isDown) - int(isUp)), r, height - r);
  }

  void show() {
    fill(255);
    rectMode(CENTER);
    rect(xObject, yObject, 50, 50);
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
