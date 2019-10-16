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
      player.stopMoving = true;
      resolveCollision();
    } else {
      collisionType = CollisionType.NONE;
    }
    if (keys[2] && !player.hasCollision() && !player.stopMoving) { //als key[2] en !collision
      position.x = position.x - background.speed;
    } else if (keys[1] && !player.hasCollision() && !player.stopMoving) {
      position.x = position.x + background.speed;
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
          c.position.x += background.speed;
          player.stopMoving = true;
        }
      }
    } else if (collisionType == CollisionType.RIGHT) {
      for (Object j : updateList) {
        if (j instanceof Collider && !(j instanceof Player)) {
          Collider c = (Collider) j;
          c.position.x -= background.speed;
          player.stopMoving = true;
        }
      }
    } else if (collisionType == CollisionType.TOP) {
    } else {
      //under obstacle
    }
  }
}
