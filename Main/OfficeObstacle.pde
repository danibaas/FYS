class OfficeObstacle extends Obstacle implements Updater {
  PImage obstacle;
  int timer;
  int waitTime = 3000;

  OfficeObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    obstacle = loadImage(sketchPath() + "/lib/office.png");
    obstacle.resize((int) boxWidth, (int) boxHeight);
    timer = millis();
    updateList.add(this);
  }

  void drawObject() {
    image(obstacle, position.x, position.y);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.OBSTACLE;
      resolveCollision();
      player.stopMoving = true;
      if (player.collisionType == CollisionType.TOP) {
        player.stopMoving = false;
      }
    } else {
      int playerRadiusW = player.playerWidth / 2;
      if (playerOnObstacle && (player.playerVector.x + playerRadiusW < position.x || player.playerVector.x - playerRadiusW > position.x + boxWidth)) {
        playerOnObstacle = false;
      }
      player.collisionType = CollisionType.NONE;
      background.turnOn();
    }
    moveEntity(false);
    if (!boss.spawnBoss) {
      loopObstacle();
    }
  }

  void loopObstacle() {
    if (position.x + boxWidth < 0 && timer + waitTime < millis()) {
      timer = millis(); 
      position.x = width + 2*boxWidth;
    }
  }  

  void pressedKey() {
  }

  void releasedKey() {
  }
}
