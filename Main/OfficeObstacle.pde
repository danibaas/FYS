class OfficeObstacle extends Obstacle implements Updater {
  int timer;
  int waitTime = 3000;

  OfficeObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    timer = millis();
    updateList.add(this);
  }

  void drawObject() {
    image(obstacle, position.x, position.y);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.OBSTACLE;
      if (player.collisionType == CollisionType.TOP) {
      }
    } else {
      player.collisionType = CollisionType.NONE;
    }
    moveEntity();
    //if (!boss.spawnBoss) {
    loopObstacle();
    //}
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
