class Lazers extends Collider {  
  float sizex;
  float sizey;
  int timer;
  int timer2;
  boolean drawLazer;

  Lazers(PVector position, float breedte, float hoogte) {
    super(position, breedte, hoogte);
    sizex = breedte;
    sizey = hoogte;
  }

  void drawLazer() {
    fill(255, 0, 0);
    noStroke();
    rect(position.x, position.y, sizex, sizey, 20);
  }

  void lazerTimer() {
    if (frameCount - timer == 180) {
      drawLazer = true;
      timer2 = frameCount;
      //if rect is drawn
    }
    if (drawLazer) {
      drawLazer();
      //timer2=frameCount;
      if (frameCount - timer2 >=180) {
        drawLazer = false;
        timer = frameCount;
        position.y = random(60, 720);
      }
    }
  }

  void timeLazers() {
    lazerTimer();
  }

  void DamageUpdate() {
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.LAZER;
      healthbar.removeHealth();
    }
  }
}
