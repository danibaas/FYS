class gameOver {

  void fontLoad(){
    PFont eightBit;
    eightBit = createFont("PressStart2P.ttf", 30);
    textFont(eightBit);
  }

  
  void display() {
    fill(0);
    rectMode(CENTER);
    rect(width/2, height/2, 400, 150);
    fill(255);
    rect(width/2, height/2, 390, 140);
    fill(0);
    textSize(35);
    textAlign(CENTER, BOTTOM);
    text("Game Over", width/2, height/2);
    textSize(15);
    textAlign(CENTER, TOP);
    text("Retry?", width/2, height/2+25);
    fill(0, 0, 0, 0);
    rect(width/2, height/2+30, 100, 30);
  }
}
