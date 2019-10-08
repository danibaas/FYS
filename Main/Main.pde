//instance of this class, used for database
Main instance;
//highscore class, handles highscore.
HighScore highScore;
//CharacterSelect cs;

Pickup pu;

//Background
Background bg;
//enemy
Enemy enemy;
//healthbar
Healthbar healthbar;
//gravity mechanic
Jump jump;
//character attack
CharacterAttack ca;
//game over screen
GameOver gameover;

void setup() {
  // ratio 16:9
  size(1280, 720);
  instance = this;
  highScore = new HighScore();
  highScore.initializeDatabase();
  bg = new Background();
  healthbar = new Healthbar();
  healthbar.loadHealth();
  ca = new CharacterAttack();
  ca.loadAttack();
  // cs = new CharacterSelect();
  jump = new Jump();
  jump.setupGravity();
  gameover = new GameOver();
  pu = new Pickup(new PVector(300, 400), 100, 100);
  enemy = new Enemy(new PVector(500, 500), 100, 100);
}

// the game loop
void draw() {
  background(200);
  bg.Displaybg();
  //  block.noCollision();
  enemy.noCollision();
  enemy.enemy();
  pu.noCollision();
  pu.pickup();
  jump.drawGravity();
  ca.drawAttack();
  healthbar.drawHealthbar();
  //cs.Draw();
}

void keyPressed() {
    bg.Movebg();
  healthbar.pressedKey();
  ca.pressed();
  //cs.pressed();
  //jump.gravityPressed();
}

void keyReleased() {
  healthbar.releasedKey();
  ca.released();
 jump.gravityReleased();
}
