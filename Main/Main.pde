import processing.sound.*;

//instance of this class, used for database
Main instance;
//object creation
Reset reset;
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
Coffee coffeePickup;
Boss boss;
Login login;
Shop shop;
Money money;
Metrics metrics;

//collision & update loop lists
ArrayList<Updater> updateList;
ArrayList<Obstacle> obstacleList;
ArrayList<Collider> collisionList;

ArrayList<particle> particles;

//movmement help
boolean[] keys = new boolean[4];
// 0 = up, 1 = left, 2 = right, 3 is down

// PLAYER CONSTANTS
final PVector PLAYER_VECTOR = new PVector(140, 646);
final int PLAYER_WIDTH = 100;
final int PLAYER_HEIGHT = 100;
// ENEMY CONSTANTS
final PVector ENEMY_VECTOR = new PVector(2000, 596);
final int ENEMY_WIDTH = 80;
final int ENEMY_HEIGHT = 100;
// OBSTACLE CONSTANTS
// GROUND OBSTACLE CONSTANTS
final PVector OBSTACLE_VECTOR = new PVector(1300, 597);
final int OBSTACLE_WIDTH = 200;
final int OBSTACLE_HEIGHT = 100;
// CEILING OBSTACLE CONSTANTS
final PVector CEILING_VECTOR = new PVector(-300, 0);
final int CEILING_OBSTACLE_WIDTH = 125;
final int CEILING_OBSTACLE_HEIGHT = 600;
// COFFEE (SPEED BOOST) CONSTANTS
final PVector COFFEE_VECTOR = new PVector(2000, 400);
final int COFFEE_WIDTH = 100;
final int COFFEE_HEIGHT = 100;
// BOSS CONSTANTS
final PVector BOSS_VECTOR = new PVector(-500, 300);
final int BOSS_WIDTH = 200;
final int BOSS_HEIGHT = 200;
// SHOP CONSTANTS
final int ICON_SIZE = 100;
final int SPEED_SIZE = 100;
// COIN CONSTANT;
final int COIN_SIZE = 50;

void setup() {
  // ratio 16:9
  surface.setTitle("Corra & DonDon's Adventure");
  surface.hideCursor();
  updateList = new ArrayList();
  obstacleList = new ArrayList();
  collisionList = new ArrayList();
  particles = new ArrayList();
  size(1280, 720);
  instance = this;
  initializeDatabase();
  loadAssets();
  characterSelect = new CharacterSelect();
  highScore = new HighScore();
  login = new Login();
  shop = new Shop();
  metrics = new Metrics();
  shop.insertItems();
  reset = new Reset();
  initializeAchievements();
  thread("endAchievements");
} 

// the game loop
void draw() {
  if (!screenActive && !holdScreen) {
    if (gameOver.gameOver) {
      gameOver.drawObject();
      gameOver.pressedKey();
      gameOver.releasedKey();
      reset.drawObject();
    } else {
      for (Updater r : updateList) {
        if (!(r instanceof CeilingObstacle)) {
          r.updateObject();
          r.drawObject();
        } else {
          if (highScore.highScore > 50) {
            r.updateObject();
            r.drawObject();
          }
        }
      }

    for (int i = particles.size()-1; i >= 0; i--) { 
      particle particle = particles.get(i);
      particle.move();
      particle.drawParticle();
      if (particle.particleLife <= 0) {
        particles.remove(i);
      }
    }
    addParticle();
      highScore.displayScore();
      scoreAchievements();
      thread("endAchievements");
    }
  } else {
    if (!characterSelect.hasChosen) {
      characterSelect.drawSelect();
      //soundTrack.loop();
    } else {
      drawScreen();
      shop.drawShop();
      metrics.drawStatistics();
    }
  }
}  

void stop() {
   sql.close(); 
}

void keyPressed() {
  if (!characterSelect.hasChosen) {
    characterSelect.pressed();
  } else {
    if (key != 'c' && key != 'C' && key != 'v' && screenActive) {
      screenActive = false;
    }  
    for (Updater r : updateList) {
      r.pressedKey();
    }
    shop.pressedKey();
    metrics.pressedKey();
  }
}

void keyReleased() {
  for (Updater r : updateList) {
    r.releasedKey();
  }
}
