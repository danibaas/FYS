import de.bezier.data.sql.*;

class HighScore {
  SQLite sql;
  int highScore = 0;

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
      sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), int score)");
    }
  }

  void updateScore() {
    highScore++;
  }
  // database 
  void saveHighScore(String name, int score) {
    if (sql.connect()) {
      sql.execute("INSERT INTO highscores VALUES(" + name + ", " + score + ")");
    }
  }

  int getScore(String name) {
    int score = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM highscores WHERE name='" + name + "'");
      if (sql.next()) {
        score = sql.getInt("score");
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
