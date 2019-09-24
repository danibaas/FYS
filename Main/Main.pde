import de.bezier.data.sql.*;
SQLite sql;
int highscore = 0;
//scenes
Scene activateScene;
//healthbar
Healthbar hb;

void setup() {
  // ratio 16:9
  size(1280, 720);
  activateScene = new StartScene();
  sql = new SQLite(this, "highscores.db");
  if (sql.connect()) {
    sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), int score)");
  }
  hb = new Healthbar();
  hb.loadHealth();
}

// the game loop
void draw() {
  //background(255);
  activateScene.Update();
  activateScene.Draw();
  hb.drawHealthbar();
}

void keyPressed() {
  hb.pressed();
}

void keyReleased() {
  hb.released();
}
