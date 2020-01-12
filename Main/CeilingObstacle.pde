class CeilingObstacle extends Obstacle implements Updater {
  final int MIN_DISTANCE = 400;
  final int POSITION_FIX_INCREMENT = 10;
  // Constructor
  CeilingObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); // gives data to the constructor of the parent class (collider)
    updateList.add(this);
  }
  // Parent method (updater)
  void drawObject() {
    image(ceilingObstacle, position.x, position.y);
    fixLevel();
  }
// makes sure obstacles don't spawn in the same position
  void fixLevel() {
    if (dist(groundObstacle.position.x+groundObstacle.boxWidth, groundObstacle.position.y, position.x, position.y+boxHeight) < MIN_DISTANCE) {
      position.x += POSITION_FIX_INCREMENT;
    }
  }
}
