class Lazers extends Collider implements Updater {  
  float sizex;
  float sizey;
  boolean drawLazer;

  int currentMillis;
  int millisToWait;
  int lazerTimer;
  int waitTime;

  Lazers(PVector position, float breedte, float hoogte) {
    super(position, breedte, hoogte);
    sizex = breedte;
    sizey = hoogte;
    currentMillis = millis();
    millisToWait = 3000;
    waitTime = 3000;
    updateList.add(this);
  }

  void drawObject() {
    if (drawLazer) {
      fill(255, 0, 0);
      noStroke();
      rect(position.x, position.y, sizex, sizey, 20);
    }
  }

  void updateObject() {
    if (lazerTimer + waitTime < millis() && drawLazer) {
      currentMillis = millis();
      drawLazer = false;
    }
    if (currentMillis + millisToWait < millis() && !drawLazer) {
      drawLazer = true;
      lazerTimer = millis();
    }
  }

  /*
   
   void damageUpdate() {
   if (collidesWithPlayer(player) && drawLazer) {
   player.colliderType = ColliderType.LAZER;
   healthbar.removeHealth();
   }
   }*/

  void pressedKey() {
  }
  void releasedKey() {
  }
}
