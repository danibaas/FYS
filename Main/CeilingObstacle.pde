class CeilingObstacle extends Obstacle implements Updater {

  CeilingObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); 
    updateList.add(this);
  }

  void drawObject() {
    image(ceilingObstacle, position.x, position.y);
    fixLevel();
  }

  void fixLevel() {
    if (dist(groundObstacle.position.x, groundObstacle.position.y, position.x, position.y) < 50) {
      position.x += 50;
    }
  }
}
