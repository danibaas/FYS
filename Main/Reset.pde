class Reset {
  boolean restart;
  
  void drawObject() {
    if (restart) {
      characterSelect.drawSelect();
      gameOver.gameOver = false;
      highScore.highScore = 0;
      characterSelect.hasChosen = false;
      characterSelect.drawSelect();
    }
  }
}
