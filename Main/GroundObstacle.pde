class GroundObstacle extends Obstacle implements Updater {

  // Constructor
  GroundObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); // gives data to the constructor of the parent class (collider)
    updateList.add(this);
  }

  // Parent method (updater)
  void drawObject() {
    image(obstacle, position.x, position.y);
  }
}
