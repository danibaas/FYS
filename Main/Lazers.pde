class Lazers extends Collision {  
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

  void lazershow() {

    fill(255, 0, 0);
    noStroke();
    rect(position.x, position.y, sizex, sizey);
  }

  void lazerspectacle() {
    if (frameCount - timer == 180) {
      drawLazer = true;
      timer2 = frameCount;
      //if rect is drawn
    }
    if (drawLazer) {
      lazershow();
      //timer2=frameCount;
      if (frameCount - timer2 >=180) {
        drawLazer = false;
        timer = frameCount;
      }
    }
  }
  void presentlazers() {
    lazerspectacle();
  }
}
