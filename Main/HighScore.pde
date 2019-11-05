import de.bezier.data.sql.*;

class HighScore {
  SQLite sql;
  float highScore = 0;

  void initializeDatabase() {
    String path = sketchPath() + "/highscores.db";
    File f = new File(path);
    if (!f.exists()) {
      try {
        f.createNewFile();
      } 
      catch(IOException e) {
        println(e);
      }
    }
    sql = new SQLite(instance, f.getPath());
    if (sql.connect()) {
      sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), float score)");
    }
  }

  void displayScore() {
    stroke(0);
    fill(255);
    rect(1045, 0, 233, 40);
    fill(150, 100, 255);
    textSize(30);
    textAlign(LEFT);
    String tekst = "Score: " + nfc(highScore, 1); 
    text(tekst, 1050, 30);
  }

  void updateScore() {
    if (player.colliderType != ColliderType.OBSTACLE && !gameOver.gameOver) {
      highScore += 0.1;
    }
  }

  void setScore(float score) {
    highScore = score;
  }

  float getScore() {
    return highScore;
  }
  // database 
  void saveHighScore(String name, float score) {
    if (sql.connect()) {
      sql.execute("INSERT INTO highscores VALUES(" + name + ", " + score + ")");
    }
  }

  float getScore(String name) {
    float score = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM highscores WHERE name='" + name + "'");
      if (sql.next()) {
        score = sql.getFloat("score");
      }
    }
    return score;
  }

  String getTopScore() {
    String name = "";
    if (sql.connect()) {
      sql.query("SELECT MAX(score) FROM highscores"); 
      if (sql.next()) {
        name = sql.getString("name");
      }
    }
    return name;
  }
}
