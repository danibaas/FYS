class Pickup extends Collider implements Updater {
  PImage skin;
  PVector position;
  //float boxWidth, boxHeight;

  Pickup(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    //this.position = position;
    //this.boxWidth = boxWidth;
    //this.boxHeight = boxHeight;
    skin = loadImage(sketchPath() + "/lib/healthkit.png");
    skin.resize((int) boxWidth, (int) boxHeight);
    //updateList.add(this);
  }

  void drawObject() {
    fill(255);
    rect(position.x, position.y, boxWidth, boxHeight);
    image(skin, position.x, position.y);
  }

  void updateObject() {
    if (collidesWithPlayer(player)) { // collision check
      healthbar.addHealth();
    }
    if (keys[2]) {
      position.x = position.x - background.speed;
    } else if (keys[1]) {
      position.x = position.x + background.speed;
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
