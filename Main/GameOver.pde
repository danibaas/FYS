class GameOver {
  boolean gameOver;

  void fontLoad() {
    textFont(eightBit);
  }

  void drawObject() {
    gameOver = true;
    fill(0);
    rectMode(CENTER);
    rect(width/2, height/2, 400, 150);
    fill(255);
    rect(width/2, height/2, 390, 140);
    fill(0);
    textSize(35);
    textAlign(CENTER, BOTTOM);
    text("Game Over!", width/2, height/2 - 25);
    textSize(15);
    textAlign(CENTER, TOP);
    text("Retry?", width/2, height/2+35);
    fill(0);
    textSize(25);
    text("Score: " + nfc(highScore.highScore, 1), width/2, height/2 - 25);
    fill(0, 0, 0, 0);
    rect(width/2, height/2+45, 100, 30);
    rectMode(CORNER);
    // reset game
    if (keyPressed) {
      if (key == 'r') {
        gameOver = false;
        soundTrack.stop();
        boolean chose = characterSelect.choseCorra ? true : false;
        frameCount = -1;
      }
    }
  }
}
