import de.bezier.data.sql.*;

int highscore = 0;
SQLite sql;

//scenes
Scene activateScene;
//healthbar
Healthbar hb;
//Jump j; <-- gravity mechanic
CharacterAttack ca;
//character attack

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
  ca = new CharacterAttack();
  ca.loadAttack();
  //j = new Jump();
  //j.setupGravity();
}

// the game loop
void draw() {
  activateScene.Update();
  activateScene.Draw();
  hb.drawHealthbar();
  ca.drawAttack();
}

void keyPressed() {
  hb.pressedKey();
  ca.pressed();
}

void keyReleased() {
  hb.releasedKey();
  ca.released();
}
