class Player extends Collider implements Updater { //<>//
  PImage playerSkin;
  PVector playerVector;
  float velocity = 0;
  float upforce = -2.4;
  final float MOVEMENT = 3.5;
  final float GRAVITY = 0.07;
  boolean isUp, isDown, isRight, isLeft, airBorne, clickedLastFrame, overalCollision, jumped, isCrouched;
  int playerWidth, playerHeight;
  int colliderType;
  int collisionType;
  int crouchCounter;
  Healthbar healthbar;

  Player(PVector vector, int sizeW, int sizeH) {
    super(vector, sizeW, sizeH);
    playerVector = vector;
    playerWidth = sizeW;
    playerHeight = sizeH;
    playerSkin = characterSelect.getPlayerSkin();
    colliderType = ColliderType.NONE;
    healthbar = new Healthbar(1);
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
    // death check
    if (healthbar != null) {
      healthbar.updatePlayerHealth();
    }
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
      } else if (keyCode == DOWN) {
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
    crouchCounter++;
    if (crouchCounter >= 3) {
      refreshPlayerSkin();
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
    if (playerVector.y < height - groundHeight) {
      airBorne = true;
      velocity += GRAVITY;
      playerVector.y += velocity;
      //zwaartekracht functie
    }
    if (playerVector.y >= height - groundHeight && !jumped) {
      if (playerVector.y >= height - groundHeight) {
        playerVector.y = height - groundHeight;
      }
      velocity = 0;
      airBorne = false;
      //bal blijft zo binnen het scherm
    } else if (playerVector.y <= groundHeight) {
      playerVector.y = playerHeight/2;
      velocity = 0;
    }
    playerVector.y = constrain(playerVector.y + MOVEMENT * (int(isDown) - int(isUp)), groundHeight, height - groundHeight);
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
