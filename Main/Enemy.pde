class Enemy extends Collision {

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
  }

  void enemy() {
    if (collision == true) {
      healthbar.removeHealth();
    }
    rect(position.x, position.y, boxWidth, boxHeight);
  }
  void moveEnemy() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        position.x = position.x - background.speed;
      } else if (keyCode == LEFT) {
        position.x = position.x + background.speed;
      }
    }
  }
}
