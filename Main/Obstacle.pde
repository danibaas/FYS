class Obstacle extends Collider implements Updater {
  boolean onObstacle;

  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      
    }    
    if (keys[2] && !player.hasCollision()) { //als key[2] en !collision
      position.x = position.x - background.speed;
    } else if (keys[1] && !player.hasCollision()) {
      position.x = position.x + background.speed;
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
