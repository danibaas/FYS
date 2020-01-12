class Obstacle extends Collider {
  int timer;
  int beginPosition = 1300;
  final int WAIT_TIME = 2000;
  final int RESPAWN_MIN = 1300;
  final int RESPAWN_MAX = 1700;

  // Constructor 
  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    obstacleList.add(this);
  }

  // Update method
  void updateObject() {
    if (collidesWithPlayer(player)) {
      player.healthbar.isDead = true;
    } else {
      if (!boss.spawnBoss) {
        loopObstacle();
        if (canWalk()) {
          moveEntity();
        }
      } else {
        if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) { // When the boss is active and the obstacle is in the screen, move it out of the screen
          moveEntity();
        }
      }
    }
  }

  // Method to make the obstacle move
  void loopObstacle() {
    if (position.x + boxWidth < 0 && canWalk()) {
      timer = millis(); 
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
    }
  }

  // Future parent method (ivm inheritance in ground- en ceilingobstacle
  void pressedKey() {
  }

  // Future parent method (ivm inheritance in ground- en ceilingobstacle 
  void releasedKey() {
  }

  // Method that checks if the obstacle can move (so cooldown and player must walk)
  boolean canWalk() {
    boolean walk = false;
    if (timer + WAIT_TIME < millis() && keys[2]) {
      walk = true;
    }
    return walk;
  }
}
