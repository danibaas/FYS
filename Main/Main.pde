//instance of this class, used for database
Main instance;
//highscore class, handles highscore.
HighScore highScore;
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
  background(200);
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
  //cs.pressed();
  jump.gravityPressed();
}

void keyReleased() {
  hb.releasedKey();
  ca.released();
  jump.gravityReleased();
}
