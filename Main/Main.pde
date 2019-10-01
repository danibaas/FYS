//instance of this class, used for database
Main instance;
//highscore class, handles highscore.
HighScore highScore;
//scenes
Scene activateScene;
//CharacterSelect cs;

Block block;
Pickup pu;


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
  // cs = new CharacterSelect();
  jump = new Jump();
  jump.setupGravity();
  go = new GameOver();
  block = new Block(new PVector(200, 200), 100, 100);
  pu = new Pickup(new PVector(200, 200), 100, 100);
}

// the game loop
void draw() {
  activateScene.Update();
  activateScene.Draw();
  block.noCollision();
  pu.pickup();
  jump.drawGravity();
  ca.drawAttack();
  hb.drawHealthbar();
  //cs.Draw();
}

void keyPressed() {
  hb.pressedKey();
  ca.pressed();
  jump.gravityPressed();
}

void keyReleased() {
  hb.releasedKey();
  ca.released();
  jump.gravityReleased();
}

void mousePressed() {
  //cs.pressed();
}
