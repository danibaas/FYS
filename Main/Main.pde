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
Jump jump;

//character attack
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
  hb = new Healthbar();
  hb.loadHealth();
  ca = new CharacterAttack();
  ca.loadAttack();
  cs = new CharacterSelect();
  jump = new Jump();
  jump = new Jump();
  jump.setupGravity();
}

// the game loop
void draw() {
  activateScene.Update();
  activateScene.Draw();
  jump.drawGravity();
  ca.drawAttack();
  hb.drawHealthbar();
  cs.Draw();
}

void keyPressed() {
  hb.pressedKey();
  ca.pressed();
  jump.gravityPressed();
}

void keyReleased() {
  hb.releasedKey();
  ca.released();
}
void mousePressed() {
  cs.pressed();
}
