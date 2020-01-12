class Reset {
  boolean restart;
  int resetGroundObstacle = 1300, resetCeilingObstacle = -300, resetHighScore = 0, resetPlayerPositionY = 646, resetBossPosition = -500;

  void drawObject() {
    if (restart) {
      updateList.clear();
      highScore.highScore = resetHighScore;
      player.healthbar.isDead = false;
      characterSelect.hasChosen = false;
      characterSelect.drawSelect();
      groundObstacle.position.x = resetGroundObstacle;
      wireObstacle.position.x = resetCeilingObstacle;
      player.playerVector.y = resetPlayerPositionY;
      boss.position.x = resetBossPosition;
      gameOver.gameOver = false;
      restart = false;
    }
  }
}
