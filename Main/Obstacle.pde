class Obstacle extends Collider {
  int timer;
  final int WAIT_TIME = 3000;

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    timer = millis();
    obstacleList.add(this);
  }

  void updateObject() {
    if (gameOver.gameOver) {
      position.x = width + 2*boxWidth;
    }
    if (collidesWithPlayer(player)) {
      println("5hybgtrbgfbtrgf");
      player.colliderType = ColliderType.OBSTACLE;
      player.healthbar.isDead = true;
    } else {
      player.collisionType = CollisionType.NONE;
      moveEntity();
      if (!boss.spawnBoss) {
        loopObstacle();
      }
    }
  }

  void loopObstacle() {
    if (position.x + boxWidth < 0 && timer + WAIT_TIME < millis()) {
      timer = millis(); 
      position.x = width + 2*boxWidth;
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
