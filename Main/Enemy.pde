class Enemy extends Collider implements Updater {
  PImage skin;
  PVector position;
  float boxWidth, boxHeight;

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    skin = loadImage(sketchPath() + "/lib/enemy.png");
    skin.resize((int) boxWidth + 10, (int) boxHeight + 10);
    updateList.add(this);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) {
      healthbar.removeHealth();
    }
    if (keys[2]) { //als keys[2] en !collision
      position.x = position.x - background.speed;
    } else if (keys[1]) {
      position.x = position.x + background.speed;
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
  }

  void releasedKey() {
  }
}
