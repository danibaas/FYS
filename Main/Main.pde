//instance of this class, used for database
Main instance;

//object creation
HighScore highScore;
//CharacterSelect characterSelect;
Pickup pickup;
Background background;
Enemy enemy;
Healthbar healthbar;
//gravity mechanic
Player player;
CharacterAttack characterAttack;
GameOver gameover;
Obstacle obstacle;

//collision & update loop lists
ArrayList<Collision> objList;
ArrayList<Updater> updateList;

void setup() {
  // ratio 16:9
  objList = new ArrayList();
  updateList = new ArrayList();
  size(1280, 720);
  instance = this;
  highScore = new HighScore();
  highScore.initializeDatabase();
  background = new Background();
  healthbar = new Healthbar();
  player = new Player();
  characterAttack = new CharacterAttack();
  //characterSelect = new CharacterSelect();
  gameover = new GameOver();
  pickup = new Pickup(new PVector(300, 400), 100, 100);
  enemy = new Enemy(new PVector(500, 500), 100, 100);
  obstacle = new Obstacle(new PVector(600, 600), 200, 100);
}

// the game loop
void draw() {
  background(200);
  for (Updater r : updateList) {
    r.drawObject();
    r.updateObject();
  }
  for (Collision c : objList) {
    c.noCollision();
  }
}

void keyPressed() {
  for (Updater r : updateList) {
    r.pressedKey();
  }
}

void keyReleased() {
  for (Updater r : updateList) {
    r.releasedKey();
  }
}
