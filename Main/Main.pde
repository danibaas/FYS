import processing.sound.*;

//instance of this class, used for database
Main instance;
//object creation
HighScore highScore;
CharacterSelect characterSelect;
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
final PVector PLAYER_VECTOR = new PVector(140, 646);
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
  characterSelect = new CharacterSelect();
  highScore = new HighScore();
} 

// the game loop
void draw() {
  if (!screenActive && !holdScreen) {
    if (gameOver.gameOver) {
      gameOver.drawObject();
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
  } else {
    if (!characterSelect.hasChosen) {
      characterSelect.drawSelect();
      soundTrack.loop();
    } else {
      drawScreen();
    }
  }
}  

void keyPressed() {
  if (!characterSelect.hasChosen) {
    characterSelect.pressed();
  } else {
    if (screenActive) {
      screenActive = false;
    }  
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
