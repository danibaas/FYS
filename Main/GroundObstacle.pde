class GroundObstacle extends Obstacle implements Updater {

  GroundObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    image(obstacle, position.x, position.y);
  }
}
