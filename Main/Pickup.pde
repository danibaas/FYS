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
  void movePickup() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        position.x = position.x - background.speed;

      } else if (keyCode == LEFT) {
        position.x = position.x + background.speed;

      }
    }
  }
}
