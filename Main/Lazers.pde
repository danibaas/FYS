class Lazers extends Collider implements Updater {  
  int sizeX, sizeY, currentMillis, millisToWait, lazerTimer, waitTime;
  boolean drawLazer, warningLazer;

  Lazers(PVector position, int breedte, int hoogte) {
    super(position, breedte, hoogte);
    sizeX = breedte;
    sizeY = hoogte;
    currentMillis = millis();
    millisToWait = 5000;
    waitTime = 3000;
    updateList.add(this);
  }

  void drawObject() {
    if (warningLazer) {
      fill(120);
      noStroke();
      rect(position.x, position.y + (sizeY/5) * 2, sizeX, sizeY/3, 20);
    } else if (drawLazer) {
      fill(255, 0, 0);
      noStroke();
      rect(position.x, position.y, sizeX, sizeY, 20);
    }
  }

  void updateObject() {
    if (!drawLazer) {
      collisionList.remove(this);
    } else {
      collisionList.add(this);
    }
    //tekent de lazer
    if (currentMillis + millisToWait < millis() && !drawLazer) {
      drawLazer = true;
      warningLazer = false;
      lazerTimer = millis();
    }
    //lazer hoelang die blijft
    if (lazerTimer + waitTime < millis() && drawLazer) {
      currentMillis = millis();
      drawLazer = false;
      position.y = (int) random(200, 550);
    }
    if (currentMillis + (millisToWait/5) * 4 < millis() && !drawLazer) {
      warningLazer = true;
    }
    if (collidesWithPlayer(player) && drawLazer && !warningLazer) {
      player.colliderType = ColliderType.LAZER;
      drawLazer = false;
      currentMillis = millis();
      player.healthbar.isDead = true;
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
