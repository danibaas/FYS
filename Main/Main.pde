//instance of this class, used for database
Main instance;
//highscore class, handles highscore.
HighScore highScore;
//CharacterSelect cs;

Pickup pu;

//Background
Background bg;
//enemy
Enemy e;
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
  // activateScene = new StartScene();
  bg = new Background();
  hb = new Healthbar();
  hb.loadHealth();
  ca = new CharacterAttack();
  ca.loadAttack();
  // cs = new CharacterSelect();
  jump = new Jump();
  jump.setupGravity();
  go = new GameOver();
  pu = new Pickup(new PVector(300, 400), 100, 100);
  e = new Enemy(new PVector(500, 500), 100, 100);
}

// the game loop
void draw() {
  background(200);
  //activateScene.Update();
  //activateScene.Draw();
  bg.Movebg();
  bg.Displaybg();
  //  block.noCollision();
  e.noCollision();
  e.enemy();
  pu.noCollision();
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
