class Obstacle extends Collider {

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    obstacleList.add(this);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      player.colliderType = ColliderType.OBSTACLE;
      player.healthbar.isDead = true;
    } else {
      player.collisionType = CollisionType.NONE;
      moveEntity();
    }
  }
}
