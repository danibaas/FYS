//instance of this class, used for database
Main instance;

//object creation
HighScore highScore;
//CharacterSelect characterSelect;
Pickup pickup;
Background background;
Enemy enemy;
Healthbar healthbar;
Player player;
CharacterAttack characterAttack;
GameOver gameOver;
Obstacle obstacle;
Lazers lazers;

//collision & update loop lists
//ArrayList<Collision> objList;
ArrayList<Updater> updateList;

//movmement help
boolean[] keys = new boolean[4];
// 0 = up, 1 = left, 2 = right, 3 is down

void setup() {
  // ratio 16:9
  //objList = new ArrayList();
  updateList = new ArrayList();
  size(1280, 720);
  instance = this;
  highScore = new HighScore();
  highScore.initializeDatabase();
  background = new Background();
  healthbar = new Healthbar();
  player = new Player(new PVector(140, height / 4), 50);
  characterAttack = new CharacterAttack();
  //characterSelect = new CharacterSelect();
  gameOver = new GameOver();
  pickup = new Pickup(new PVector(300, 400), 100, 100);
  enemy = new Enemy(new PVector(500, 500), 100, 100);
  obstacle = new Obstacle(new PVector(600, 600), 200, 100);
  lazers = new Lazers(new PVector(100, random(60, 720)), 1080, 30);
}

// the game loop
void draw() {
  background(200);
  if (gameOver.gameOver) {
    gameOver.drawObject();
  } else {
    for (Updater r : updateList) {
      r.updateObject();
      r.drawObject();
      
    }
    //lazers.timeLazers();
    highScore.displayScore();
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
