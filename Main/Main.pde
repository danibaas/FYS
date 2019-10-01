//instance of this class, used for database
Main instance;
//highscore class, handles highscore.
HighScore highScore;
//scenes
Scene activateScene;
CharacterSelect cs;

//healthbar
Healthbar hb;
//Jump j; <-- gravity mechanic
CharacterAttack ca;
//game over screen
GameOver go;

void setup() {
  // ratio 16:9
  size(1280, 720);
  instance = this;
  highScore = new HighScore();
  highScore.initializeDatabase();
  activateScene = new StartScene();
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
  sql = new SQLite(this, f.getPath());
  if (sql.connect()) {
    sql.execute("CREATE TABLE IF NOT EXISTS highscores (name varchar(128), int score)");
  }
  hb = new Healthbar();
  hb.loadHealth();
  //  hb.loadHealth();/  //hb.addHealth();
  ca = new CharacterAttack();
  ca.loadAttack();
  cs = new CharacterSelect();
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
