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
      strokeWeight(5);
      rect(width/2-width/8, 200, width/4, 350);
      strokeWeight(3);
      textSize(50);
      textAlign(CENTER);
      fill(0); 
      String name = login.playerName;
      text("Name: " + name, width/2, 250);
      textSize(25);
      text("Total runs: " + getTotalRuns(name), width/2, 325);
      text("Total enemies killed: " + getTotalEnemiesKilled(name), width/2, 375);
      text("Total bosses killed: " + getTotalBossesKilled(name), width/2, 425);
      text("Highscore: " + getHighScore(name), width/2, 475);
      text("Press A to view runs", width/2, 525);
    } 
    if (showRuns) {
      fill(127);
      rect(275, 175, 700, 400);
      textAlign(LEFT);
      fill(0);
      if (sql.connect()) {
        sql.query("SELECT COUNT(" + getUserId(login.playerName) + ") FROM Gamerun;");
        int iterator = 0;
        while (sql.next()) {
          iterator++;
        }
        sql.query("SELECT * FROM Gamerun WHERE userId='" + getUserId(login.playerName) + "' ORDER BY startTime DESC;");
        int rowHeight = 225;
        for (int i = 0; i < iterator; i++) {
          if (sql.next()) {
            text("Run: " + i+1, 300, rowHeight);
            text("Enemies killed: " + sql.getInt("enemiesKilled"), 400, rowHeight);
            text("Bosses killed: " + sql.getInt("bossesKilled"), 620, rowHeight);
            text("Score: " + sql.getInt("score"), 820, rowHeight);
            rowHeight += 50;
          }
        }
        sql.close();
      }
      //text("Run: "+2, 300, heightRow2);
      //text("Enemies killed: "+2, 400, heightRow2);
      //text("Bosses killed: "+1, 620, heightRow2);
      //text("Score: "+2000, 820, heightRow2);
      textAlign(CENTER);
      text("Press B for menu", width/2, height/4*3);
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
      sql.query("SELECT * FROM Highscore WHERE user_id='" + userid + "';");
      if (sql.next()) {
        total = sql.getInt("score");
      }
      sql.close();
    }
    return total;
  }  

  void save(int userId, int startTime, int enemiesKilled, int bossesKilled, int score) {
    if (sql.connect()) {
      sql.execute("INSERT INTO Gamerun VALUES ('" + userId + ", '" + startTime + "', '" + enemiesKilled + "', '" + bossesKilled + "', '" + score + "');");
      sql.execute("UPDATE Statistic SET totalRuns='" + getTotalRuns(login.playerName) + 1 + "' WHERE user_id='" + userId + "';");
      sql.execute("UPDATE Statistic SET totalEnemiesKilled='" + getTotalEnemiesKilled(login.playerName) + enemiesKilled + "' WHERE user_id='" + userId + "';");
      sql.execute("UPDATE Statistic SET totalBossesKilled='" + getTotalBossesKilled(login.playerName) + bossesKilled + "' WHERE user_id='" + userId + "';");
      if (getHighScore(login.playerName) > score) {
       sql.execute("UPDATE Statistic SET highscore='" + score + "';"); 
      }
      sql.close();
    }
  }

  void pressedKey() {
    if (key == 'a' || key == 'A') { 
      showRuns = true;
    }
    if (key == 'o' || key == 'O') { 
      showStatistics = true;
    } else if (key == 'p') { 
      showStatistics = false;
    }
  }
}

//CREATE TABLE IF NOT EXISTS Gamerun(userId int, startTime int, enemiesKilled int, bossesKilled int, score int, PRIMARY KEY(userId, startTime), FOREIGN KEY(userId) REFERENCES Account(user_id));
//CREATE TABLE IF NOT EXISTS Statistic(userId int, totalRuns int, totalEnemiesKilled int, totalBossesKilled int, highScore int, PRIMARY KEY(userId), FOREIGN KEY(userId) REFERENCES Account(user_id));
