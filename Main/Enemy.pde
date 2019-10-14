class Enemy extends Collision implements Updater {
  PImage skin;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    skin = loadImage(sketchPath() + "/lib/enemy.png");
    skin.resize((int) boxWidth + 10, (int) boxHeight + 10);
    updateList.add(this);
  }

  void updateObject() {
    if (collision == true) {
      healthbar.removeHealth();
    }
  }

  void drawObject() {
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    pushMatrix();
    translate(position.x + 100, position.y);
    scale(-1, 1);
    image(skin, 0, 0);
    popMatrix();
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
