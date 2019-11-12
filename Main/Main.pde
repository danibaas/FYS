//instance of this class, used for database
Main instance;
//object creation
HighScore highScore;
CharacterSelect characterSelect;
HealthPack healthPickup;
Background background;
Enemy enemy;
Healthbar healthbar;
Player player;
CharacterAttack characterAttack;
Fireball fireball;
GameOver gameOver;
OfficeObstacle office;
Lazers lazers;
Coffee coffeePickup;
Boss boss;

//collision & update loop lists
ArrayList<Updater> updateList;
ArrayList<Obstacle> obstacleList;
ArrayList<Collider> collisionList;

//movmement help
boolean[] keys = new boolean[4];
// 0 = up, 1 = left, 2 = right, 3 is down

void setup() {
  // ratio 16:9
  updateList = new ArrayList();
  obstacleList = new ArrayList();
  collisionList = new ArrayList();
  size(1280, 720);
  instance = this;
  highScore = new HighScore();
  highScore.initializeDatabase();
  characterSelect = new CharacterSelect();
  background = new Background();
  player = new Player(new PVector(140, height / 4), 100, 100);
  healthbar = new Healthbar();
  gameOver = new GameOver();
  healthPickup = new HealthPack(new PVector(300, 400), 100, 100);
  enemy = new Enemy(new PVector(500, 596), 100, 100);
  office = new OfficeObstacle(new PVector(650, 597), 200, 100);
  //lazers = new Lazers(new PVector(100, random(200, 550)), 1080, 30);
  characterAttack = new CharacterAttack();
  //coffeePickup = new Coffee(new PVector(600, 400), 100, 100);
  boss = new Boss(new PVector(600, 600), 100, 100);
} 

// the game loop
void draw() {
  println(background.backgroundPaneX, background.backgroundPane2X, background.backgroundPane3X);
  if (gameOver.gameOver) {
    gameOver.drawObject();
  } else if (!characterSelect.hasChosen) {
    characterSelect.drawSelect();
    player.updateObject();
  } else {
    for (Collider collider : collisionList) {
      collider.update();
    }
    for (Updater r : updateList) {
      r.updateObject();
      r.drawObject();
    }
    highScore.displayScore();
  }
}

void keyPressed() {
  if (!characterSelect.hasChosen) {
    characterSelect.pressed();
    player.updateSkin();
  } else {
    for (Updater r : updateList) {
      r.pressedKey();
    }
  }
}

void keyReleased() {
  for (Updater r : updateList) {
    r.releasedKey();
  }
}
