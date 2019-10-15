class Obstacle extends Collider implements Updater {
  boolean onObstacle;
  //PVector position;
  //float boxWidth, boxHeight;


  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    //this.position = position;
    //this.boxWidth = boxWidth;
    //this.boxHeight = boxHeight;
    updateList.add(this);
  }

  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      
    } else {
      if (keys[2] && !collidesWithPlayer(player)) { //als key[2] en !collision
        position.x = position.x - background.speed;
      } else if (keys[1] && !collidesWithPlayer(player)) {
        position.x = position.x + background.speed;
      }
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
