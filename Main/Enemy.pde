class Enemy extends Collision {

  Enemy(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
  }

  void enemy() {
    if (collision == true) {
      healthbar.removeHealth();
    }
    rect(position.x,position.y,boxWidth,boxHeight);
  }
}
