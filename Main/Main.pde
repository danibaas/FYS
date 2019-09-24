import de.bezier.data.sql.*;
SQLite sql;
int highscore = 0;
//scenes
Scene activateScene;

void setup() {
  // ratio 16:9
  size(1280, 720);
  activateScene = new StartScene();
  sql = new SQLite(this, "highscores.db");
  if (sql.connect()) {
    sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), int score)");
  }
}

// the game loop
void draw() {
  //background(255);
  activateScene.Update();
  activateScene.Draw();
}
