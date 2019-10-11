class Enemy extends Collision implements Updater {

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void updateObject() {
    if (collision == true) {
      healthbar.removeHealth();
    }
  }

  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT && !obstacle.collision) {
        position.x = position.x - background.speed;
      } else if (keyCode == LEFT && !obstacle.collision) {
        position.x = position.x + background.speed;
      }
    }
  }

  void releasedKey() {
  }
}
