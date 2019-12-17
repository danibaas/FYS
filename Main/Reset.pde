class Reset {
  boolean restart;
  
  void drawObject() {
    if (restart) {
      highScore.highScore = 0;
      player.healthbar.isDead = false;
      characterSelect.hasChosen = false;
      characterSelect.drawSelect();
      background.resetBackgrounds();
      groundObstacle.position.x = 1300;
      gameOver.gameOver = false;
      restart = false;
    }
  }
}
