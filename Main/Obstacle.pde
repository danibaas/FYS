class Obstacle extends Collider {
  int timer;
  final int WAIT_TIME = 2000;
  final int RESPAWN_MIN = 1300;
  final int RESPAWN_MAX = 1700;
  int beginPosition = 1300;

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    obstacleList.add(this);
  }

  void updateObject() {
    if (gameOver.gameOver) {
      //timer = millis();
      //position.x = beginPosition;
      //println("active");
    }
    if (collidesWithPlayer(player)) {
      player.healthbar.isDead = true;
    } else {
      if (!boss.spawnBoss) {
        loopObstacle();
        if (canWalk()) {
          moveEntity();
        }
      } else {
        if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) {
          moveEntity();
        }
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
  }

  void releasedKey() {
  }

  boolean canWalk() {
    boolean walk = false;
    if (timer + WAIT_TIME < millis() && keys[2]) {
      walk = true;
    }
    return walk;
  }
}
