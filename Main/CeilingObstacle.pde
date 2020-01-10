class CeilingObstacle extends Obstacle implements Updater {
  final int MIN_DISTANCE = 400;
  final int POSITION_FIX_INCREMENT = 10;

  CeilingObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); 
    updateList.add(this);
  }

  void drawObject() {
    image(ceilingObstacle, position.x, position.y);
    //println(dist(groundObstacle.position.x+groundObstacle.boxWidth, groundObstacle.position.y,position.x, position.y+boxHeight));
    fixLevel();
  }

  void fixLevel() {
    if (dist(groundObstacle.position.x+groundObstacle.boxWidth, groundObstacle.position.y, position.x, position.y+boxHeight) < MIN_DISTANCE) {
      position.x += POSITION_FIX_INCREMENT;
    }
  }
}
