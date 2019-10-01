class Jump {
  Gravity ball;

  void setupGravity() { // object affected by gravity should be initialised in here
    ball = new Gravity();
  }

  void drawGravity() { // draw everything that gravity handles
    ball.show();
    if (ball.y < height-25) {
      ball.fall();
    }
    ball.move();
  }

  void gravityPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        if (!ball.airBorne) {
          ball.jump();
          ball.setMove(keyCode, true);
        }
      } else if (keyCode == RIGHT) {
        ball.setMove(keyCode, true);
      } else if (keyCode == LEFT) {
        ball.setMove(keyCode, true);
      }
    }
  }

  void gravityReleased() {
    ball.setMove(keyCode, false);
  }
}
