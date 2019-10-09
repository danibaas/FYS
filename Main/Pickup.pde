class Pickup extends Collision implements Updater {

  Pickup(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void updateObject() {
    if (collision) {
      healthbar.addHealth();
    }
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        position.x = position.x - background.speed;
      } else if (keyCode == LEFT) {
        position.x = position.x + background.speed;
      }
    }
  }

  void releasedKey() {
  }
}
