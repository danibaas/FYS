 class Pickup extends Collision {

  Pickup(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
  }

  void pickup() {
    if (collision) {
      healthbar.addHealth();
    }
    rect(position.x, position.y, boxWidth, boxHeight);
  }
}
