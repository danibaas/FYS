class Player extends Collider implements Updater {
  PImage playerSkin;
  PVector playerVector;
  //float xPos = 140;
  //float yPos = height/4;
  float gravity = 0.07;
  float velocity = 0;
  float upforce = -2.4;
  float movement = 3.5;
  boolean isUp, isDown, isRight, isLeft, airBorne, clickedLastFrame, overalCollision;
  ;
  int playerSize;

  Player(PVector vector, int size) {
    super(vector, size, size);
    playerVector = vector;
    playerSize = size;
    //playerSkin = charatcerSelect.getPlayerSkin();
    playerSkin = loadImage(sketchPath() + "/lib/player.png");
    playerSkin.resize(playerSize, playerSize);
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
    rectMode(CENTER);
    rect(playerVector.x, playerVector.y, playerSize, playerSize);
    rectMode(CORNER);
    image(playerSkin, playerVector.x - playerSize/2, playerVector.y - playerSize/2);
  }

  void updateObject() {
    hasCollision();
    move();
    if (keys[0]) {
      if (!airBorne) {
        jump();
        setMove(keyCode, true);
      }
    } else if (keys[3]) {
      if (!airBorne) {
      }
    }
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == UP) {
        keys[0] = true;
        clickedLastFrame = true;
      }
    }
    //Does nothing right now
    if (key == CODED) {
      if (keyCode == DOWN) {
        keys[3] = true;
        clickedLastFrame = true;
      }
    }
  }

  void releasedKey() {
    setMove(keyCode, false);
    if (clickedLastFrame) {
      clickedLastFrame = false;
    }
    if (key == CODED) {
      if (keyCode == UP) {
        keys[0] = false;
      } else if (keyCode == DOWN) {
        keys[3] = false;
      }
    }
  }

  boolean hasCollision() {
    boolean collides = false;
    if (!collidesWithEnemy(enemy) && !collidesWithObstacle(obstacle) && !collidesWithPickup(pickup)) {
      overalCollision = false;
    } else {
      overalCollision = true;
    }
    return collides;
  }

  void jump() {
    velocity += upforce;
    //jump mechanic
  }

  void move() {
    final int r = 50;
    if (playerVector.y < height-r) {
      airBorne = true;
      velocity += gravity;
      playerVector.y += velocity;
      //zwaartekracht functie
      if (playerVector.y >= height - r) {
        playerVector.y = height - r;
        velocity = 0;
        airBorne = false;
        //bal blijft zo binnen het scherm
      } else if (playerVector.y <= r) {
        playerVector.y = 25;
        velocity = 0;
      }
    }
    //xObject = constrain(xObject + movement*(int(isRight) - int(isLeft)), r, width - r);
    playerVector.y = constrain(playerVector.y + movement*(int(isDown) - int(isUp)), r, height - r);
  }

  boolean setMove(final int pressedKey, final boolean toMove) {
    switch (pressedKey) {
    case +'W':
    case UP:
      return isUp = toMove;

    case +'S':
    case DOWN:
      return isDown = toMove;

    case +'A':
    case LEFT:
      return isLeft = toMove;

    case +'D':
    case RIGHT:
      return isRight = toMove;

    default:
      return toMove;
    }
  }
}
