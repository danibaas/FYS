class GameOver {
  boolean gameOver, loadScores, retryBox, goToMenu, clickedLastFrame, highscoreBox = true, savedToDatabase;
  int yPos = 40, yPosResults = 90;
  float scoresTopOffset = 100;
  float row1= 425;
  float row2 = 525;
  float row3 = 725;

  void fontLoad() {
    textFont(eightBit);
  }

  //Highscore tabel
  void loadHighscores() {
    if (loadScores) {
      background(0, 127, 127);
      goToMenu = true;
      fill(255);
      rect(row1-50, scoresTopOffset, row2, 500);
      fill(0);
      textSize(40);
      text("Player", row2, yPos+scoresTopOffset);
      text("Highscore", row3, yPos+scoresTopOffset);
      textSize(18);
      if (sql.connect()) {
        for (int i = 0; i < 10; i++) {
          sql.query("SELECT Account.username, Highscore.score FROM Highscore INNER JOIN Account ON Highscore.user_id = Account.user_id ORDER BY score DESC LIMIT 1 OFFSET "+i);
          while (sql.next()) {
            String s = sql.getString("username");
            int n = sql.getInt("score");
            int ranking = 1+i;
            text("#"+ranking, row1, yPosResults+i*40+scoresTopOffset);
            text(s, row2, yPosResults+i*40+scoresTopOffset);
            text(n, row3, yPosResults+i*40+scoresTopOffset);
          }
        }
        sql.close();
      }
      fill(0);
      text("Press ENTER for menu", width/2, 500);
    }
  }

  void drawGameOver() {
    gameOver = true;
    if (!savedToDatabase) {
      money.saveCoins();
      metrics.save(metrics.getUserId(login.playerName), metrics.startTime, metrics.enemiesKilled, metrics.bossesKilled, (int) highScore.highScore);
      savedToDatabase = true;
    }
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
      textAlign(CENTER, TOP);
      fill(0);
      textSize(25);
      text("Score: " + nfc(highScore.highScore, 1), width/2, height/2 - 25);
      if (retryBox) {
        fill(255, 0, 0);
        rect(width/2-60, height/2+45, 100, 30);
        fill(255);
        rect(width/2+60, height/2+45, 100, 30);
      } else if (highscoreBox) {
        fill(255);
        rect(width/2-60, height/2+45, 100, 30);
        fill(255, 0, 0);
        rect(width/2+60, height/2+45, 100, 30);
      }
      rectMode(CORNER);
      fill(0);
      textSize(15);
      textAlign(CENTER, TOP);
      text("Retry?", width/2-60, height/2+35);
      text("Highscores", width/2+60, height/2+35);
    } else {
    }
  }

  void drawObject() {
    if (gameOver) {
      soundTrack.stop();
    }
    if (!loadScores) {
      drawGameOver();
    } else if (loadScores) {
      loadHighscores();
    }
  }
  void pressedKey() {
    if (keyPressed) {
      if (highscoreBox && key == ENTER) {
        loadScores = true;
      } else if (retryBox && key == ENTER) {
        initScreen();
        reset.restart = true;
        soundTrack.loop();
      }
      if (goToMenu && key == ENTER) {
        initScreen();
        reset.restart = true;
        soundTrack.loop();
      }
      if (keyPressed && !loadScores) {
        if (keyCode == LEFT) {
          retryBox=true;
          highscoreBox = false;
        } else if (keyCode == RIGHT) {
          retryBox = false;
          highscoreBox = true;
        }
      }
    }
  }
  void releasedKey() {
    keyPressed = false;
  }
}
