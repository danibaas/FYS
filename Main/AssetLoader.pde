// IMAGES
PImage backgroundImage;
PImage backgroundpane;
PImage backgroundpane2;
PImage backgroundpane3;
PImage fireBall;
PImage fireBallSpecial;
PImage skinDonDon;
PImage skinCorra;
PImage defaultSkin;
PImage coffee;
PImage skinEnemy;
PImage health;
PImage stroopwafel;
PImage obstacle;

// FONTS
PFont eightBit;

// MAGIC NUMBER PREVENTION
final int BACKGROUND_WIDTH = 640;
final int BACKGROUND_HEIGHT = 800;
final int STROOPWAFEL_SIZE = 35;

void loadAssets() {
  // BACKGROUND
  backgroundImage = loadImage(sketchPath() + "/assets/images/background.png");
  backgroundpane = loadImage(sketchPath() + "/assets/images/backgroundpane1.png");
  backgroundpane.resize(BACKGROUND_WIDTH, BACKGROUND_HEIGHT);
  backgroundpane2 = loadImage(sketchPath() + "/assets/images/backgroundpane2.png");
  backgroundpane2.resize(BACKGROUND_WIDTH, BACKGROUND_HEIGHT);
  backgroundpane3 = loadImage(sketchPath() + "/assets/images/backgroundpane3.png");
  backgroundpane3.resize(BACKGROUND_WIDTH, BACKGROUND_HEIGHT);

  // PLAYER ATTACKS
  fireBall = loadImage(sketchPath() + "/assets/images/Fireball.jpg");
  fireBallSpecial = loadImage(sketchPath() + "/assets/images/FireballSpecial.jpg");

  // PLAYER SKINS
  skinDonDon = loadImage(sketchPath() + "/assets/images/dondon.png");
  skinDonDon.resize(PLAYER_WIDTH, PLAYER_HEIGHT);
  skinCorra = loadImage(sketchPath() + "/assets/images/corra.png");
  skinCorra.resize(PLAYER_WIDTH, PLAYER_HEIGHT);
  defaultSkin = loadImage(sketchPath() + "/assets/images/player.png");

  // COFFEE
  coffee = loadImage(sketchPath() + "/assets/images/coffee.png");
  coffee.resize(COFFEE_WIDTH, COFFEE_HEIGHT);

  // ENEMY
  skinEnemy = loadImage(sketchPath() + "/assets/images/enemy.png");
  skinEnemy.resize(ENEMY_WIDTH + 10, ENEMY_HEIGHT + 10);

  // HEALTH PICKUP
  health = loadImage(sketchPath() + "/assets/images/healthkit.png");
  health.resize(HEALTH_WIDTH, HEALTH_HEIGHT);

  // STROOPWAFEL (HEALTH DISPLAY)
  stroopwafel = loadImage(sketchPath() + "/assets/images/stroopwafel.jpg");
  stroopwafel.resize(STROOPWAFEL_SIZE, STROOPWAFEL_SIZE);

  // OBSTACLE
  obstacle = loadImage(sketchPath() + "/assets/images/office.png");
  obstacle.resize(OBSTACLE_WIDTH, OBSTACLE_HEIGHT);

  // FONTS
  eightBit = createFont(sketchPath() + "/assets/fonts/PressStart2P.ttf", 30);
}
