class Obstacle extends Collider implements Updater {
  boolean playerOnObstacle;

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void updateObject() {
    println(player.playerVector.x, position.x, enemy.position.x, pickup.position.x);
    if (collidesWithPlayer(player)) {
      resolveCollision();
    } else {
      collisionType = CollisionType.NONE;
      moveEntity(false);
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void resolveCollision() {
    if (collisionType == CollisionType.LEFT) {
      for (Object j : updateList) {
        if (j instanceof Collider && !(j instanceof Player)) {
          Collider c = (Collider) j;
          c.moveEntity(true);
        }
      }
      background.turnOff();
    } else if (collisionType == CollisionType.RIGHT) {
      for (Object j : updateList) {
        if (j instanceof Collider && !(j instanceof Player)) {
          Collider c = (Collider) j;
          c.moveEntity(true);
        }
      }
      background.turnOff();
    } else if (collisionType == CollisionType.TOP) {
    } else {
      //under obstacle
    }
    player.stopMoving = true;
  }
}
