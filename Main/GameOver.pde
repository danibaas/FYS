class GameOver {
  boolean gameOver;
  boolean loadScores;
  int yPos = 40, yPosResults = 90;
  float scoresTopOffset = 100;
  float row1= 400;
  float row2 = 500;
  float row3 = 700;

  void fontLoad() {
    textFont(eightBit);
  }

  void loadHighscores() {
    if (loadScores) {
      fill(255);
      rect(row1-50, scoresTopOffset, row2, 500);
      fill(0);
      textSize(40);
      text("Player", row2, yPos+scoresTopOffset);
      text("Highscore", row3, yPos+scoresTopOffset);
      textSize(18);
      if (gameOver) {
        loadScores = true;
      } else {
        loadScores = false;
      }
      for (int i = 0; i < 10; i++) {
        sql.query("SELECT Account.username, Highscore.score FROM Highscore INNER JOIN Account ON Highscore.user_id = Account.user_id ORDER BY score DESC LIMIT 1 OFFSET "+i);
        while (sql.next())
        {
          String s = sql.getString("username");
          int n = sql.getInt("score");
          int ranking = 1+i;
          text("#"+ranking, row1, yPosResults+i*40+scoresTopOffset);
          text(s, row2, yPosResults+i*40+scoresTopOffset);
          text(n, row3, yPosResults+i*40+scoresTopOffset);
        }
      }
    } else {
    }
  }

  void drawGameOver() {
    gameOver = true;
    if (!loadScores) {
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
      text("Retry?", width/2-60, height/2+35);
      text("Highscores", width/2+60, height/2+35);
      fill(0);
      textSize(25);
      text("Score: " + nfc(highScore.highScore, 1), width/2, height/2 - 25);
      fill(0, 0, 0, 0);
      rect(width/2-60, height/2+45, 100, 30);
      rect(width/2+60, height/2+45, 100, 30);
      rectMode(CORNER);
    } else {
    }
  }

  void drawObject() {
    drawGameOver();
    loadHighscores();
    if (keyPressed) {
      if (key == 'h') {
        loadScores = true;
      }
    }
    // reset game
    if (keyPressed) {
      if (key == ENTER) {
        gameOver = false;
        soundTrack.stop();
        boolean chose = characterSelect.choseCorra ? true : false;
        frameCount = -1;
        characterSelect.hasChosen = true;
        if (chose) {
          characterSelect.choseCorra = true;
        } else {
          characterSelect.choseDonDon = true;
        }
        initScreen();
      }
    }
  }
}
