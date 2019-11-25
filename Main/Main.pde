import processing.sound.*;

//instance of this class, used for database
Main instance;
//object creation
HighScore highScore;
CharacterSelect characterSelect;
PrePlayScreen prePlayScreen;
Background background;
Enemy enemy;
Player player;
CharacterAttack characterAttack;
Fireball fireball;
GameOver gameOver;
GroundObstacle groundObstacle;
CeilingObstacle wireObstacle;
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

// PLAYER CONSTANTS
final PVector PLAYER_VECTOR = new PVector(140, height / 4);
final int PLAYER_WIDTH = 100;
final int PLAYER_HEIGHT = 100;
// ENEMY CONSTANTS
final PVector ENEMY_VECTOR = new PVector(2000, 596);
final int ENEMY_WIDTH = 100;
final int ENEMY_HEIGHT = 100;
// OBSTACLE CONSTANTS
// GROUND OBSTACLE CONSTANTS
final PVector OBSTACLE_VECTOR = new PVector(1300, 597);
final int OBSTACLE_WIDTH = 200;
final int OBSTACLE_HEIGHT = 100;
// CEILING OBSTACLE CONSTANTS
final PVector CEILING_VECTOR = new PVector(600, 0);
final int CEILING_OBSTACLE_WIDTH = 150;
final int CEILING_OBSTACLE_HEIGHT = 400;
// COFFE (SPEED BOOST) CONSTANTS
final PVector COFFEE_VECTOR = new PVector(600, 400);
final int COFFEE_WIDTH = 100;
final int COFFEE_HEIGHT = 100;
// BOSS CONSTANTS
final PVector BOSS_VECTOR = new PVector(600, 600);
final int BOSS_WIDTH = 100;
final int BOSS_HEIGHT = 100;

void setup() {
  // ratio 16:9
  updateList = new ArrayList();
  obstacleList = new ArrayList();
  collisionList = new ArrayList();
  size(1280, 720);
  instance = this;
  loadAssets();
  highScore = new HighScore();
  highScore.initializeDatabase();
  characterSelect = new CharacterSelect();
  background = new Background();
  player = new Player(PLAYER_VECTOR, PLAYER_WIDTH, PLAYER_HEIGHT);
  gameOver = new GameOver();
  enemy = new Enemy(ENEMY_VECTOR, ENEMY_WIDTH, ENEMY_HEIGHT);
  groundObstacle = new GroundObstacle(OBSTACLE_VECTOR, OBSTACLE_WIDTH, OBSTACLE_HEIGHT);
  wireObstacle = new CeilingObstacle(CEILING_VECTOR, CEILING_OBSTACLE_WIDTH, CEILING_OBSTACLE_HEIGHT);
  //lazers = new Lazers(new PVector(100, random(200, 550)), 1080, 30);
  characterAttack = new CharacterAttack();
  coffeePickup = new Coffee(COFFEE_VECTOR, COFFEE_WIDTH, COFFEE_HEIGHT);
  boss = new Boss(BOSS_VECTOR, BOSS_WIDTH, BOSS_HEIGHT);
} 

// the game loop
void draw() {
  if (gameOver.gameOver) {
    gameOver.drawObject();
  } else if (!characterSelect.hasChosen) {
    characterSelect.drawSelect();
    player.updateObject();
    soundTrack.loop();
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
