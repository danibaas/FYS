/** http://studio.processingtogether.com/sp/pad/export/ro.91tcpPtI9LrXp
 * built with Studio Sketchpad: 
 *   http://sketchpad.cc
 * 
 * observe the evolution of this sketch: 
 *   http://studio.sketchpad.cc/sp/pad/view/ro.ttf64eeqPBj/rev.18
 * 
 * authors: 
 *   
 *   
 *   GoToLoop
 *   
 
 * license (unless otherwise specified): 
 *   creative commons attribution-share alike 3.0 license.
 *   http://creativecommons.org/licenses/by-sa/3.0/ 
 
 * Player Move (v1.2.1)
 * by GoToLoop (2014/Dec/07)
 *
 * Forum.Processing.org/two/discussion/8511/movement-code-messed-up#Item_6
 * Studio.ProcessingTogether.com/sp/pad/export/ro.91tcpPtI9LrXp
 
 Movement editted to fit our game. (circa 146 - 194)
 */

class Player extends Collider implements Updater {
  PImage playerSkin, crouchedSkin;
  PVector playerVector;
  float velocity = 0;
  boolean isUp, isDown, isRight, isLeft, airBorne, clickedLastFrame, overalCollision, jumped, isCrouched = false;
  int playerWidth, playerHeight, colliderType, collisionType;//, crouchCounter;
  Healthbar healthbar;

  // Constants
  final float UP_FORCE = -9.81;
  final float MOVEMENT = 3.5;
  final float GRAVITY = 0.5;

  // Constructor
  Player(PVector vector, int sizeW, int sizeH) {
    super(vector, sizeW, sizeH); // Geef de data door aan de constructor van de parent class (collider)
    playerVector = vector;
    playerWidth = sizeW;
    playerHeight = sizeH;
    playerSkin = characterSelect.getPlayerSkin();
    healthbar = new Healthbar(1);
    updateList.add(this);
  }

  // Parent method om te tekenen
  void drawObject() {
    rectMode(CORNER);
    if (isCrouched) {
      image(crouchedSkin, playerVector.x - playerWidth/2, playerVector.y - playerHeight/2);
    } else {
      image(playerSkin, playerVector.x - playerWidth/2, playerVector.y - playerHeight/2);
    }
  }

  // Parent method om te updaten
  void updateObject() {
    if (healthbar != null) { // health check
      healthbar.updatePlayerHealth();
    }
    hasCollision();
    move();
    if (keys[0] && !airBorne) { // Als de speler op springen drukt en op de grond is
      jump();
      setMove(keyCode, true);
    } else if (keys[3] && !isCrouched) {
      setCrouch(true);
    }
  }

  // Parent method om de pressed keys te checken
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
  }

  // Parent method om de released keys te checken
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

  // Method om te kijken of de player collision heeft met iets
  boolean hasCollision() {
    boolean collision = false;
    for (Collider collider : collisionList) { // Voor elke collider in collisionlist...
      if (!(collider instanceof Player)) { // kijk of het geen instantie van de player is
        if (collider.collidesWithPlayer(this)) { // kijk of het collision heeft met de player
          collision = true;
        }
      }
    }
    return collision;
  }

  /** Method om de player te laten crouchen of uncrouchen
   *
   * @param crouched Parameter die aangeeft of er gecrouched moet worden of uncrouched. true is crouch, false is uncrouch.
   *
   */
  void setCrouch(boolean crouched) {
    playerSkin = characterSelect.getPlayerSkin(); // Haal de skin op (image)
    if (crouched && !isCrouched) { // Als er gecrouched moet worden en de speler is niet gecrouched dan
      isCrouched = true;
      playerVector.y += playerHeight / 4;
      playerHeight /= 2;
    } else if (!crouched && isCrouched) {
      isCrouched = false;
      playerVector.y -= playerHeight / 4;
      playerHeight *= 2;
    }
  }

  // Method for updating the skin
  void updateSkin() {
    playerSkin = characterSelect.getPlayerSkin();
    crouchedSkin = characterSelect.getCrouchedSkin();
  }

  // Method for jump mechanic
  void jump() {
    if (isCrouched) {
      velocity += (UP_FORCE/100) * 84;
    } else {
      velocity += UP_FORCE;
    }
    jumped = true;
  }

  // Method die de beweging van de speler afhandelt
  void move() {
    int trueHeight = height - (int) background.GROUND_HEIGHT;
    int groundHeight = trueHeight + playerHeight / 2;
    if (playerVector.y < height - groundHeight) {
      airBorne = true;
      velocity += GRAVITY;
      playerVector.y += velocity;
      if (keys[3]) {
        playerVector.y += (velocity/100) * 60;
      }
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

  // Method die de movement input afhandelt
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
