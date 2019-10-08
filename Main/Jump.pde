class Jump implements Updater {
  Gravity ball;

  Jump() { // object affected by gravity should be initialised in here
    ball = new Gravity();
    updateList.add(this);
  }

  void drawObject() { // draw everything that gravity handles
    ball.show();
    ball.move();
  }

  void updateObject() {
  }

  void pressedKey() {
    if (key == CODED) {
      if (keyCode == UP) {
        if (!ball.airBorne) {
          ball.jump();
          ball.setMove(keyCode, true);
        }
      } /*else if (keyCode == RIGHT) {
        ball.setMove(keyCode, true);
      } else if (keyCode == LEFT) {
        ball.setMove(keyCode, true);
      }*/
    }
  }

  void releasedKey() {
    ball.setMove(keyCode, false);
  }
}
