class Player extends Collider implements Updater { //<>//
  PImage playerSkin;
  PVector playerVector;
  //float xPos = 140;
  //float yPos = height/4;
  float gravity = 0.07;
  float velocity = 0;
  float upforce = -2.4;
  float movement = 3.5;
  boolean isUp, isDown, isRight, isLeft, airBorne, clickedLastFrame, overalCollision, stopMoving, jumped, isCrouched;
  int playerWidth, playerHeight;
  int colliderType;

  Player(PVector vector, int sizeW, int sizeH ) {
    super(vector, sizeW, sizeH);
    playerVector = vector;
    playerWidth = sizeW;
    playerHeight = sizeH;
    playerSkin = characterSelect.getPlayerSkin();
    colliderType = ColliderType.NONE;
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
    rectMode(CENTER);
    rect(playerVector.x, playerVector.y, playerWidth, playerHeight);
    rectMode(CORNER);
    image(playerSkin, playerVector.x - playerWidth/2, playerVector.y - playerHeight/2);
  }

  void updateObject() {
    hasCollision();
    move();
    if (keys[0]) {
      if (!airBorne) {
        jump();
        setMove(keyCode, true);
      }
    } else if (keys[3] && !isCrouched) {
       setCrouch(true); 
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
        setCrouch(false);
        clickedLastFrame = false;
      }
    }
  }

  boolean hasCollision() {
    boolean collision = false;
    for (Collider collider : collisionList) {
      if (!(collider instanceof Player)) {
        if (collider.collidesWithPlayer(this)) {
          collision = true;
        }
      }
    }
    return collision;
  }

  void setCrouch(boolean crouched) {
    playerSkin = characterSelect.getPlayerSkin();
    if (crouched && !isCrouched) {
      isCrouched = true;
      playerVector.y += playerHeight / 4;
      playerHeight /= 2;
      playerSkin.resize(playerWidth, playerHeight);
    } else if (!crouched && isCrouched) {
      isCrouched = false;
      playerVector.y -= playerHeight / 4;
      playerHeight *= 2;
      playerSkin.resize(playerWidth, playerHeight);
    }
  }

  void updateSkin() {
    playerSkin = characterSelect.getPlayerSkin();
  }

  void jump() {
    velocity += upforce;
    jumped = true;
    //jump mechanic
  }

  void move() {
    int trueHeight = height - (int) background.groundHeight;
    int groundHeight = trueHeight + playerHeight / 2;
    for (Obstacle obstacle : obstacleList) {
      if (obstacle.playerOnObstacle || (playerVector.y < height-groundHeight && !obstacle.playerOnObstacle)) {
        airBorne = true;
        velocity += gravity;
        playerVector.y += velocity;
        //zwaartekracht functie
      }
      if (playerVector.y >= height - groundHeight || (obstacle.playerOnObstacle && playerVector.y + playerHeight/2 > obstacle.position.y) && !jumped) {
        if (playerVector.y >= height - groundHeight) {
          playerVector.y = height - groundHeight;
        } else {
          playerVector.y = obstacle.position.y - playerHeight/2;
          stopMoving = false;
        }
        velocity = 0;
        airBorne = false;
        //bal blijft zo binnen het scherm
      } else if (playerVector.y <= groundHeight) {
        playerVector.y = playerHeight/2;
        velocity = 0;
      }
      playerVector.y = constrain(playerVector.y + movement*(int(isDown) - int(isUp)), groundHeight, height - groundHeight);
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
