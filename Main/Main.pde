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
CharacterSelect cs;

void setup() {
  // ratio 16:9
  size(1280, 720);
  activateScene = new StartScene();
  String path = sketchPath() + "/highscores.db";
  File f = new File(path);
  if (!f.exists()) {
    try {
      f.createNewFile();
    } catch(IOException e) {
      println(e);
    }
  }
  sql = new SQLite(this, f.getPath());
  if (sql.connect()) {
    sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), int score)");
  }
  hb = new Healthbar();
  hb.loadHealth();
  ca = new CharacterAttack();
  ca.loadAttack();
  cs = new CharacterSelect();
  cs.Draw();
  //j = new Jump();
  //j.setupGravity();
}

// the game loop
void draw() {
  activateScene.Update();
  activateScene.Draw();
  hb.drawHealthbar();
  ca.drawAttack();
  cs.Draw();
}

void keyPressed() {
  hb.pressedKey();
  ca.pressed();
}

void keyReleased() {
  hb.releasedKey();
  ca.released();
}
void mousePressed() {
  cs.pressed();
}
