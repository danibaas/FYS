void saveHighscore(String name, int score) {
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
