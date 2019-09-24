import de.bezier.data.sql.*;
SQLite sql;
int highscore = 0;

void setup() {
  size(1280, 720);
  sql = new SQLite(this, "C:/FYS/highscores.db");
  if (sql.connect()) {
     sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), int score)"); 
  }
}

void draw() {
  
}
