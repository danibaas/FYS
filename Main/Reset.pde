class Reset {
  boolean restart;
  
  void drawObject() {
    if (restart) {
      updateList.clear();
      highScore.highScore = 0;
      player.healthbar.isDead = false;
      characterSelect.hasChosen = false;
      characterSelect.drawSelect();
      groundObstacle.position.x = 1300;
      wireObstacle.position.x = -300;
      player.playerVector.y = 646;
      boss.position.x = -500;
      gameOver.gameOver = false;
      restart = false;
    }
  }
}
