class Jump {
  Gravity ball;

  void setupGravity() { // object affected by gravity should be initialised in here
    ball = new Gravity();
  }

  void drawGravity() { // draw everything that gravity handles
    ball.show();
    ball.fall();
  }

  void gravityPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        ball.jump();
      } else if (keyCode == RIGHT) {
        ball.rightmovement();
      } else if (key == LEFT) {
        ball.leftmovement();
      }
    }
  }
}
