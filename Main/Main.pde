//instance of this class, used for database
Main instance;
//highscore class, handles highscore.
HighScore highScore;
//CharacterSelect cs;

Pickup pickup;

//Background
Background background;
//enemy
Enemy enemy;
//healthbar
Healthbar healthbar;
//gravity mechanic
Jump jump;
//character attack
CharacterAttack characterAttack;
//game over screen
GameOver gameover;

void setup() {
  // ratio 16:9
  size(1280, 720);
  instance = this;
  highScore = new HighScore();
  highScore.initializeDatabase();
  background = new Background();
  healthbar = new Healthbar();
  healthbar.loadHealth();
  characterAttack = new CharacterAttack();
  characterAttack.loadAttack();
  // cs = new CharacterSelect();
  jump = new Jump();
  jump.setupGravity();
  gameover = new GameOver();
  pickup = new Pickup(new PVector(300, 400), 100, 100);
  enemy = new Enemy(new PVector(500, 500), 100, 100);
}

// the game loop
void draw() {
  background(200);
  background.Displaybg();
  //  block.noCollision();
  enemy.noCollision();
  enemy.enemy();
  pickup.noCollision();
  pickup.pickup();
  jump.drawGravity();
  characterAttack.drawAttack();
  characterAttack.drawBeam();
  healthbar.drawHealthbar();
  //cs.Draw();
  background.Ground();
}

void keyPressed() {
    background.Movebg();
  healthbar.pressedKey();
  characterAttack.pressed();
  enemy.moveEnemy();
  pickup.movePickup();
  //cs.pressed();
  //jump.gravityPressed();
}

void keyReleased() {
  healthbar.releasedKey();
  characterAttack.released();
 jump.gravityReleased();
}
