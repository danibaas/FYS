class Obstacle extends Collision implements Updater {
  boolean onObstacle = false;
  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }
  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void updateObject() {
    PVector play = new PVector(player.xObject, player.yObject);

    /*if (play.y > position.y &&
     play.x + radius > position.x &&
     play.x < position.x + boxWidth) {
     player.yObject = constrain(player.yObject + player.movement*(int(player.isDown) - int(player.isUp))-boxHeight, radius, height - radius);
     onObstacle = true;
     } else {
     onObstacle=false;
     }*/
  }


  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT&&!collision) {
        position.x = position.x - background.speed;
      } else if (keyCode == LEFT&& !collision) {
        position.x = position.x + background.speed;
      }
    }
  }

  void releasedKey() {
  }
}
