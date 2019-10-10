class Player implements Updater {
  float xObject = 140;
  float yObject = height/4;
  float gravity = 0.07;
  float velocity = 0;
  float upforce = -3.5;
  float movement = 3.5;
  boolean isUp, isDown, isRight, isLeft, airBorne;
  int playerSize = 50;
  
  Player() {
     updateList.add(this); 
  }
  
  void drawObject() {
    fill(255);
    rectMode(CENTER);
    rect(xObject, yObject, playerSize, playerSize);
    rectMode(CORNER);
  }
  
  void updateObject() {
     move(); 
  }
  
  void pressedKey() {
    if (key == CODED) {
      if (keyCode == UP) {
        if (!airBorne) {
          jump();
          setMove(keyCode, true);
        }
      }
    }
    //Does nothing right now
    if(key == CODED){
      if(keyCode == DOWN){
        if(!airBorne){
        }
      }
    }
  }
  
  void releasedKey() {
     setMove(keyCode, false);
  }

  void jump() {
    velocity += upforce;
    //jump mechanic
  }

  boolean isFalling() {
    return (yObject <= height-50);
  }

  void move() {
    final int r = 50;
    if (yObject < height-r) {
      airBorne = true;
      velocity += gravity;
      yObject += velocity;
      //zwaartekracht functie
      if (yObject >= height - r||obstacle.onObstacle&&yObject>=height-r-obstacle.boxHeight) {
        yObject = height - r;
        velocity = 0;
        airBorne = false;
        //bal blijft zo binnen het scherm
      } else if (yObject <= r) {
        yObject = 25;
        velocity = 0;
      }
    }
    xObject = constrain(xObject + movement*(int(isRight) - int(isLeft)), r, width  - r);
    yObject = constrain(yObject + movement*(int(isDown) - int(isUp)), r, height - r);
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
