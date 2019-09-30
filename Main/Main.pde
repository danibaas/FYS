import de.bezier.data.sql.*;

int highscore = 0;
SQLite sql;

//scenes
Scene activateScene;
//healthbar
Healthbar hb;
//Jump j; <-- gravity mechanic

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
  //j = new Jump();
  //j.setupGravity();
}

// the game loop
void draw() {
  activateScene.Update();
  activateScene.Draw();
  hb.drawHealthbar();
}

void keyPressed() {
  hb.pressedKey();
}

void keyReleased() {
  hb.releasedKey();
}
