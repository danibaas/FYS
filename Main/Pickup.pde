class Pickup extends Collision implements Updater {
  PImage skin;

  Pickup(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    skin = loadImage(sketchPath() + "/lib/healthkit.png");
    skin.resize((int) boxWidth, (int) boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    image(skin, position.x, position.y);
  }

  void updateObject() {
    if (collision) {
      healthbar.addHealth();
    }
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
