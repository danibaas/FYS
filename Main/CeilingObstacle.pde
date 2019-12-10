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
    if (dist(groundObstacle.position.x + groundObstacle.boxWidth, groundObstacle.position.y + groundObstacle.boxHeight, position.x, position.y) < 200) {
      position.x += 200;
    } else if (dist(groundObstacle.position.x, groundObstacle.position.y, position.x + boxWidth, position.y + boxHeight) < 200) {
      position.x -= 200;
    }
  }
}
