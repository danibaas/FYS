class CeilingObstacle extends Obstacle implements Updater {

  CeilingObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); 
    updateList.add(this);
  }

  void drawObject() {
    image(ceilingObstacle, position.x, position.y);
  }
}
