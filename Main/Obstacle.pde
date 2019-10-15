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
    if (collidesWithPlayer(player)) {
      if (collisionType == CollisionType.LEFT) {
        //player.playerVector.x = position.x - player.playerSize/2;
        player.stopMoving = true;
      } else if (collisionType == CollisionType.RIGHT) {
        //player.playerVector.x = position.x + boxWidth + player.playerSize;
        player.stopMoving = true;
      } else if (collisionType == CollisionType.TOP) {
        
      } else {
        //under obstacle
      }
    } else {
      collisionType = CollisionType.NONE;
      player.stopMoving = false;
    }
    if (!player.stopMoving) {
      if (keys[2] && !player.hasCollision()) { //als key[2] en !collision
        position.x = position.x - background.speed;
      } else if (keys[1] && !player.hasCollision()) {
        position.x = position.x + background.speed;
      }
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
