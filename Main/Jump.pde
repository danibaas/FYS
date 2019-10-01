class Jump {
  Gravity ball;

  void setupGravity() { // object affected by gravity should be initialised in here
    ball = new Gravity();
  }

  void drawGravity() { // draw everything that gravity handles
    ball.show();
    ball.fall();
    ball.move();
  }

  void gravityPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        ball.jump();
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
