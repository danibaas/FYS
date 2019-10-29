class Player extends Collider implements Updater {
  PImage playerSkin;
  PVector playerVector;
  //float xPos = 140;
  //float yPos = height/4;
  float gravity = 0.07;
  float velocity = 0;
  float upforce = -2.4;
  float movement = 3.5;
  boolean isUp, isDown, isRight, isLeft, airBorne, clickedLastFrame, overalCollision, stopMoving, jumped;
  boolean crouched = false;
  int PlayerSizeW, PlayerSizeH;

  Player(PVector vector, int sizeW, int sizeH ) {
    super(vector, sizeW, sizeH);
    playerVector = vector;
    PlayerSizeW = sizeW;
    PlayerSizeH = sizeH;
    playerSkin = characterSelect.getPlayerSkin();
    playerSkin.resize(PlayerSizeW, PlayerSizeH);
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
    rectMode(CENTER);
    rect(playerVector.x, playerVector.y, PlayerSizeW, PlayerSizeH);
    rectMode(CORNER);
    image(playerSkin, playerVector.x - PlayerSizeW/2, playerVector.y - PlayerSizeH/2);
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
    //You're supposed to crouch here
    if (key == CODED) {
      if (keyCode == DOWN) {
        keys[3] = true;
        clickedLastFrame = true;
        PlayerSizeH /= 2;
        crouched = true;
        
      }
    }
    if (key == 'l') {
      for (int i = 0; i < 3; i++) {
        println();
      }
    }
  }

  void releasedKey() {
    setMove(keyCode, false);
    stopMoving = false;
    if (clickedLastFrame) {
      clickedLastFrame = false;
    }
    if (key == CODED) {
      if (keyCode == UP) {
        keys[0] = false;
        jumped = false;
      } else if (keyCode == DOWN) {
        keys[3] = false;
        PlayerSizeH *= 2;
        clickedLastFrame = false;
      }
    }
  }

  boolean isOnObstacle() {
    boolean onObstacle= false;
    for (Obstacle b : obstacleList) {
      if (b.playerOnObstacle) {
        onObstacle = true;
      }
    }
    return onObstacle;
  }

  void updateSkin() {
    playerSkin = characterSelect.getPlayerSkin();
    playerSkin.resize(PlayerSizeW, PlayerSizeH);
  }

  boolean hasCollision() {
    boolean collides = false;
    if (!collidesWithEnemy(enemy) && !collidesWithObstacle(obstacleList) && !collidesWithPickup(pickup)) {
      overalCollision = false;
    } else {
      overalCollision = true;
    }
    return collides;
  }

  void jump() {
    velocity += upforce;
    jumped = true;
    //jump mechanic
  }

  void move() {
    final int r = (int) background.groundHeight - PlayerSizeH / 2;
    for (Obstacle obstacle : obstacleList) {
      if (obstacle.playerOnObstacle || (playerVector.y < height-r && !obstacle.playerOnObstacle)) {
        airBorne = true;
        velocity += gravity;
        playerVector.y += velocity;
        //zwaartekracht functie
      }
      if (playerVector.y >= height - r || (obstacle.playerOnObstacle && playerVector.y + PlayerSizeH/2 > obstacle.position.y) && !jumped) {
        if (playerVector.y >= height - r) {
          playerVector.y = height - r;
        } else {
          playerVector.y = obstacle.position.y - PlayerSizeH/2;
          stopMoving = false;
        }
        velocity = 0;
        airBorne = false;
        //bal blijft zo binnen het scherm
      } else if (playerVector.y <= r) {
        playerVector.y = PlayerSizeH/2;
        velocity = 0;
      }
      playerVector.y = constrain(playerVector.y + movement*(int(isDown) - int(isUp)), r, height - r);
    }
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
