class Pickup extends Collision implements Updater {
  PImage skin;
  boolean doMove;

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
    if (keys[2] && doMove) {
      position.x = position.x - background.speed;
    } else if (keys[1] && doMove) {
      position.x = position.x + background.speed;
    }
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT && !obstacle.collision) {
        keys[2] = true;
        doMove = true;
      } else if (keyCode == LEFT && !obstacle.collision) {
        keys[1] = true;
        doMove = true;
      }
    }
  }

  void releasedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        keys[2] = false;
        doMove = false;
      } else if (keyCode == LEFT) {
        keys[1] = false;
        doMove = false;
      }
    }
  }
}
