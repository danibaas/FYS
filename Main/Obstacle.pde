class Obstacle extends Collider {
  int timer;
  final int WAIT_TIME = 4000;
  final int RESPAWN_MIN = 1300;
  final int RESPAWN_MAX = 1700;

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    obstacleList.add(this);
  }

  void updateObject() {
    if (gameOver.gameOver) {
      position.x = width + 2*boxWidth;
    }
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.OBSTACLE;
      player.healthbar.isDead = true;
    } else {
      player.collisionType = CollisionType.NONE;
      if (canWalk()) {
        moveEntity();
      }
      if (!boss.spawnBoss) {
        loopObstacle();
      }
    }
  }

  void loopObstacle() {
    if (position.x + boxWidth < 0 && canWalk()) {
      timer = millis(); 
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
    }
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = true;
      }
    }
  }

  void releasedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = false;
      }
    }
  }

  boolean canWalk() {
    boolean walk = false;
    if (timer + WAIT_TIME < millis()&&keys[2]) {
      walk = true;
    }
    return walk;
  }
}
