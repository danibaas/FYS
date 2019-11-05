class Lazers extends Collider implements Updater {  
  int sizex;
  int sizey;
  boolean drawLazer;
  boolean warningLazer;
  boolean playerDamage;

  int positionY = 450;
  int currentMillis;
  int millisToWait;
  int lazerTimer;
  int waitTime;
  int warningTimer;

  Lazers(PVector position, int breedte, int hoogte) {
    super(position, breedte, hoogte);
    sizex = breedte;
    sizey = hoogte;
    currentMillis = millis();
    millisToWait = 5000 ;
    waitTime = 3000;
    updateList.add(this);
  }

  void drawObject() {
    if (warningLazer) {
      fill(120);
      noStroke();
      rect(position.x, positionY, sizex, sizey, 20);
      fill(0);
      textSize(20);
      text("LAZER!!!",position.x+100,positionY+20);
    }
    if (drawLazer) {
      fill(255, 0, 0);
      noStroke();
      rect(position.x, positionY, sizex, sizey, 20);
    }
  }

  void updateObject() {
    //lazer hoelang die blijft
    if (lazerTimer + waitTime < millis() && drawLazer) {
      playerDamage = false;
      currentMillis = millis();
      drawLazer = false;
      positionY = (int) random(300, 600);
    }
    //tekent de lazer
    if (currentMillis + millisToWait < millis() && !drawLazer) {
      drawLazer = true;
      warningLazer = false;
      lazerTimer = millis();
    }
    if (currentMillis + millisToWait/5 < millis() && !drawLazer) {
      warningLazer = true;
    }
    if (collidesWithPlayer(player) && drawLazer) {
      player.colliderType = ColliderType.LAZER;
      if (!playerDamage) {
        drawLazer = false;
        currentMillis = millis();
        healthbar.removeHealth();
        playerDamage = true;
      }
    }
  }
  void pressedKey() {
  }
  void releasedKey() {
  }
}
