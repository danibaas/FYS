// als de speler dood gaat voeg 1 toe aan total runs 
// een variable die aantal killed enemies optelt 
// een variable die aantal killed bosses optelt 
// personal highscore 
// andere scores die je ooit gehaalt hebt 
// een tabel waar elke run gesaved wordt met user, aantal enemies killed, aantal bosses killed en huidige score 
// een tabel waar alle metrics opgeslagen worden met user, total enemies killed, total bosses killed, personal highscore en total runs 
class Metrics { 
  boolean showStatistics, showRuns; 
  int enemiesKilled = 0;
  int bossesKilled = 0;
  int startTime = 0;

  void drawStatistics() { // Draw the actual statistics 
    if (showStatistics) { 
      fill(137);
      strokeWeight(3);
      stroke(3);
      rect(width/4, 200, width/2, 400);
      strokeWeight(3);
      textSize(50);
      textAlign(CENTER);
      fill(0); 
      String name = login.playerName;
      text("Name: " + name, width/2, 250);
      textSize(25);
      text("Total runs: " + getTotalRuns(name), width/2, 300);
      text("Total enemies killed: " + getTotalEnemiesKilled(name), width/2, 350);
      text("Total bosses killed: " + getTotalBossesKilled(name), width/2, 400);
      text("Highscore: " + getHighScore(name), width/2, 450);
      text("Press A to view runs", width/2, 525);
      text("Press B to go back", width/2, 575);
    } 
    if (showRuns) {
      fill(127);
      rect(250, 150, 750, 500);
      textAlign(CENTER, CENTER);
      fill(0);
      text("Your 8 latest runs", width/2, 175);
      textAlign(LEFT);
      fill(0);
      if (sql.connect()) {
        //Shows runs 8 latest runs
        int id = getUserId(login.playerName);
        sql.connect();
        sql.query("SELECT COUNT(*) FROM (SELECT user_id FROM Gamerun WHERE user_id='" + id + "' LIMIT 8) AS runs;");
        int iterator = 0;
        if (sql.next()) {
          iterator = sql.getInt("COUNT(*)");
        }
        sql.query("SELECT * FROM Gamerun WHERE user_id='" + id + "' ORDER BY startTime ASC;");
        int rowHeight = 225;
        for (int i = 0; i < iterator; i++) {
          if (sql.next()) {
            int run = i + 1;
            text("Run: " + run, 260, rowHeight);
            text("Enemies killed: " + sql.getInt("enemiesKilled"), 360, rowHeight);
            text("Bosses killed: " + sql.getInt("bossesKilled"), 610, rowHeight);
            text("Score: " + sql.getInt("score"), 830, rowHeight);
            rowHeight += 50;
          }
        }
        sql.close();
      }
      textAlign(CENTER);
      text("Press B to go back", width/2, 625);
    }
  }

  int getUserId(String name) {
    int id = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE username='" + name + "';");
      if (sql.next()) {
        id = sql.getInt("user_id");
      }
      sql.close();
    }
    return id;
  }

  // methoden voor total stats
  int getTotalRuns(String name) {
    int total = 0;
    int userid = getUserId(name);
    if (sql.connect()) {
      sql.query("SELECT * FROM Statistic WHERE user_id='" + userid + "';");
      if (sql.next()) {
        total = sql.getInt("totalRuns");
      }
      sql.close();
    }
    return total;
  }

  int getTotalEnemiesKilled(String name) {
    int total = 0;
    int userid = getUserId(name);
    if (sql.connect()) {
      sql.query("SELECT * FROM Statistic WHERE user_id='" + userid + "';");
      if (sql.next()) {
        total = sql.getInt("totalEnemiesKilled");
      }
      sql.close();
    }
    return total;
  }

  int getTotalBossesKilled(String name) {
    int total = 0;
    int userid = getUserId(name);
    if (sql.connect()) {
      sql.query("SELECT * FROM Statistic WHERE user_id='" + userid + "';");
      if (sql.next()) {
        total = sql.getInt("totalBossesKilled");
      }
      sql.close();
    }
    return total;
  }

  int getHighScore(String name) {
    int total = 0;
    int userid = getUserId(name);
    if (sql.connect()) {
      sql.query("SELECT MAX(score) FROM Highscore WHERE user_id='" + userid + "';");
      if (sql.next()) {
        total = (int) sql.getFloat("MAX(score)");
      }
      sql.close();
    }
    return total;
  }

  boolean hasStatistics(String name) {
    boolean has = false;
    int id = getUserId(name);
    if (sql.connect()) {
      sql.query("SELECT * FROM Statistic WHERE user_id='" + id + "';");
      if (sql.next()) {
        has = true;
      }
      sql.close();
    }  
    return has;
  }

  void save(int userId, int startTime, int enemiesKilled, int bossesKilled, int score) {
    String name = login.playerName;
    int totalRuns = getTotalRuns(name) + 1;
    int totalEnemies = getTotalEnemiesKilled(name) + enemiesKilled;
    int totalBosses = getTotalBossesKilled(name) + bossesKilled;
    int previousHighScore = getHighScore(name);
    boolean hasStats = hasStatistics(name);
    if (sql.connect()) {
      sql.execute("INSERT INTO Gamerun VALUES ('" + userId + "', '" + startTime + "', '" + enemiesKilled + "', '" + bossesKilled + "', '" + score + "');");
      if (hasStats) {
        sql.execute("UPDATE Statistic SET totalRuns='" + totalRuns + "' WHERE user_id='" + userId + "';");
        sql.execute("UPDATE Statistic SET totalEnemiesKilled='" + totalEnemies + "' WHERE user_id='" + userId + "';");
        sql.execute("UPDATE Statistic SET totalBossesKilled='" + totalBosses + "' WHERE user_id='" + userId + "';");
        if (score > previousHighScore) {
          sql.execute("UPDATE Statistic SET highScore='" + score + "' WHERE user_id = '" + userId + "';");
        }
      } else {
        sql.execute("INSERT INTO Statistic VALUES ('" + userId + "', '" + totalRuns + "', '" + totalEnemies + "', '" + totalBosses + "', '" + score + "');");
      }
      sql.close();
    }
  }

  void pressedKey() {
    //Press o or O to see player overview
    if (keyPressed && key == 'o' || key == 'O') { 
      showStatistics = true;
    }
    //Press a or A to see the latest 8 runs of player
    if (keyPressed && key == 'a' || key == 'A') { 
      showRuns = true;
    }
    if (keyPressed && key == 'b' || key == 'B') { 
      if (showRuns) {
        showRuns = false;
      } else if (!showRuns) {
        showStatistics = false;
      }
    }
  }
}
