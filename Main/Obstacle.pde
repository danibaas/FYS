class Obstacle extends Collider {
  boolean playerOnObstacle;

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    playerOnObstacle = false;
    obstacleList.add(this);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.OBSTACLE;
      resolveCollision();
      player.stopMoving = true;
    } else {
      int playerRadiusW = player.playerWidth / 2;
      if (playerOnObstacle && (player.playerVector.x + playerRadiusW < position.x || player.playerVector.x - playerRadiusW > position.x + boxWidth)) {
        playerOnObstacle = false;
      }
      collisionType = CollisionType.NONE;
      moveEntity(false);
    }
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
      playerOnObstacle = true;
    }
  }
}
